import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'create_room_screen.dart';

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

      final GoogleSignInAccount googleUser = await GoogleSignIn.instance
          .authenticate();

      final googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final user = FirebaseAuth.instance.currentUser;

      await user!.linkWithCredential(credential);

      debugPrint("Guest upgraded to Google account");

      FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'name': googleUser.displayName,
      }, SetOptions(merge: true));
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
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
              final user = FirebaseAuth.instance.currentUser;

              if (user != null && user.isAnonymous) {
                await user.delete(); // deletes guest account
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(user.uid)
                    .delete();
              }

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
                      text: "Create Room",
                      icon: Icons.add_circle_outline,
                      onPressed: () async {
                        String random6CharString() {
                          const chars =
                              'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*';

                          final random = Random();

                          return List.generate(
                            6,
                            (index) => chars[random.nextInt(chars.length)],
                          ).join();
                        }

                        Future<String> generateUniqueRoomId() async {
                          String roomId;

                          do {
                            roomId = random6CharString();
                          } while ((await FirebaseFirestore.instance
                                  .collection('rooms')
                                  .doc(roomId)
                                  .get())
                              .exists);

                          return roomId;
                        }

                        final roomId = await generateUniqueRoomId();

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CreateRoomScreen(roomId),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 14),

                    buildButton(
                      text: "Join Room",
                      icon: Icons.door_front_door,
                      onPressed: () {
                        debugPrint("Join Room");
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
