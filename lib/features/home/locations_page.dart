part of 'home_shell.dart';

class LocationsPage extends StatefulWidget {
  const LocationsPage({
    super.key,
    required this.controller,
    required this.onLocationSelected,
    this.isActive = true,
  });

  final VpnAppController controller;
  final VoidCallback onLocationSelected;
  final bool isActive;

  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  final _search = TextEditingController();
  final _scroll = ScrollController();
  bool _favoritesOnly = false;
  bool _confirmingChange = false;
  String? _countryCode;
  String? _cityKey;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_catalogueChanged);
  }

  @override
  void didUpdateWidget(LocationsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(widget.controller, oldWidget.controller)) {
      oldWidget.controller.removeListener(_catalogueChanged);
      widget.controller.addListener(_catalogueChanged);
      _countryCode = null;
      _cityKey = null;
    }
  }

  void _catalogueChanged() {
    if (_countryCode == null) return;
    final country = groupLocations(
      widget.controller.locations,
      languageCode: 'en',
    ).where((group) => group.countryCode == _countryCode).firstOrNull;
    final cityExists =
        country?.cities.any((city) => city.key == _cityKey) ?? false;
    if (country == null || (_cityKey != null && !cityExists)) {
      setState(() {
        if (country == null) _countryCode = null;
        _cityKey = null;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _scroll.hasClients) _scroll.jumpTo(0);
      });
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_catalogueChanged);
    _search.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _clearSearch() => setState(_search.clear);

  void _navigate(VoidCallback change) {
    FocusScope.of(context).unfocus();
    setState(change);
    if (_scroll.hasClients) _scroll.jumpTo(0);
  }

  void _goBack() => _navigate(() {
    if (_search.text.trim().isNotEmpty) {
      _search.clear();
    } else if (_favoritesOnly) {
      _favoritesOnly = false;
    } else if (_cityKey != null) {
      _cityKey = null;
    } else {
      _countryCode = null;
    }
  });

  Location? _automaticTarget(List<Location> servers) {
    final controller = widget.controller;
    return chooseLocationServer(
      servers,
      selectedProtocol: controller.selectedProtocol,
      activeProtocol: controller.isTunnelActive
          ? controller.tunnelState.protocol
          : null,
      activeLocationId: controller.isTunnelActive
          ? _currentLocationId(controller)
          : null,
      selectedLocationId: controller.selectedLocation?.id,
    );
  }

  Future<void> _confirmLocationChange(Location location) async {
    final controller = widget.controller;
    if (_confirmingChange ||
        !controller.canChangeLocation ||
        _currentLocationId(controller) == location.id) {
      return;
    }
    final account = controller.profile?.userId;
    final token = controller.token;
    final session = controller.locationChangeSessionIdentity;
    final device = controller.currentDeviceId;
    final selected = controller.selectedLocation?.id;
    final current = _currentLocationId(controller);
    final protocol = controller.selectedProtocol;
    final active = controller.isTunnelActive;
    setState(() => _confirmingChange = true);
    try {
      var answered = false;
      void answer(BuildContext dialogContext, bool value) {
        if (answered) return;
        answered = true;
        Navigator.of(dialogContext).pop(value);
      }

      final confirmed = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          key: const ValueKey('location-change-dialog'),
          scrollable: true,
          icon: Align(
            alignment: AlignmentDirectional.centerStart,
            child: _LocationFlagBadge(countryCode: location.countryCode),
          ),
          title: Text(dialogContext.copy('locations.changeTitle')),
          content: Text(
            dialogContext.copy(
              active ? 'locations.changeActive' : 'locations.changeIdle',
              arguments: {'name': location.displayName},
            ),
          ),
          actions: [
            TextButton(
              key: const ValueKey('location-change-cancel'),
              onPressed: () => answer(dialogContext, false),
              child: Text(dialogContext.copy('action.cancel')),
            ),
            FilledButton(
              key: const ValueKey('location-change-confirm'),
              onPressed: () => answer(dialogContext, true),
              child: Text(dialogContext.copy('locations.confirmChange')),
            ),
          ],
        ),
      );
      if (!mounted ||
          confirmed != true ||
          !identical(controller, widget.controller) ||
          !identical(session, controller.locationChangeSessionIdentity) ||
          controller.profile?.userId != account ||
          controller.token != token ||
          controller.currentDeviceId != device ||
          controller.selectedLocation?.id != selected ||
          _currentLocationId(controller) != current ||
          controller.selectedProtocol != protocol ||
          !controller.canChangeLocation ||
          !controller.locations.any((item) => item.id == location.id)) {
        return;
      }
      widget.onLocationSelected();
      await controller.changeLocationAndConnect(location);
    } finally {
      if (mounted) setState(() => _confirmingChange = false);
    }
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: widget.controller,
    builder: (context, _) {
      final controller = widget.controller;
      final language = Localizations.localeOf(context).toLanguageTag();
      final query = _search.text.trim();
      final groups = groupLocations(
        controller.locations,
        languageCode: language,
      );
      final country = groups
          .where((group) => group.countryCode == _countryCode)
          .firstOrNull;
      final city = country?.cities
          .where((group) => group.key == _cityKey)
          .firstOrNull;
      final flat = _favoritesOnly || query.isNotEmpty;
      final hasBack = flat || country != null;
      final visible = controller.locations
          .where((location) {
            return (!_favoritesOnly ||
                    controller.isFavoriteLocation(location.id)) &&
                locationMatchesQuery(location, query, language);
          })
          .toList(growable: false);
      final scheme = Theme.of(context).colorScheme;
      final servers = flat ? visible : city?.servers;
      final resultCount =
          servers?.length ?? country?.cities.length ?? groups.length;
      final countKey = servers != null
          ? 'locations.serverCount'
          : country != null
          ? 'locations.cityCount'
          : 'locations.countryCount';
      return PopScope<void>(
        canPop: !widget.isActive || !hasBack,
        onPopInvokedWithResult: (didPop, _) {
          if (!didPop && widget.isActive && hasBack && !_confirmingChange) {
            _goBack();
          }
        },
        child: _PageBody(
          controller: _scroll,
          onRefresh: controller.refreshLocations,
          children: [
            FuzePageHeader(
              title: context.copy('nav.locations'),
              description: context.copy('locations.available'),
            ),
            TextField(
              key: const ValueKey('locations-search'),
              controller: _search,
              onChanged: (_) => setState(() {}),
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => FocusScope.of(context).unfocus(),
              decoration: InputDecoration(
                labelText: context.copy('locations.searchLabel'),
                prefixIcon: const Icon(Icons.search_rounded, size: 22),
                suffixIcon: _search.text.isEmpty
                    ? null
                    : IconButton(
                        key: const ValueKey('locations-clear-search'),
                        tooltip: context.copy('locations.clearSearch'),
                        onPressed: _clearSearch,
                        constraints: const BoxConstraints(
                          minWidth: 48,
                          minHeight: 48,
                        ),
                        icon: const Icon(Icons.close_rounded),
                      ),
              ),
            ),
            const SizedBox(height: 18),
            Wrap(
              spacing: 10,
              runSpacing: 8,
              children: [
                ChoiceChip(
                  key: const ValueKey('locations-filter-all'),
                  label: Text(context.copy('locations.filterAll')),
                  selected: !_favoritesOnly,
                  onSelected: (_) => setState(() => _favoritesOnly = false),
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  showCheckmark: false,
                  avatar: const Icon(Icons.public_rounded, size: 17),
                ),
                ChoiceChip(
                  key: const ValueKey('locations-filter-favorites'),
                  label: Text(context.copy('locations.filterFavorites')),
                  selected: _favoritesOnly,
                  onSelected: (_) => setState(() => _favoritesOnly = true),
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  showCheckmark: false,
                  avatar: const Icon(Icons.star_rounded, size: 17),
                ),
              ],
            ),
            const SizedBox(height: 24),
            if (hasBack && !flat) ...[
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: TextButton.icon(
                  key: const ValueKey('locations-back'),
                  onPressed: _goBack,
                  icon: const Icon(Icons.arrow_back_rounded),
                  label: Text(
                    context.copy(
                      city != null
                          ? 'locations.backToCities'
                          : 'locations.backToCountries',
                      arguments: {'name': country?.name ?? ''},
                    ),
                  ),
                ),
              ),
            ],
            DecoratedBox(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: scheme.outlineVariant),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      flat
                          ? context.copy(
                              _favoritesOnly
                                  ? 'locations.filterFavorites'
                                  : 'locations.allCountries',
                            )
                          : [
                              context.copy('locations.allCountries'),
                              if (country != null) country.name,
                              if (city != null) city.name,
                            ].join(' › '),
                      key: const ValueKey('locations-breadcrumb'),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    if (resultCount > 0) ...[
                      const SizedBox(height: 8),
                      Semantics(
                        liveRegion: true,
                        child: Text(
                          context.copy(
                            countKey,
                            arguments: {'count': resultCount},
                          ),
                          key: const ValueKey('locations-results-count'),
                          style: FuzeVpnTheme.mono(
                            fontSize: 11,
                            color: scheme.onSurfaceVariant,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            if (controller.notice != null) ...[
              NoticeCard(
                notice: controller.notice,
                onDismiss: controller.clearNotice,
              ),
              const SizedBox(height: 12),
            ],
            if (controller.favoritesSaveFailed) ...[
              Semantics(
                liveRegion: true,
                child: Text(
                  context.copy('locations.favoriteSaveFailed'),
                  key: const ValueKey('locations-favorite-error'),
                  style: TextStyle(color: scheme.error),
                ),
              ),
              const SizedBox(height: 12),
            ],
            if (!controller.canChangeLocation) ...[
              LockedLocationBanner(controller: controller),
              const SizedBox(height: 16),
            ],
            if (controller.isLoadingLocations) ...[
              const LinearProgressIndicator(
                key: ValueKey('locations-loading'),
                minHeight: 3,
              ),
              const SizedBox(height: 16),
            ],
            if (resultCount > 0) ...[
              if (servers == null)
                for (final group in country == null ? groups : country.cities)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: group is LocationCountryGroup
                        ? _groupRow(
                            id: 'country-${group.countryCode}',
                            name: group.name,
                            countryCode: group.countryCode,
                            servers: group.servers,
                            count: group.cities.length,
                            isCountry: true,
                            onBrowse: () => _navigate(() {
                              _countryCode = group.countryCode;
                              _cityKey = null;
                            }),
                          )
                        : _cityRow(group as LocationCityGroup),
                  ),
              for (final location in servers ?? const <Location>[])
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: LocationRow(
                    key: ValueKey('location-${location.id}'),
                    location: location,
                    controller: controller,
                    onSelected: () => _confirmLocationChange(location),
                    selectionEnabled: !_confirmingChange,
                  ),
                ),
            ] else if (!controller.isLoadingLocations)
              _LocationsEmptyState(
                isCatalogEmpty: controller.locations.isEmpty,
                isFavoritesOnly: _favoritesOnly,
                hasQuery: query.isNotEmpty,
                onRefresh: controller.refreshLocations,
                onClearSearch: _clearSearch,
                onShowAll: () => setState(() => _favoritesOnly = false),
              ),
          ],
        ),
      );
    },
  );

  Widget _cityRow(LocationCityGroup city) => _groupRow(
    id: 'city-${city.countryCode}-${city.key}',
    name: city.name,
    countryCode: city.countryCode,
    servers: city.servers,
    count: city.servers.length,
    isCountry: false,
    onBrowse: () => _navigate(() => _cityKey = city.key),
  );

  Widget _groupRow({
    required String id,
    required String name,
    required String countryCode,
    required List<Location> servers,
    required int count,
    required bool isCountry,
    required VoidCallback onBrowse,
  }) {
    final target = _automaticTarget(servers);
    final selected = servers.any(
      (location) => location.id == _currentLocationId(widget.controller),
    );
    return _LocationGroupRow(
      key: ValueKey('location-$id'),
      id: id,
      name: name,
      countryCode: countryCode,
      count: count,
      isCountry: isCountry,
      selected: selected,
      compatible: target != null,
      onSelected:
          target == null ||
              _confirmingChange ||
              !widget.controller.canChangeLocation ||
              target.id == _currentLocationId(widget.controller)
          ? null
          : () => _confirmLocationChange(target),
      onBrowse: onBrowse,
    );
  }
}

