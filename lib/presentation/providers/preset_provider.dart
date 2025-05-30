import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/preset_timer.dart';
import '../../core/services/storage_service.dart';

final presetProvider = StateNotifierProvider<PresetNotifier, List<PresetTimer>>(
  (ref) {
    return PresetNotifier();
  },
);

class PresetNotifier extends StateNotifier<List<PresetTimer>> {
  PresetNotifier() : super([]) {
    _loadPresets();
  }

  Future<void> _loadPresets() async {
    final presetStrings = await StorageService.getPresetTimers();
    final presets = presetStrings
        .map((s) => PresetTimer.fromJsonString(s))
        .toList();

    // Add default presets if none exist
    if (presets.isEmpty) {
      presets.addAll(_getDefaultPresets());
      await _savePresets();
    }

    state = presets;
  }

  Future<void> addPreset(PresetTimer preset) async {
    state = [...state, preset];
    await _savePresets();
  }

  Future<void> removePreset(PresetTimer preset) async {
    state = state.where((p) => p != preset).toList();
    await _savePresets();
  }

  Future<void> _savePresets() async {
    final presetStrings = state.map((p) => p.toJsonString()).toList();
    await StorageService.savePresetTimers(presetStrings);
  }

  List<PresetTimer> _getDefaultPresets() {
    return [
      const PresetTimer(name: 'Pomodoro', hours: 0, minutes: 25, seconds: 0),
      const PresetTimer(name: 'Short Break', hours: 0, minutes: 5, seconds: 0),
      const PresetTimer(name: 'Long Break', hours: 0, minutes: 15, seconds: 0),
      const PresetTimer(name: 'Tea Time', hours: 0, minutes: 3, seconds: 0),
    ];
  }
}
