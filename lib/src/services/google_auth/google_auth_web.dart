import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'google_sign_in_web_redirect.dart';

Future<User?> signInWithGoogle({
  required FirebaseAuth firebaseAuth,
  required GoogleSignIn googleSignIn,
  required String webClientId,
  required String redirectUri,
}) async {
  GoogleSignWeb.instance?.signIn();
  return Future.value();
}

Future<void> signOut({
  required GoogleSignIn googleSignIn,
}) async {
  await GoogleSignWeb.instance?.signOut();
  await googleSignIn.signOut();
}

void initGoogleSignIn() async {
  GoogleSignWeb.init(
    ///id_token if you only want get user_id
    ///code if you need basic profile, access_token
    responseType: "id_token",
    scopes: ['email', 'profile'],
  );
}

void getQueryParameters() {
  GoogleSignWeb.getQueryParameters();
}

String? getIdToken() {
  if (GoogleSignWeb.instance?.queryParameters?.idToken != null) {
    return GoogleSignWeb.instance?.token;
  }

  return null;
}
