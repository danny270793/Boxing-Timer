import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../domain/entities/timer_mode.dart';

class ModeRepository {
  ModeRepository(this._prefs);

  final SharedPreferences _prefs;

  static const _customModesKey = 'custom_modes';
  static const _selectedModeIdKey = 'selected_mode_id';

  List<TimerMode> loadCustomModes() {
    final raw = _prefs.getString(_customModesKey);
    if (raw == null) return [];
    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((entry) => TimerMode.fromJson(entry as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveCustomModes(List<TimerMode> modes) async {
    final encoded = jsonEncode(modes.map((mode) => mode.toJson()).toList());
    await _prefs.setString(_customModesKey, encoded);
  }

  String? loadSelectedModeId() => _prefs.getString(_selectedModeIdKey);

  Future<void> saveSelectedModeId(String id) async {
    await _prefs.setString(_selectedModeIdKey, id);
  }
}
