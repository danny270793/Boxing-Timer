import '../entities/timer_mode.dart';
import '../repositories/modes_repository.dart';

class GetCustomModesUsecase {
  final ModesRepository _repository;

  const GetCustomModesUsecase(this._repository);

  Future<List<TimerMode>> call() => _repository.getCustomModes();
}
