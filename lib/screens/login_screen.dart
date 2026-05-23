import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eka_multiplayer_app/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool startTurn = false;
  bool showTitle = false;
  bool showSubtitle = false;
  bool showButtons = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _startAnimations();
  }

  Future<void> _startAnimations() async {
    await Future.delayed(Duration.zero);

    if (!mounted) return;
    setState(() {
      startTurn = true;
      showTitle = true;
    });

    await Future.delayed(const Duration(milliseconds: 360));

    if (!mounted) return;
    setState(() {
      showSubtitle = true;
    });

    await Future.delayed(const Duration(milliseconds: 360));

    if (!mounted) return;
    setState(() {
      showButtons = true;
    });
  }

  Future<void> _googleSignIn() async {
    setState(() => isLoading = true);

    try {
      UserCredential user = await signInWithGoogle();
      debugPrint(FirebaseAuth.instance.currentUser.toString());
      FirebaseFirestore.instance.collection('users').doc(user.user!.uid).set({
        'name': user.user!.displayName,
      }, SetOptions(merge: true));
    } catch (e) {
      debugPrint(e.toString());
    }

    if (mounted) {
      setState(() => isLoading = false);
    }
  }

  Future<void> _anonymousSignIn() async {
    setState(() => isLoading = true);

    try {
      UserCredential user = await FirebaseAuth.instance.signInAnonymously();
      debugPrint("Signed in anonymously.");
      FirebaseFirestore.instance.collection('users').doc(user.user!.uid).set({
        'name': user.user!.displayName,
      });
    } on FirebaseAuthException catch (e) {
      debugPrint("Code: ${e.code}");
      debugPrint("Message: ${e.message}");
    }

    if (mounted) {
      setState(() => isLoading = false);
    }
  }

  Widget buildButton({
    required String text,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: 260,
      height: 52,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            const SizedBox(width: 10),
            Text(
              text,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Transform.scale(
            scale: 3,
            child: AnimatedRotation(
              curve: Curves.linear,
              turns: startTurn ? 12 : 0,
              duration: const Duration(seconds: 81),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: SweepGradient(
                    colors: [
                      Colors.green,
                      Colors.blue,
                      Colors.blue,
                      Colors.yellow,
                      Colors.yellow,
                      Colors.red,
                      Colors.red,
                      Colors.green,
                    ],
                  ),
                ),
              ),
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Spacer(flex: 5),

              AnimatedScale(
                scale: showTitle ? 1 : 0,
                curve: Curves.easeOut,
                duration: const Duration(milliseconds: 540),
                child: const Text(
                  "eka",
                  style: TextStyle(fontSize: 69, fontWeight: FontWeight.w900),
                ),
              ),

              AnimatedOpacity(
                opacity: showSubtitle ? 1 : 0,
                duration: const Duration(milliseconds: 540),
                child: const Text(
                  "Multiplayer",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),

              const Spacer(flex: 2),

              AnimatedScale(
                scale: showButtons ? 1 : 0,
                duration: const Duration(milliseconds: 480),
                child: Column(
                  children: [
                    buildButton(
                      text: "Sign in with Google",
                      icon: Icons.login,
                      onPressed: _googleSignIn,
                    ),

                    const SizedBox(height: 16),

                    buildButton(
                      text: "Continue as Guest",
                      icon: Icons.person_outline,
                      onPressed: _anonymousSignIn,
                    ),
                  ],
                ),
              ),

              if (isLoading)
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: CircularProgressIndicator(),
                ),

              const Spacer(flex: 2),
            ],
          ),
        ],
      ),
    );
  }
}
