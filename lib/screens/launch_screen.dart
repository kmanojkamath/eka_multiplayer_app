import 'auth_wrapper.dart';
import 'package:flutter/material.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({super.key});

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  Offset offset1 = const Offset(25, 0);
  Offset offset2 = const Offset(25, 0);
  Offset offset3 = const Offset(25, 0);
  Offset offset4 = const Offset(25, 0);
  double opacity = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() => offset1 = const Offset(-1.5, 0));
      await Future.delayed(const Duration(milliseconds: 420));

      setState(() => offset2 = const Offset(-0.5, 0));
      await Future.delayed(const Duration(milliseconds: 420));

      setState(() => offset3 = const Offset(0.35, 0));
      await Future.delayed(const Duration(milliseconds: 420));

      setState(() => offset4 = const Offset(1.75, 0));
      await Future.delayed(const Duration(milliseconds: 810));

      setState(() => opacity = 1);
      await Future.delayed(const Duration(milliseconds: 1008));

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => AuthWrapper()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            AnimatedSlide(
              offset: offset1,
              duration: const Duration(milliseconds: 810),
              curve: Curves.easeInOut,
              child: const Text("K", style: _style),
            ),
            AnimatedSlide(
              offset: offset2,
              duration: const Duration(milliseconds: 810),
              curve: Curves.easeInOut,
              child: const Text("K", style: _style),
            ),
            AnimatedSlide(
              offset: offset3,
              duration: const Duration(milliseconds: 810),
              curve: Curves.easeInOut,
              child: const Text("M", style: _style),
            ),
            AnimatedSlide(
              offset: offset4,
              duration: const Duration(milliseconds: 810),
              curve: Curves.easeInOut,
              child: const Text("K", style: _style),
            ),
          ],
        ),
        AnimatedOpacity(
          opacity: opacity,
          duration: const Duration(milliseconds: 360),
          child: Text(
            "PRESENTS",
            style: const TextStyle(
              fontFamily: "Montserrat",
              fontSize: 12,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ],
    );
  }
}

const TextStyle _style = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w900,
  fontFamily: "Montserrat",
  decoration: TextDecoration.none,
);
