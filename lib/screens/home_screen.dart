import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  Future<void> upgradeGuestAccount() async {
    try {
      setState(() => isLoading = true);

      final GoogleSignInAccount googleUser =
          await GoogleSignIn.instance.authenticate();

      final googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final user = FirebaseAuth.instance.currentUser;

      if (user != null && user.isAnonymous) {
        await user.linkWithCredential(credential);

        debugPrint("Guest upgraded to Google account");
      } else {
        await FirebaseAuth.instance.signInWithCredential(credential);
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
      debugPrint(e.message);
    } catch (e) {
      debugPrint(e.toString());
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
      width: 280,
      height: 58,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28),
            const SizedBox(width: 10),
            Text(
              text,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),

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
                  style: TextStyle(
                    fontSize: 69,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),

              AnimatedOpacity(
                opacity: showSubtitle ? 1 : 0,
                duration: const Duration(milliseconds: 540),
                child: const Text(
                  "Player vs Bot",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const Spacer(flex: 2),

              AnimatedScale(
                scale: showButtons ? 1 : 0,
                duration: const Duration(milliseconds: 480),
                child: Column(
                  children: [
                    buildButton(
                      text: "Play",
                      icon: Icons.play_arrow_rounded,
                      onPressed: () {
                        debugPrint("Play pressed");
                      },
                    ),

                    const SizedBox(height: 14),

                    if (user?.isAnonymous ?? false)
                      GestureDetector(
                        onTap: upgradeGuestAccount,
                        child: const Text(
                          "Upgrade to Google Account",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
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