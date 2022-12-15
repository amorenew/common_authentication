part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {
  final User? user;

  const AuthState({this.user});
  @override
  List<Object> get props => [user!];
}

class AuthInitialState extends AuthState {
  const AuthInitialState() : super();

  @override
  List<Object> get props => [];
}

class AuthLoggedInState extends AuthState {
  const AuthLoggedInState({required User user}) : super(user: user);
}

class AuthFailedState extends AuthState {
  const AuthFailedState() : super();

  @override
  List<Object> get props => [];
}

class AuthLoggedOutState extends AuthState {
  const AuthLoggedOutState() : super();

  @override
  List<Object> get props => [];
}
