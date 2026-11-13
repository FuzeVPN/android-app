// SPDX-License-Identifier: MPL-2.0
#pragma once

// Descriptor calls the adapter needs to wake a Core worker blocked in a
// synchronous send on its transport socket. Android uses the real calls; the
// offline host tests define these declarations with an observable stand-in.
#if defined(__ANDROID__)
#include <fcntl.h>
#include <sys/socket.h>
#include <unistd.h>
#endif

namespace fuzevpn::openvpn::socket_ops {
#if defined(__ANDROID__)
// A close-on-exec duplicate. It keeps the socket itself open, so a later
// Shutdown() can never reach an unrelated descriptor that reused the number.
inline int Duplicate(int fd) noexcept { return ::fcntl(fd, F_DUPFD_CLOEXEC, 0); }
// A sender blocked in poll() for send-buffer room wakes with POLLHUP, and its
// send then fails with EPIPE instead of waiting for room that never comes.
inline void Shutdown(int fd) noexcept { ::shutdown(fd, SHUT_RDWR); }
inline void Close(int fd) noexcept { ::close(fd); }
#else
int Duplicate(int fd) noexcept;
void Shutdown(int fd) noexcept;
void Close(int fd) noexcept;
#endif
}  // namespace fuzevpn::openvpn::socket_ops
