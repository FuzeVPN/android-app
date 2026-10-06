part of 'app_controller.dart';

extension _LocationCapacityRecovery on VpnAppController {
  List<Location> _filterCapacityRejections(
    List<Location> received,
    int capacityGeneration, {
    String? rejectedLocationId,
  }) {
    // A later successful catalogue can admit a recovered location. Responses
    // requested before its rejection, and the rejection's own recovery refresh,
    // cannot bring it back from an outdated catalogue snapshot.
    _capacityRejectedLocations.removeWhere(
      (id, generation) =>
          generation <= capacityGeneration && id != rejectedLocationId,
    );
    return List<Location>.unmodifiable(
      received.where(
        (item) => !_capacityRejectedLocations.containsKey(item.id),
      ),
    );
  }

  Future<void> _refreshAfterCapacityFailure(
    ApiFailure failure,
    String locationId, {
    required void Function() check,
  }) async {
    if (!((failure.statusCode == 409 && failure.code == 'server_full') ||
        (failure.statusCode == 503 &&
            failure.code == 'capacity_unavailable'))) {
      return;
    }
    check();
    final operation = _sessionOperation;
    final generation = ++_locationsRefreshGeneration;
    final capacityGeneration = ++_capacityRejectionGeneration;
    final selectionGeneration = _locationSelectionGeneration;
    _capacityRejectedLocations[locationId] = capacityGeneration;
    locations = List<Location>.unmodifiable(
      locations.where((item) => item.id != locationId),
    );
    isLoadingLocations = true;
    notifyListeners();
    bool ownsPublication() =>
        !_disposed &&
        operation.isCurrent &&
        generation == _locationsRefreshGeneration;
    try {
      final received = await _api.locations();
      check();
      if (ownsPublication()) {
        locations = _filterCapacityRejections(
          received,
          capacityGeneration,
          rejectedLocationId: locationId,
        );
      }
    } on SessionOperationCancelled {
      rethrow;
    } catch (_) {
      check();
      // Keep both the original capacity notice and the local exclusion when
      // this one recovery request fails. No connection or request is retried.
    } finally {
      if (ownsPublication()) {
        isLoadingLocations = false;
        notifyListeners();
      }
    }
    check();
    // A newer manual refresh can own the catalogue while this request waits.
    // Reconcile against its published list, never this request's old response;
    // it may have legitimately admitted the location again in the meantime.
    if (selectionGeneration == _locationSelectionGeneration &&
        selectedLocation?.id == locationId &&
        !locations.any((item) => item.id == locationId) &&
        !isLocationMigrationLocked) {
      selectedLocation = locations.firstOrNull;
    }
    notifyListeners();
  }
}
