import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/timer_mode.dart';

/// Stores custom timer modes and the selected mode id on this device.
class ModesLocalDatasource {
  const ModesLocalDatasource();

  static const _customModesKey = 'custom_modes';
  static const _selectedModeIdKey = 'selected_mode_id';

  Future<List<TimerMode>> loadCustomModes() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_customModesKey);
    if (raw == null) return [];
    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((entry) => TimerMode.fromJson(entry as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveCustomModes(List<TimerMode> modes) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(modes.map((mode) => mode.toJson()).toList());
    await prefs.setString(_customModesKey, encoded);
  }

  Future<String?> loadSelectedModeId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_selectedModeIdKey);
  }

  Future<void> saveSelectedModeId(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_selectedModeIdKey, id);
  }
}
