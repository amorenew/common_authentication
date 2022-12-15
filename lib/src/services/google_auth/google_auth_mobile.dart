import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:desktop_webview_auth/desktop_webview_auth.dart';
import 'package:desktop_webview_auth/google.dart';
import 'dart:io' show Platform;

Future<User?> signInWithGoogle({
  required FirebaseAuth firebaseAuth,
  required GoogleSignIn googleSignIn,
  required String webClientId,
  required String redirectUri,
}) async {
  if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
    return _signInWithGoogleDesktop(
      firebaseAuth: firebaseAuth,
      webClientId: webClientId,
      redirectUri: redirectUri,
    );
  }

  final googleUser = await googleSignIn.signIn();
  final googleAuth = await googleUser?.authentication;
  if (googleAuth == null) {
    return Future.value();
  }

  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  final authResult = await firebaseAuth.signInWithCredential(credential);
  return authResult.user;
}

Future<User?> _signInWithGoogleDesktop({
  required FirebaseAuth firebaseAuth,
  required String webClientId,
  required String redirectUri,
}) async {
  final googleSignInArgs = GoogleSignInArgs(
    clientId: webClientId,
    redirectUri: redirectUri,
    scope: 'email profile',
  );

  final result = await DesktopWebviewAuth.signIn(googleSignInArgs);

  if (result?.accessToken == null) {
    return Future.value();
  }

  final credential = GoogleAuthProvider.credential(
    accessToken: result?.accessToken,
  );

  UserCredential userCredential = await firebaseAuth.signInWithCredential(
    credential,
  );

  return userCredential.user;
}

Future<void> signOut({
  required GoogleSignIn googleSignIn,
}) async {
  if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
    //only logout from mobile as desktop auth is using DesktopWebviewAuth
    //otherwise you will get MissingPluginException(No implementation found for google_sign_in)
    return Future.value();
  }

  await googleSignIn.signOut();
}

void initGoogleSignIn() async {}

void getQueryParameters() {}

String? getIdToken() => null;
