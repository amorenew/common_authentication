import 'package:common_authentication/src/domain/repositories/user_repository.dart';
import 'package:common_authentication/src/models/user_data.dart';
import 'package:common_authentication/src/services/firebase_auth_service.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _userRepository = UserRepository();

  AuthBloc() : super(const AuthInitialState()) {
    on<AuthCheckStatusEvent>(
      (event, emit) async {
        User? user = await FirebaseAuthService.instance.currentUser();
        user ??= await FirebaseAuthService.instance.signInWithGoogleSilently();

        if (user != null) {
          await _userRepository.createUser(
            user: UserData.fromFirebaseUser(user: user),
          );
          emit(AuthLoggedInState(user: user));
          return;
        }

        //Id token is used to login on redirection from google auth
        final idToken = FirebaseAuthService.instance.getIdToken();
        if (idToken != null) {
          final credential = GoogleAuthProvider.credential(
            idToken: idToken,
          );

          final authResult = await FirebaseAuth.instance.signInWithCredential(
            credential,
          );
          if (authResult.user != null) {
            await _userRepository.createUser(
              user: UserData.fromFirebaseUser(
                user: authResult.user!,
              ),
            );

            emit(AuthLoggedInState(user: authResult.user!));
            return;
          }
        }

        emit(const AuthFailedState());
      },
    );

    on<AuthGoogleLoginEvent>(
      (event, emit) async {
        User? user = await FirebaseAuthService.instance.signInWithGoogle();

        if (user != null) {
          emit(AuthLoggedInState(user: user));
          return;
        }

        emit(const AuthFailedState());
      },
    );

    on<AuthLogoutEvent>(
      (event, emit) async {
        await FirebaseAuthService.instance.signOut();
        emit(const AuthLoggedOutState());
      },
    );
  }
}
