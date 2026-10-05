import '../repositories/modes_repository.dart';

class GetSelectedModeIdUsecase {
  final ModesRepository _repository;

  const GetSelectedModeIdUsecase(this._repository);

  Future<String?> call() => _repository.getSelectedModeId();
}
