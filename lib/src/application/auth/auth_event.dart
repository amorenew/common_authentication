part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {}

class AuthCheckStatusEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class AuthGoogleLoginEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class AuthLogoutEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}
