import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource _remote;
  final AuthLocalDatasource _local;

  const AuthRepositoryImpl(this._remote, this._local);

  @override
  UserEntity? get currentUser => _remote.currentUser;

  /// Signing in (from any source) ends guest mode.
  @override
  Stream<UserEntity?> get authStateChanges =>
      _remote.authStateChanges.asyncMap((user) async {
        if (user != null) await _local.setGuest(false);
        return user;
      });

  @override
  Future<bool> isGuest() async => currentUser == null && await _local.isGuest();

  @override
  Future<void> continueWithoutAccount() => _local.setGuest(true);

  @override
  Future<void> leaveGuestMode() => _local.setGuest(false);

  @override
  Future<UserEntity> signIn({
    required String email,
    required String password,
  }) async {
    final user = await _remote.signIn(email: email, password: password);
    await _local.setGuest(false);
    return user;
  }

  @override
  Future<void> signOut() async {
    await _remote.signOut();
    await _local.setGuest(false);
  }

  @override
  Future<void> updateEmail({required String newEmail}) =>
      _remote.updateEmail(newEmail: newEmail);

  @override
  Future<void> updatePassword({required String newPassword}) =>
      _remote.updatePassword(newPassword: newPassword);
}
