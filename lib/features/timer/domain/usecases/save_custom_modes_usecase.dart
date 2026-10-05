import '../entities/timer_mode.dart';
import '../repositories/modes_repository.dart';

class SaveCustomModesUsecase {
  final ModesRepository _repository;

  const SaveCustomModesUsecase(this._repository);

  Future<void> call(List<TimerMode> modes) =>
      _repository.saveCustomModes(modes);
}
