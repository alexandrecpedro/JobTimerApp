import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import './auth_service.dart';

class AuthServiceImpl implements AuthService {
  /** Methods **/

  // This method saves the last user login data
  @override
  Future<void> signIn() async {
    // Attributes
    final googleUser = await GoogleSignIn().signIn();

    final googleAuth = await googleUser?.authentication;

    // Firebase credentials
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Login at Firebase
    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    GoogleSignIn().disconnect();
  }
}
