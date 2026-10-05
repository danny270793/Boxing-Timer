import 'package:equatable/equatable.dart';

import '../../domain/entities/user_entity.dart';

/// App-wide session: signed-in user, guest choice, or neither (show login).
class AuthState extends Equatable {
  final UserEntity? user;
  final bool isGuest;

  const AuthState({this.user, this.isGuest = false});

  bool get isAuthenticated => user != null;
  bool get canUseApp => isAuthenticated || isGuest;

  @override
  List<Object?> get props => [user, isGuest];
}
