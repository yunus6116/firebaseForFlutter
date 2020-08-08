import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignHelper {
  static GoogleSignHelper _instance = GoogleSignHelper._private();

  static GoogleSignHelper get instance => _instance;

  GoogleSignHelper._private();

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<GoogleSignInAccount> signIn() async {
    final user = await _googleSignIn.signIn();
    if (user != null) {
      print(user.email);
      return user;
    }
    return null;
  }
}
