import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:common_authentication/src/services/google_auth/google_auth.dart'
    as google_auth;

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  String _webClientId;
  String _redirectUri;

  static FirebaseAuthService? _instance;

  FirebaseAuthService._(
    this._webClientId,
    this._redirectUri, {
    FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignin,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();

  static FirebaseAuthService get instance =>
      _instance ??= FirebaseAuthService._(
        '',
        '',
        firebaseAuth: FirebaseAuth.instance,
        googleSignin: GoogleSignIn(),
      );

  Stream<User?> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges();
  }

  Future<void> initGoogleSignIn() async => google_auth.initGoogleSignIn();

  Future<User?> signInWithGoogle() async {
    return google_auth.signInWithGoogle(
      firebaseAuth: _firebaseAuth,
      googleSignIn: _googleSignIn,
      webClientId: _webClientId,
      redirectUri: _redirectUri,
    );
  }

  Future<User?> signInWithGoogleSilently() async {
    GoogleSignInAccount? googleUser = await _googleSignIn.signInSilently();
    final googleAuth = await googleUser?.authentication;
    if (googleAuth == null) {
      return Future.value();
    }

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final authResult = await _firebaseAuth.signInWithCredential(credential);
    return authResult.user;
  }

  Future<void> signOut() async {
    await google_auth.signOut(googleSignIn: _googleSignIn);
    await _firebaseAuth.signOut();
  }

  Future<void> autoRemember() async {
    _firebaseAuth.setPersistence(Persistence.LOCAL);
  }

  Future<User?> currentUser() async {
    User? user = _firebaseAuth.currentUser;
    user ??= await _firebaseAuth.authStateChanges().first;
    return user;
  }

  void getQueryParameters() => google_auth.getQueryParameters();

  String? getIdToken() => google_auth.getIdToken();

  void init({required String webClientId, required String redirectUri}) {
    _webClientId = webClientId;
    _redirectUri = redirectUri;
  }
}
