import '../entities/user_entity.dart';

abstract class AuthRepository {
  UserEntity? get currentUser;
  Stream<UserEntity?> get authStateChanges;

  /// True when the user chose "Continue without account" and has not signed
  /// in since.
  Future<bool> isGuest();
  Future<void> continueWithoutAccount();

  Future<UserEntity> signIn({required String email, required String password});
  Future<void> signOut();
  Future<void> updateEmail({required String newEmail});
  Future<void> updatePassword({required String newPassword});
}
