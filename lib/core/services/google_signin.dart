import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class GoogleSignHelper {
  static GoogleSignHelper _instance = GoogleSignHelper._private();

  static GoogleSignHelper get instance => _instance;

  GoogleSignHelper._private();

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<GoogleSignInAccount> signIn() async {
    final user = await _googleSignIn.signIn();
    if (user != null) {
      print(user.email);
      return user;
    }
    return null;
  }

  Future<GoogleSignInAuthentication> googleAuthentica() async {
    if (await _googleSignIn.isSignedIn()) {
      final user = _googleSignIn.currentUser;
      final userData = await user.authentication;
      return userData;
    }
    return null;
  }

  Future<GoogleSignInAccount> signOut() async {
    final user = await _googleSignIn.signOut();
    if (user != null) {
      print(user.email);
      return user;
    }
    return null;
  }

  Future<FirebaseUser> firebaseSignin() async {
    final GoogleSignInAuthentication googleAuth = await googleAuthentica();

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    print("signed in " + user.displayName);
    var token = await user.getIdToken();
    print(token.token);
    return user;
  }
}
