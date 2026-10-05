import '../repositories/auth_repository.dart';

class ContinueWithoutAccountUsecase {
  final AuthRepository _repository;

  const ContinueWithoutAccountUsecase(this._repository);

  Future<void> call() => _repository.continueWithoutAccount();
}
