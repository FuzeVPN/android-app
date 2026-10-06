import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;

import '../../app_controller.dart';
import '../../app_theme.dart';
import '../../core/diagnostics.dart';
import '../../core/location_grouping.dart';
import '../../core/location_presentation.dart';
import '../../core/models.dart';
import '../../core/public_links.dart';
import '../../core/repositories.dart';
import '../../l10n/app_copy.dart';
import '../../widgets/country_flag.dart';
import '../../widgets/external_link.dart';
import '../../widgets/fuze_brand.dart';
import '../../widgets/fuze_design.dart';
import '../../widgets/language_settings.dart';
import '../../widgets/notice_card.dart';
import '../auth/auth_page.dart';
import '../auth/guest_claim_page.dart';
import '../billing/subscription_card.dart';

part 'account_page.dart';
part 'connection_components.dart';
part 'connection_page.dart';
part 'diagnostics_page.dart';
part 'home_components.dart';
part 'locations_page.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key, required this.controller});

  final VpnAppController controller;

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;
  final _connectionScroll = ScrollController();

  @override
  void dispose() {
    _connectionScroll.dispose();
    super.dispose();
  }

  void _showConnectionProgress() {
    _selectDestination(0);
    if (_connectionScroll.hasClients) _connectionScroll.jumpTo(0);
  }

  void _selectDestination(int index) {
    if (_index == index) return;
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() => _index = index);
    if (index == 2) {
      unawaited(widget.controller.billing.refreshSubscription());
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<_HomeDestination> destinations = <_HomeDestination>[
      _HomeDestination(
        icon: Icons.shield_outlined,
        selectedIcon: Icons.shield,
        label: context.copy('nav.connection'),
      ),
      _HomeDestination(
        icon: Icons.location_on_outlined,
        selectedIcon: Icons.location_on,
        label: context.copy('nav.locations'),
      ),
      _HomeDestination(
        icon: Icons.person_outline,
        selectedIcon: Icons.person,
        label: context.copy('nav.account'),
      ),
    ];
    final List<Widget> pages = <Widget>[
      ConnectionPage(
        controller: widget.controller,
        scrollController: _connectionScroll,
        onBrowseLocations: () => _selectDestination(1),
      ),
      LocationsPage(
        controller: widget.controller,
        onLocationSelected: _showConnectionProgress,
        isActive: _index == 1,
      ),
      AccountPage(controller: widget.controller),
    ];
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final bool useRail = constraints.maxWidth >= 720;
        final Widget content = SafeArea(
          top: false,
          child: IndexedStack(index: _index, children: pages),
        );
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 20,
            title: const FuzeBrand(emblemSize: 32),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Divider(
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
            ),
          ),
          body: useRail
              ? Row(
                  children: <Widget>[
                    NavigationRail(
                      selectedIndex: _index,
                      groupAlignment: -0.85,
                      minWidth: 104,
                      labelType: NavigationRailLabelType.all,
                      onDestinationSelected: _selectDestination,
                      destinations: destinations
                          .map(
                            (_HomeDestination destination) =>
                                NavigationRailDestination(
                                  icon: Icon(destination.icon),
                                  selectedIcon: Icon(destination.selectedIcon),
                                  label: Text(destination.label),
                                ),
                          )
                          .toList(growable: false),
                    ),
                    const VerticalDivider(width: 1),
                    Expanded(child: content),
                  ],
                )
              : content,
          bottomNavigationBar: useRail
              ? null
              : DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Theme.of(context).colorScheme.outlineVariant,
                      ),
                    ),
                  ),
                  child: NavigationBar(
                    height: MediaQuery.textScalerOf(context).scale(12) > 18
                        ? 96
                        : 78,
                    selectedIndex: _index,
                    destinations: destinations
                        .map(
                          (_HomeDestination destination) =>
                              NavigationDestination(
                                icon: Icon(destination.icon),
                                selectedIcon: Icon(destination.selectedIcon),
                                label: destination.label,
                              ),
                        )
                        .toList(growable: false),
                    onDestinationSelected: _selectDestination,
                  ),
                ),
        );
      },
    );
  }
}
