import '../repositories/modes_repository.dart';

class SaveSelectedModeIdUsecase {
  final ModesRepository _repository;

  const SaveSelectedModeIdUsecase(this._repository);

  Future<void> call(String id) => _repository.saveSelectedModeId(id);
}
