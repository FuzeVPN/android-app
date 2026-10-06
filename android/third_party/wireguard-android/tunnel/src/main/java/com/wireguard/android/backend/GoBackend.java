/*
 * Copyright © 2017-2025 WireGuard LLC. All Rights Reserved.
 * SPDX-License-Identifier: Apache-2.0
 */

package com.wireguard.android.backend;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.content.pm.ServiceInfo;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.os.Handler;
import android.os.Looper;
import android.os.ParcelFileDescriptor;
import android.system.OsConstants;
import android.util.Log;

import com.wireguard.android.backend.BackendException.Reason;
import com.wireguard.android.backend.Tunnel.State;
import com.wireguard.android.util.SharedLibraryLoader;
import com.wireguard.config.Config;
import com.wireguard.config.InetEndpoint;
import com.wireguard.config.InetNetwork;
import com.wireguard.config.Peer;
import com.wireguard.crypto.Key;
import com.wireguard.crypto.KeyFormatException;
import com.wireguard.util.NonNullForAll;

import java.net.InetAddress;
import java.util.Collections;
import java.util.Set;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;

import androidx.annotation.Nullable;
import androidx.collection.ArraySet;

/**
 * Implementation of {@link Backend} that uses the wireguard-go userspace implementation to provide
 * WireGuard tunnels.
 */
@NonNullForAll
public final class GoBackend implements Backend {
    private static final int DNS_RESOLUTION_RETRIES = 10;
    private static final String TAG = "WireGuard/GoBackend";
    private static final String ACTION_APP_START_HOST =
            "com.wireguard.android.backend.GoBackend.START_HOST";
    private static final String EXTRA_APP_HOST_START = "app_host_start";
    @Nullable private static AlwaysOnCallback alwaysOnCallback;
    @Nullable private static volatile HostLifecycleListener hostLifecycleListener;
    @Nullable private static volatile ForegroundNotificationFactory foregroundNotificationFactory;
    private static volatile CompletableFuture<VpnService> vpnService = new CompletableFuture<>();
    private static final ExecutorService fallbackCleanupExecutor = Executors.newSingleThreadExecutor(runnable -> {
        final Thread thread = new Thread(runnable, "WireGuard host cleanup");
        thread.setDaemon(true);
        return thread;
    });
    private final Context context;
    @Nullable private Config currentConfig;
    @Nullable private Tunnel currentTunnel;
    private int currentTunnelHandle = -1;

    /**
     * Public constructor for GoBackend.
     *
     * @param context An Android {@link Context}
     */
    public GoBackend(final Context context) {
        SharedLibraryLoader.loadSharedLibrary(context, "wg-go");
        this.context = context;
    }

    /**
     * Set a {@link AlwaysOnCallback} to be invoked when {@link VpnService} is started by the
     * system's Always-On VPN mode.
     *
     * @param cb Callback to be invoked
     */
    public static void setAlwaysOnCallback(final AlwaysOnCallback cb) {
        alwaysOnCallback = cb;
    }

    /**
     * Sets the embedding application's system-service event listener. Callbacks run on Android's
     * service thread and must return promptly; tunnel cleanup belongs to the embedding controller.
     */
    public static void setHostLifecycleListener(@Nullable final HostLifecycleListener listener) {
        hostLifecycleListener = listener;
    }

