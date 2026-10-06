part of 'app_controller.dart';

extension _UiPreferences on VpnAppController {
  /// Apply the in-memory choice immediately and serialize durable writes.
  /// A storage error must not trap navigation or throw from a UI callback.
  Future<void> _persistUiPreference(
    String key,
    Future<void> Function() persist,
  ) async {
    final epoch = (_uiPreferenceEpochs[key] ?? 0) + 1;
    _uiPreferenceEpochs[key] = epoch;
    if (notice?.messageKey == 'notice.preferenceSave.message' &&
        notice?.arguments['preference'] == key) {
      notice = null;
    }
    notifyListeners();
    final write = _uiPreferenceWrites.then((_) async {
      try {
        await persist();
      } catch (_) {
        if (!_disposed && epoch == _uiPreferenceEpochs[key]) {
          notice = AppNotice(
            titleKey: 'notice.preferenceSave.title',
            messageKey: 'notice.preferenceSave.message',
            arguments: {'preference': key},
          );
        }
      } finally {
        if (!_disposed && epoch == _uiPreferenceEpochs[key]) notifyListeners();
      }
    });
    _uiPreferenceWrites = write;
    await write;
  }
}
