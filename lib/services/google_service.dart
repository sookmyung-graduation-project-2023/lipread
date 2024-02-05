import 'package:google_sign_in/google_sign_in.dart';

class GoogleService {
  static final _googleSignIn = GoogleSignIn();

  static Future<GoogleSignInAccount?> signin() => _googleSignIn.signIn();
  static Future signout() => _googleSignIn.signOut();
}