    /** Starts the one shared Android VPN host without requiring an activity or Flutter engine. */
    public static boolean startHost(final Context context) {
        if (getActiveHost() != null || vpnService.isDone())
            return true;
        final Intent intent = new Intent(context, VpnService.class)
                .setAction(ACTION_APP_START_HOST)
                .putExtra(EXTRA_APP_HOST_START, true);
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O)
                context.startForegroundService(intent);
            else
                context.startService(intent);
            return true;
        } catch (final IllegalStateException | SecurityException error) {
            Log.e(TAG, "Unable to start shared VPN host", error);
            return false;
        }
    }

    /** Returns the running shared Android VPN host, or {@code null} after its destruction starts. */
    @Nullable public static VpnService getActiveHost() {
        return VpnService.foregroundService;
    }

    /** Stops only the shared Android VPN host; it never tears down either tunnel engine itself. */
    public static void stopHost() {
        final VpnService service = getActiveHost();
        if (service != null)
            service.stopSelf();
    }

    /**
     * Supplies the notification used by the service that owns WireGuard's TUN.
     * The embedding application can update its localized content and then call
     * {@link VpnService#refreshForegroundNotification()}.
     */
    public static void setForegroundNotificationFactory(@Nullable final ForegroundNotificationFactory factory) {
        foregroundNotificationFactory = factory;
        VpnService.refreshForegroundNotification();
    }

    public interface ForegroundNotificationFactory {
        @Nullable Notification create(Context context);
    }

    @Nullable private static native String wgGetConfig(int handle);

    private static native int wgGetSocketV4(int handle);

    private static native int wgGetSocketV6(int handle);

    private static native void wgTurnOff(int handle);

    private static native int wgTurnOn(String ifName, int tunFd, String settings);

    /** Applies peer state after the Android VPN service has protected the already-bound sockets. */
    private static native int wgSetConfig(int handle, String settings);

    private static native String wgVersion();

    /**
     * Method to get the names of running tunnels.
     *
     * @return A set of string values denoting names of running tunnels.
     */
    @Override
    public Set<String> getRunningTunnelNames() {
        if (currentTunnel != null) {
            final Set<String> runningTunnels = new ArraySet<>();
            runningTunnels.add(currentTunnel.getName());
            return runningTunnels;
        }
        return Collections.emptySet();
    }

    /**
     * Get the associated {@link State} for a given {@link Tunnel}.
     *
     * @param tunnel The tunnel to examine the state of.
     * @return {@link State} associated with the given tunnel.
     */
    @Override
    public State getState(final Tunnel tunnel) {
        return currentTunnel == tunnel ? State.UP : State.DOWN;
    }

    /**
     * Get the associated {@link Statistics} for a given {@link Tunnel}.
     *
     * @param tunnel The tunnel to retrieve statistics for.
     * @return {@link Statistics} associated with the given tunnel.
     */
    @Override
    public Statistics getStatistics(final Tunnel tunnel) {
        final Statistics stats = new Statistics();
        if (tunnel != currentTunnel || currentTunnelHandle == -1)
            return stats;
        final String config = wgGetConfig(currentTunnelHandle);
        if (config == null)
            return stats;
        Key key = null;
        long rx = 0;
        long tx = 0;
        long latestHandshakeMSec = 0;
        for (final String line : config.split("\\n")) {
            if (line.startsWith("public_key=")) {
                if (key != null)
                    stats.add(key, rx, tx, latestHandshakeMSec);
                rx = 0;
                tx = 0;
                latestHandshakeMSec = 0;
                try {
                    key = Key.fromHex(line.substring(11));
                } catch (final KeyFormatException ignored) {
                    key = null;
                }
            } else if (line.startsWith("rx_bytes=")) {
                if (key == null)
                    continue;
                try {
                    rx = Long.parseLong(line.substring(9));
                } catch (final NumberFormatException ignored) {
                    rx = 0;
                }
            } else if (line.startsWith("tx_bytes=")) {
                if (key == null)
                    continue;
                try {
                    tx = Long.parseLong(line.substring(9));
                } catch (final NumberFormatException ignored) {
                    tx = 0;
                }
            } else if (line.startsWith("last_handshake_time_sec=")) {
                if (key == null)
                    continue;
                try {
                    latestHandshakeMSec += Long.parseLong(line.substring(24)) * 1000;
                } catch (final NumberFormatException ignored) {
                    latestHandshakeMSec = 0;
                }
            } else if (line.startsWith("last_handshake_time_nsec=")) {
                if (key == null)
                    continue;
                try {
                    latestHandshakeMSec += Long.parseLong(line.substring(25)) / 1000000;
                } catch (final NumberFormatException ignored) {
                    latestHandshakeMSec = 0;
                }
            }
        }
        if (key != null)
            stats.add(key, rx, tx, latestHandshakeMSec);
        return stats;
    }

    /**
     * Get the version of the underlying wireguard-go library.
     *
     * @return {@link String} value of the version of the wireguard-go library.
     */
    @Override
    public String getVersion() {
        return wgVersion();
    }

    /**
     * Determines if the service is running in always-on VPN mode.
     * @return {@link boolean} whether the service is running in always-on VPN mode.
     */
    @Override
    public boolean isAlwaysOn() throws ExecutionException, InterruptedException, TimeoutException {
        return vpnService.get(0, TimeUnit.NANOSECONDS).isAlwaysOn();
    }

    /**
     * Determines if the service is running in always-on VPN lockdown mode.
     * @return {@link boolean} whether the service is running in always-on VPN lockdown mode.
     */
    @Override
    public boolean isLockdownEnabled() throws ExecutionException, InterruptedException, TimeoutException {
        return vpnService.get(0, TimeUnit.NANOSECONDS).isLockdownEnabled();
    }

    /**
     * Change the state of a given {@link Tunnel}, optionally applying a given {@link Config}.
     *
     * @param tunnel The tunnel to control the state of.
     * @param state  The new state for this tunnel. Must be {@code UP}, {@code DOWN}, or
     *               {@code TOGGLE}.
     * @param config The configuration for this tunnel, may be null if state is {@code DOWN}.
     * @return {@link State} of the tunnel after state changes are applied.
     * @throws Exception Exception raised while changing tunnel state.
     */
    @Override
    public synchronized State setState(final Tunnel tunnel, State state, @Nullable final Config config) throws Exception {
        final State originalState = getState(tunnel);

        if (state == State.TOGGLE)
            state = originalState == State.UP ? State.DOWN : State.UP;
        if (state == originalState && tunnel == currentTunnel && config == currentConfig)
            return originalState;
        if (state == State.UP) {
            final Config originalConfig = currentConfig;
            final Tunnel originalTunnel = currentTunnel;
            if (currentTunnel != null)
                setStateInternal(currentTunnel, null, State.DOWN);
            try {
                setStateInternal(tunnel, config, state);
            } catch (final Exception e) {
                // A failed two-phase start may retain the new handle solely so
                // a later DOWN can close it. Restoring the old tunnel in that
                // state would mistake the retained handle for a running old
                // engine and abandon the cleanup target.
                if (originalTunnel != null && !(currentTunnel == tunnel && currentTunnelHandle != -1))
                    setStateInternal(originalTunnel, originalConfig, State.UP);
                throw e;
            }
        } else if (state == State.DOWN && tunnel == currentTunnel) {
            setStateInternal(tunnel, null, State.DOWN);
        }
        return getState(tunnel);
    }

    private void setStateInternal(final Tunnel tunnel, @Nullable final Config config, final State state)
            throws Exception {
        Log.i(TAG, "Bringing tunnel " + tunnel.getName() + ' ' + state);

        if (state == State.UP) {
            if (config == null)
                throw new BackendException(Reason.TUNNEL_MISSING_CONFIG);

            if (VpnService.prepare(context) != null)
                throw new BackendException(Reason.VPN_NOT_AUTHORIZED);

            if (!vpnService.isDone()) {
                Log.d(TAG, "Requesting to start VpnService");
                if (!startHost(context))
                    throw new BackendException(Reason.UNABLE_TO_START_VPN);
            }
            final VpnService service = vpnService.get(2, TimeUnit.SECONDS);
            service.setOwner(this);

            if (currentTunnelHandle != -1) {
                Log.w(TAG, "Tunnel already up");
                return;
            }


            dnsRetry: for (int i = 0; i < DNS_RESOLUTION_RETRIES; ++i) {
                // Pre-resolve IPs so they're cached when building the userspace string
                for (final Peer peer : config.getPeers()) {
                    final InetEndpoint ep = peer.getEndpoint().orElse(null);
                    if (ep == null)
                        continue;
                    if (ep.getResolved().orElse(null) == null) {
                        if (i < DNS_RESOLUTION_RETRIES - 1) {
                            Log.w(TAG, "DNS host \"" + ep.getHost() + "\" failed to resolve; trying again");
                            Thread.sleep(1000);
                            continue dnsRetry;
                        } else
                            throw new BackendException(Reason.DNS_RESOLUTION_FAILURE, ep.getHost());
                    }
                }
                break;
            }

            // Bring the device up with interface settings only. Device.Up binds
            // its UDP sockets; peers are deliberately withheld until Android
            // has protected those exact descriptors below. Re-sending
            // listen_port later would rebind and lose that protection.
            final String interfaceConfig = config.getInterface().toWgUserspaceString();
            final String peerConfig = peerConfig(config);

            // Create the vpn tunnel with android API
            final VpnService.Builder builder = service.getBuilder();
            builder.setSession(tunnel.getName());

            for (final String excludedApplication : config.getInterface().getExcludedApplications())
                builder.addDisallowedApplication(excludedApplication);

            for (final String includedApplication : config.getInterface().getIncludedApplications())
                builder.addAllowedApplication(includedApplication);

            for (final InetNetwork addr : config.getInterface().getAddresses())
                builder.addAddress(addr.getAddress(), addr.getMask());

            for (final InetAddress addr : config.getInterface().getDnsServers())
                builder.addDnsServer(addr.getHostAddress());

            for (final String dnsSearchDomain : config.getInterface().getDnsSearchDomains())
                builder.addSearchDomain(dnsSearchDomain);

            boolean sawDefaultRoute = false;
            for (final Peer peer : config.getPeers()) {
                for (final InetNetwork addr : peer.getAllowedIps()) {
                    if (addr.getMask() == 0)
                        sawDefaultRoute = true;
                    builder.addRoute(addr.getAddress(), addr.getMask());
                }
            }

            // "Kill-switch" semantics
            if (!(sawDefaultRoute && config.getPeers().size() == 1)) {
                builder.allowFamily(OsConstants.AF_INET);
                builder.allowFamily(OsConstants.AF_INET6);
            }

            builder.setMtu(config.getInterface().getMtu().orElse(1280));

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q)
                builder.setMetered(false);
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M)
                service.setUnderlyingNetworks(null);

            builder.setBlocking(true);
            try (final ParcelFileDescriptor tun = builder.establish()) {
                if (tun == null)
                    throw new BackendException(Reason.TUN_CREATION_ERROR);
                Log.d(TAG, "Go backend " + wgVersion());
                currentTunnelHandle = wgTurnOn(tunnel.getName(), tun.detachFd(), interfaceConfig);
            }
            if (currentTunnelHandle < 0)
                throw new BackendException(Reason.GO_ACTIVATION_ERROR_CODE, currentTunnelHandle);
            final TwoPhaseResult activation = activatePeersAfterProtection(currentTunnelHandle, peerConfig,
                    new TwoPhaseOperations() {
                        @Override public int socketV4(final int handle) { return wgGetSocketV4(handle); }
                        @Override public int socketV6(final int handle) { return wgGetSocketV6(handle); }
                        @Override public boolean protect(final int socket) { return service.protect(socket); }
                        @Override public int applyPeerConfig(final int handle, final String peers) {
                            return wgSetConfig(handle, peers);
                        }
                        @Override public void turnOff(final int handle) { wgTurnOff(handle); }
                    });
            if (!activation.activated) {
                if (activation.handleReleased) {
                    currentTunnelHandle = -1;
                } else {
                    // A throwing native stop leaves the detached TUN's state
                    // unknown. Associate it before surfacing the error so the
                    // caller's confirmed DOWN retry addresses this handle.
                    currentTunnel = tunnel;
                    currentConfig = config;
                }
                throw new BackendException(Reason.GO_ACTIVATION_ERROR_CODE, currentTunnelHandle);
            }

            currentTunnel = tunnel;
            currentConfig = config;
        } else {
            if (currentTunnelHandle == -1) {
                Log.w(TAG, "Tunnel already down");
                return;
            }
            // The application owns the common service lifetime. Retain the handle until the
            // native stop returns, so an uncertain stop cannot be mistaken for a clean one.
            wgTurnOff(currentTunnelHandle);
            currentTunnel = null;
            currentTunnelHandle = -1;
            currentConfig = null;
        }

        tunnel.onStateChange(state);
    }

    /** Peer-only UAPI data never carries private_key or listen_port, so it cannot rebind sockets. */
    static String peerConfig(final Config config) {
        final StringBuilder sb = new StringBuilder("replace_peers=true\n");
        for (final Peer peer : config.getPeers())
            sb.append(peer.toWgUserspaceString());
        return sb.toString();
    }

    interface TwoPhaseOperations {
        int socketV4(int handle);
        int socketV6(int handle);
        boolean protect(int socket);
        int applyPeerConfig(int handle, String settings);
        void turnOff(int handle);
    }

    static final class TwoPhaseResult {
        final boolean activated;
        final boolean handleReleased;

        private TwoPhaseResult(final boolean activated, final boolean handleReleased) {
            this.activated = activated;
            this.handleReleased = handleReleased;
        }
    }

    /** Protects every bound socket before peer installation. IPv4 is mandatory; IPv6 is optional. */
    static TwoPhaseResult activatePeersAfterProtection(final int handle, final String peers,
                                                         final TwoPhaseOperations operations) {
        try {
            final int socketV4 = operations.socketV4(handle);
            if (socketV4 < 0 || !operations.protect(socketV4))
                return failedTwoPhaseStart(handle, operations);
            final int socketV6 = operations.socketV6(handle);
            if (socketV6 >= 0 && !operations.protect(socketV6))
                return failedTwoPhaseStart(handle, operations);
            if (operations.applyPeerConfig(handle, peers) != 0)
                return failedTwoPhaseStart(handle, operations);
            return new TwoPhaseResult(true, false);
        } catch (final RuntimeException ignored) {
            return failedTwoPhaseStart(handle, operations);
        }
    }

    private static TwoPhaseResult failedTwoPhaseStart(final int handle, final TwoPhaseOperations operations) {
        try {
            operations.turnOff(handle);
            return new TwoPhaseResult(false, true);
        } catch (final RuntimeException ignored) {
            return new TwoPhaseResult(false, false);
        }
    }

    /**
     * Callback for {@link GoBackend} that is invoked when {@link VpnService} is started by the
     * system's Always-On VPN mode.
     */
    public interface AlwaysOnCallback {
        void alwaysOnTriggered();
    }

    /** Events from Android's shared VPN host. Implementations must never block Android callbacks. */
    public interface HostLifecycleListener {
        void onSystemStart();

        void onHostRevoked();

        void onHostDestroyed();
    }

    private synchronized void stopWireGuardAfterHostLoss() {
        // A replacement host won the race; it now owns the engine lifecycle.
        if (getActiveHost() != null)
            return;
        final Tunnel tunnel = currentTunnel;
        if (tunnel == null || currentTunnelHandle == -1)
            return;
        wgTurnOff(currentTunnelHandle);
        currentTunnel = null;
        currentTunnelHandle = -1;
        currentConfig = null;
        tunnel.onStateChange(State.DOWN);
    }

    private static void scheduleFallbackCleanup(@Nullable final GoBackend owner) {
        if (owner != null)
            fallbackCleanupExecutor.execute(owner::stopWireGuardAfterHostLoss);
    }

    private static void notifyHostLifecycle(final HostLifecycleListener listener, final int event) {
        try {
            switch (event) {
                case 0:
                    listener.onSystemStart();
                    break;
                case 1:
                    listener.onHostRevoked();
                    break;
                default:
                    listener.onHostDestroyed();
                    break;
            }
        } catch (final RuntimeException error) {
            // A controller error must not crash Android's VpnService callback thread.
            Log.e(TAG, "Host lifecycle listener failed", error);
        }
    }

    /**
     * {@link android.net.VpnService} implementation for {@link GoBackend}
     */
    public static class VpnService extends android.net.VpnService {
        private static final String FOREGROUND_CHANNEL_ID = "wireguard_tunnel";
        private static final int FOREGROUND_NOTIFICATION_ID = 10101;
        @Nullable private static volatile VpnService foregroundService;
        @Nullable private GoBackend owner;

        public Builder getBuilder() {
            return new Builder();
        }

        /** Refreshes the notification of the running TUN owner, if any. */
        public static void refreshForegroundNotification() {
            final VpnService service = foregroundService;
            if (service != null)
                service.refreshForegroundNotificationOnMainThread();
        }

        private void refreshForegroundNotificationOnMainThread() {
            if (Looper.myLooper() == Looper.getMainLooper()) {
                showForegroundNotification();
            } else {
                new Handler(Looper.getMainLooper()).post(this::showForegroundNotification);
            }
        }

        private void showForegroundNotification() {
            final Notification notification = createForegroundNotification();
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE)
                startForeground(FOREGROUND_NOTIFICATION_ID, notification, ServiceInfo.FOREGROUND_SERVICE_TYPE_SPECIAL_USE);
            else
                startForeground(FOREGROUND_NOTIFICATION_ID, notification);
        }

        private Notification createForegroundNotification() {
            final ForegroundNotificationFactory factory = foregroundNotificationFactory;
            if (factory != null) {
                final Notification supplied = factory.create(this);
                if (supplied != null)
                    return supplied;
            }
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                final NotificationManager manager = getSystemService(NotificationManager.class);
                manager.createNotificationChannel(new NotificationChannel(
                    FOREGROUND_CHANNEL_ID,
                    "WireGuard VPN",
                    NotificationManager.IMPORTANCE_LOW));
                return new Notification.Builder(this, FOREGROUND_CHANNEL_ID)
                    .setSmallIcon(android.R.drawable.stat_sys_warning)
                    .setContentTitle("WireGuard VPN")
                    .setContentText("WireGuard tunnel active")
                    .setCategory(Notification.CATEGORY_SERVICE)
                    .setOngoing(true)
                    .build();
            }
            return new Notification.Builder(this)
                .setSmallIcon(android.R.drawable.stat_sys_warning)
                .setContentTitle("WireGuard VPN")
                .setContentText("WireGuard tunnel active")
                .setCategory(Notification.CATEGORY_SERVICE)
                .setOngoing(true)
                .build();
        }

        @Override
        public void onCreate() {
            super.onCreate();
            vpnService.complete(this);
            foregroundService = this;
            // Android requires the actual TUN owner to become foreground
            // promptly after startForegroundService, not a companion service.
            showForegroundNotification();
        }

        @Override
        public void onDestroy() {
            final boolean wasActiveHost = foregroundService == this;
            if (wasActiveHost)
                foregroundService = null;
            stopForeground(STOP_FOREGROUND_REMOVE);
            if (wasActiveHost) {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S)
                    vpnService = vpnService.newIncompleteFuture();
                else
                    vpnService = new CompletableFuture<>();
                final HostLifecycleListener listener = hostLifecycleListener;
                if (listener != null) {
                    // Do not join wireguard-go here. The embedding controller serializes engine stop
                    // with protocol switching and keeps the handle until it can confirm closure.
                    notifyHostLifecycle(listener, 2);
                } else {
                    scheduleFallbackCleanup(owner);
                }
            }
            super.onDestroy();
        }

        @Override
        public void onRevoke() {
            if (foregroundService == this) {
                final HostLifecycleListener listener = hostLifecycleListener;
                if (listener != null)
                    notifyHostLifecycle(listener, 1);
                else
                    scheduleFallbackCleanup(owner);
            }
            super.onRevoke();
        }

        @Override
        public int onStartCommand(@Nullable final Intent intent, final int flags, final int startId) {
            vpnService.complete(this);
            final boolean appStart = intent != null
                    && ACTION_APP_START_HOST.equals(intent.getAction())
                    && intent.getBooleanExtra(EXTRA_APP_HOST_START, false);
            if (!appStart) {
                Log.d(TAG, "Service started by Always-on VPN feature");
                if (alwaysOnCallback != null)
                    alwaysOnCallback.alwaysOnTriggered();
                final HostLifecycleListener listener = hostLifecycleListener;
                if (listener != null)
                    notifyHostLifecycle(listener, 0);
            }
            // A system start (including the null-intent restart of a sticky
            // service) must survive process death so Android can restore the
            // user-selected Always-On VPN. Explicit app starts remain
            // non-sticky unless Android confirms that Always-On is enabled.
            return !appStart || (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q && isAlwaysOn())
                    ? START_STICKY : START_NOT_STICKY;
        }

        public void setOwner(final GoBackend owner) {
            this.owner = owner;
        }
    }
}
