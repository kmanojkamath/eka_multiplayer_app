import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eka_multiplayer_app/screens/game_screen.dart';
import 'package:eka_multiplayer_app/screens/launch_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAuth.instance.useAuthEmulator('10.0.2.2', 9099);
  FirebaseFirestore.instance.useFirestoreEmulator(
    '10.0.2.2',
    8080,
  );
  await GoogleSignIn.instance.initialize(
    serverClientId:
        "766717220987-te3759cpj5cijdrlo6r2g6fi97ucmdnk.apps.googleusercontent.com",
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: LaunchScreen());
  }
}
