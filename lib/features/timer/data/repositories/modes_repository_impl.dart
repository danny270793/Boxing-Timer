import '../../domain/entities/timer_mode.dart';
import '../../domain/repositories/modes_repository.dart';
import '../datasources/modes_local_datasource.dart';

class ModesRepositoryImpl implements ModesRepository {
  final ModesLocalDatasource _datasource;

  const ModesRepositoryImpl(this._datasource);

  @override
  Future<List<TimerMode>> getCustomModes() => _datasource.loadCustomModes();

  @override
  Future<void> saveCustomModes(List<TimerMode> modes) =>
      _datasource.saveCustomModes(modes);

  @override
  Future<String?> getSelectedModeId() => _datasource.loadSelectedModeId();

  @override
  Future<void> saveSelectedModeId(String id) =>
      _datasource.saveSelectedModeId(id);
}
