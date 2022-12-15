import 'package:common_authentication/src/application/app_bloc_observer.dart';
import 'package:common_authentication/src/services/firebase_auth_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> initAuth({
  required String webClientId,
  required String redirectUri,
}) async {
  //remove # for web path to allow \login redirection as #\login
  //is not allowed in google console as a valid redirection url
  setPathUrlStrategy();

  FirebaseAuthService.instance.init(
    webClientId: webClientId,
    redirectUri: redirectUri,
  );
  // add auto remeber to auth
  if (kIsWeb) {
    await FirebaseAuthService.instance.autoRemember();
  }

  //add google result query to login page on redirect from google auth
  FirebaseAuthService.instance.getQueryParameters();

  Bloc.observer = AppBlocObserver();
}

Future<void> initGoogleSignIn() async =>
    FirebaseAuthService.instance.initGoogleSignIn();