class _LocationGroupRow extends StatelessWidget {
  const _LocationGroupRow({
    super.key,
    required this.id,
    required this.name,
    required this.countryCode,
    required this.count,
    required this.isCountry,
    required this.selected,
    required this.compatible,
    required this.onSelected,
    required this.onBrowse,
  });

  final String id;
  final String name;
  final String countryCode;
  final int count;
  final bool isCountry;
  final bool selected;
  final bool compatible;
  final VoidCallback? onSelected;
  final VoidCallback onBrowse;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final action = context.copy(
      isCountry ? 'locations.viewCities' : 'locations.viewServers',
      arguments: {'name': name},
    );
    return Card(
      clipBehavior: Clip.antiAlias,
      color: selected ? scheme.secondaryContainer : scheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: selected ? scheme.secondary : scheme.outlineVariant,
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          const browseWidth = 76.0;
          const browseHorizontalPadding = 8.0;
          final countText = context.copy(
            isCountry ? 'locations.cityCount' : 'locations.serverCount',
            arguments: {'count': count},
          );
          final countStyle = FuzeVpnTheme.mono(
            fontSize: 11,
            color: scheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          );
          final textScaler = MediaQuery.textScalerOf(context);
          final countPainter = TextPainter(
            text: TextSpan(
              text: countText,
              style: DefaultTextStyle.of(context).style.merge(countStyle),
            ),
            textDirection: Directionality.of(context),
            textScaler: textScaler,
            locale: Localizations.localeOf(context),
          )..layout();
          // The compact sidebar must fit complete words at the user's scale.
          // Large screens still use a fixed-width card, so screen width alone
          // cannot determine whether the count needs the full-width action.
          final countWouldSplitWord =
              countPainter.minIntrinsicWidth >
              browseWidth - 2 * browseHorizontalPadding;
          countPainter.dispose();
          final stacked =
              countWouldSplitWord ||
              (constraints.maxWidth < 400 && textScaler.scale(12) > 18);
          final selection = Semantics(
            button: true,
            selected: selected,
            enabled: onSelected != null,
            label: context.copy(
              isCountry ? 'locations.chooseCountry' : 'locations.chooseCity',
              arguments: {'name': name},
            ),
            child: InkWell(
              key: ValueKey('select-$id'),
              onTap: onSelected,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 20, 14, 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _LocationFlagBadge(countryCode: countryCode),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(name, style: theme.textTheme.titleMedium),
                          const SizedBox(height: 5),
                          Text(
                            context.copy(
                              compatible
                                  ? 'locations.automaticSelection'
                                  : 'locations.noCompatibleServer',
                            ),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                          if (selected) ...[
                            const SizedBox(height: 10),
                            const _LocationSelectedLabel(),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
          final countLabel = Text(
            countText,
            textAlign: stacked ? TextAlign.start : TextAlign.center,
            style: countStyle,
          );
          final browse = Semantics(
            button: true,
            label: action,
            child: Tooltip(
              message: action,
              child: InkWell(
                key: ValueKey('browse-$id'),
                onTap: onBrowse,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: stacked ? 18 : browseHorizontalPadding,
                    vertical: 16,
                  ),
                  child: stacked
                      ? Row(
                          children: [
                            Expanded(child: countLabel),
                            Icon(
                              Directionality.of(context) == TextDirection.rtl
                                  ? Icons.chevron_left_rounded
                                  : Icons.chevron_right_rounded,
                              size: 20,
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Directionality.of(context) == TextDirection.rtl
                                  ? Icons.chevron_left_rounded
                                  : Icons.chevron_right_rounded,
                              size: 20,
                            ),
                            const SizedBox(height: 8),
                            countLabel,
                          ],
                        ),
                ),
              ),
            ),
          );
          if (stacked) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [selection, const Divider(height: 1), browse],
            );
          }
          return IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: selection),
                VerticalDivider(
                  width: 1,
                  thickness: 1,
                  color: scheme.outlineVariant,
                ),
                SizedBox(width: browseWidth, child: browse),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _LocationsEmptyState extends StatelessWidget {
  const _LocationsEmptyState({
    required this.isCatalogEmpty,
    required this.isFavoritesOnly,
    required this.hasQuery,
    required this.onRefresh,
    required this.onClearSearch,
    required this.onShowAll,
  });

  final bool isCatalogEmpty;
  final bool isFavoritesOnly;
  final bool hasQuery;
  final VoidCallback onRefresh;
  final VoidCallback onClearSearch;
  final VoidCallback onShowAll;

  @override
  Widget build(BuildContext context) {
    final emptyFavorites = isFavoritesOnly && !hasQuery && !isCatalogEmpty;
    final title = isCatalogEmpty
        ? 'locations.emptyTitle'
        : emptyFavorites
        ? 'locations.noFavorites'
        : 'locations.noResults';
    final detail = isCatalogEmpty
        ? 'locations.emptyHint'
        : emptyFavorites
        ? 'locations.noFavoritesHint'
        : 'locations.noResultsHint';
    return Card(
      key: const ValueKey('locations-empty'),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: SizedBox(
                width: 64,
                height: 64,
                child: Icon(
                  emptyFavorites
                      ? Icons.star_border_rounded
                      : Icons.travel_explore,
                  size: 30,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              context.copy(title),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              context.copy(detail),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            OutlinedButton.icon(
              key: const ValueKey('locations-empty-action'),
              onPressed: isCatalogEmpty
                  ? onRefresh
                  : hasQuery
                  ? onClearSearch
                  : onShowAll,
              icon: Icon(isCatalogEmpty ? Icons.refresh : Icons.arrow_forward),
              label: Text(
                context.copy(
                  isCatalogEmpty
                      ? 'action.refresh'
                      : hasQuery
                      ? 'locations.clearSearch'
                      : 'locations.showAll',
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LocationFlagBadge extends StatelessWidget {
  const _LocationFlagBadge({required this.countryCode});

  final String countryCode;

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
    child: DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: SizedBox(
        width: 44,
        height: 44,
        child: Center(
          child: CountryFlag(countryCode: countryCode, width: 28, height: 21),
        ),
      ),
    ),
  );
}

class _LocationSelectedLabel extends StatelessWidget {
  const _LocationSelectedLabel();

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 1),
        child: Icon(
          Icons.check_circle_outline_rounded,
          color: Theme.of(context).colorScheme.secondary,
          size: 15,
        ),
      ),
      const SizedBox(width: 6),
      Expanded(
        child: Text(
          context.copy('locations.selected'),
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ],
  );
}

class LocationRow extends StatelessWidget {
  const LocationRow({
    super.key,
    required this.location,
    required this.controller,
    required this.onSelected,
    this.selectionEnabled = true,
  });

  final Location location;
  final VpnAppController controller;
  final VoidCallback onSelected;
  final bool selectionEnabled;

  @override
  Widget build(BuildContext context) {
    final selected = _currentLocationId(controller) == location.id;
    final effectiveProtocol = controller.isTunnelActive
        ? controller.tunnelState.protocol ?? controller.selectedProtocol
        : controller.selectedProtocol;
    final compatible = location.supports(effectiveProtocol);
    final locked =
        !selectionEnabled || !controller.canChangeLocation || !compatible;
    final favorite = controller.isFavoriteLocation(location.id);
    final country = locationCountryName(
      location,
      Localizations.localeOf(context).toLanguageTag(),
    );
    final city = location.city.trim();
    final displayName = location.displayName.trim();
    final title = displayName.isEmpty ? city : displayName;
    final contextLabel = city.isNotEmpty && city != title
        ? '$city · $country'
        : country;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final information = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: theme.textTheme.titleMedium),
        if (contextLabel.toLowerCase() != title.toLowerCase()) ...[
          const SizedBox(height: 3),
          Text(
            contextLabel,
            style: theme.textTheme.bodySmall?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
        if (!compatible) ...[
          const SizedBox(height: 8),
          Text(
            context.copy('locations.noCompatibleServer'),
            style: theme.textTheme.bodySmall?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
        if (selected) ...[
          const SizedBox(height: 10),
          const _LocationSelectedLabel(),
        ],
      ],
    );
    return Card(
      clipBehavior: Clip.antiAlias,
      color: selected ? scheme.secondaryContainer : scheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: selected ? scheme.secondary : scheme.outlineVariant,
          width: selected ? 1.5 : 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Semantics(
              button: true,
              enabled: !locked && !selected,
              selected: selected,
              child: InkWell(
                key: ValueKey('select-location-${location.id}'),
                onTap: locked || selected ? null : onSelected,
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 20, 4, 20),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final stacked =
                          constraints.maxWidth < 300 &&
                          MediaQuery.textScalerOf(context).scale(12) > 18;
                      final flag = _LocationFlagBadge(
                        countryCode: location.countryCode,
                      );
                      if (stacked) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            flag,
                            const SizedBox(height: 14),
                            information,
                          ],
                        );
                      }
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          flag,
                          const SizedBox(width: 14),
                          Expanded(child: information),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(2, 8, 8, 8),
            child: Semantics(
              toggled: favorite,
              child: IconButton(
                key: ValueKey('favorite-location-${location.id}'),
                tooltip: context.copy(
                  favorite
                      ? 'locations.removeFavorite'
                      : 'locations.addFavorite',
                  arguments: {'name': location.displayName},
                ),
                onPressed: controller.favoritesSaving
                    ? null
                    : () => controller.toggleFavoriteLocation(location),
                constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
                icon: Icon(
                  favorite ? Icons.star_rounded : Icons.star_border_rounded,
                  color: favorite ? scheme.secondary : scheme.onSurfaceVariant,
                  size: 22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LockedLocationBanner extends StatelessWidget {
  const LockedLocationBanner({super.key, required this.controller});

  final VpnAppController controller;

  @override
  Widget build(BuildContext context) => Card(
    color: Theme.of(context).colorScheme.secondaryContainer,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(
                Icons.lock_outline_rounded,
                size: 20,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(_locationLockMessage(context, controller))),
        ],
      ),
    ),
  );
}

String _locationLockMessage(
  BuildContext context,
  VpnAppController controller,
) => context.copy('locations.changeBusy');

String? _currentLocationId(VpnAppController controller) =>
    controller.isTunnelActive
    ? controller.tunnelState.locationId ??
          controller.activeDeviceLocation?.id ??
          controller.selectedLocation?.id
    : controller.selectedLocation?.id;
