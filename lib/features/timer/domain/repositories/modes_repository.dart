import '../entities/timer_mode.dart';

abstract class ModesRepository {
  Future<List<TimerMode>> getCustomModes();
  Future<void> saveCustomModes(List<TimerMode> modes);
  Future<String?> getSelectedModeId();
  Future<void> saveSelectedModeId(String id);
}
