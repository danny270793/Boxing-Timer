import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/continue_without_account_usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _repository;
  final ContinueWithoutAccountUsecase _continueWithoutAccount;
  StreamSubscription<Object?>? _subscription;

  AuthCubit({
    required AuthRepository repository,
    required this._continueWithoutAccount,
  }) : _repository = repository,
       super(AuthState(user: repository.currentUser)) {
    _subscription = _repository.authStateChanges.listen((_) => refresh());
  }

  /// Re-reads the session and guest flag from the repository.
  Future<void> refresh() async {
    final isGuest = await _repository.isGuest();
    if (isClosed) return;
    emit(AuthState(user: _repository.currentUser, isGuest: isGuest));
  }

  Future<void> continueWithoutAccount() async {
    await _continueWithoutAccount();
    await refresh();
  }

  /// Ends guest mode so the router shows the login screen.
  Future<void> showSignIn() async {
    await _repository.leaveGuestMode();
    await refresh();
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
