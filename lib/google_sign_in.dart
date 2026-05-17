import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<UserCredential> signInWithGoogle() async {
  await GoogleSignIn.instance.initialize(
    serverClientId: '766717220987-te3759cpj5cijdrlo6r2g6fi97ucmdnk.apps.googleusercontent.com',
  );

  final GoogleSignInAccount googleUser =
      await GoogleSignIn.instance.authenticate();

  final GoogleSignInAuthentication googleAuth =
      googleUser.authentication;

  if (googleAuth.idToken == null) {
    throw Exception("Missing ID Token");
  }

  final credential = GoogleAuthProvider.credential(
    idToken: googleAuth.idToken,
  );

  return await FirebaseAuth.instance.signInWithCredential(
    credential,
  );
}