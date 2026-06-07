import 'package:flutter/material.dart';

import '../logics/colors.dart';
import '../logics/card_storage.dart';
import '../logics/positions.dart';

class ColorSelector extends StatefulWidget {
  final CardStorage cardStorage;
  const ColorSelector(this.cardStorage,{super.key});

  @override
  State<ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  bool show = false;
  bool start = false;
  @override
  void initState() {
    super.initState();
    widget.cardStorage.showColorSelector = () async {
      setState(() {
        show = true;
      });
      await Future.delayed(Duration(milliseconds: 10));
      setState(() {
        start = true;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    Positions positions = Positions(CardStorage(), MediaQuery.sizeOf(context));
    double x = positions.screenSize.width / 17;
    if (show) {
      return Align(
        alignment: AlignmentGeometry.center,
        child: Stack(
          children: [
            AnimatedOpacity(
              opacity: start ? 0.69 : 0,
              duration: Duration(milliseconds: 180),
              child: Container(decoration: BoxDecoration(color: Colors.black)),
            ),
            Positioned(
              left: x,
              top: positions.screenSize.height * 0.2,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () async {
                    widget.cardStorage.selectedColor.value = CardColor.red;
                    await Future.delayed(Duration(milliseconds: 101));
                    setState(() {
                      start = false;
                    });
                    await Future.delayed(Duration(milliseconds: 179));
                    setState(() {
                      show = false;
                    });
                  },
                  borderRadius: BorderRadius.circular(
                    positions.screenSize.height * 0.05,
                  ),
                  child: AnimatedScale(
                    scale: start ? 1 : 0,
                    duration: Duration(milliseconds: 180),
                    child: Ink(
                      width: 3 * x,
                      height: 3 * x,
                      decoration: BoxDecoration(
                        color: color(CardColor.red),
                        borderRadius: BorderRadius.circular(
                          positions.screenSize.height * 0.05,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 5 * x,
              top: positions.screenSize.height * 0.2,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () async {
                    widget.cardStorage.selectedColor.value = CardColor.green;
                    await Future.delayed(Duration(milliseconds: 101));
                    setState(() {
                      start = false;
                    });
                    await Future.delayed(Duration(milliseconds: 179));
                    setState(() {
                      show = false;
                    });
                  },
                  borderRadius: BorderRadius.circular(
                    positions.screenSize.height * 0.05,
                  ),
                  child: AnimatedScale(
                    scale: start ? 1 : 0,
                    duration: Duration(milliseconds: 180),
                    child: Ink(
                      width: 3 * x,
                      height: 3 * x,
                      decoration: BoxDecoration(
                        color: color(CardColor.green),
                        borderRadius: BorderRadius.circular(
                          positions.screenSize.height * 0.05,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 9 * x,
              top: positions.screenSize.height * 0.2,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () async {
                    widget.cardStorage.selectedColor.value = CardColor.blue;
                    await Future.delayed(Duration(milliseconds: 101));
                    setState(() {
                      start = false;
                    });
                    await Future.delayed(Duration(milliseconds: 179));
                    setState(() {
                      show = false;
                    });
                  },
                  borderRadius: BorderRadius.circular(
                    positions.screenSize.height * 0.05,
                  ),
                  child: AnimatedScale(
                    scale: start ? 1 : 0,
                    duration: Duration(milliseconds: 180),
                    child: Ink(
                      width: 3 * x,
                      height: 3 * x,
                      decoration: BoxDecoration(
                        color: color(CardColor.blue),
                        borderRadius: BorderRadius.circular(
                          positions.screenSize.height * 0.05,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 13 * x,
              top: positions.screenSize.height * 0.2,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () async {
                    widget.cardStorage.selectedColor.value = CardColor.yellow;
                    await Future.delayed(Duration(milliseconds: 101));
                    setState(() {
                      start = false;
                    });
                    await Future.delayed(Duration(milliseconds: 179));
                    setState(() {
                      show = false;
                    });
                  },
                  borderRadius: BorderRadius.circular(
                    positions.screenSize.height * 0.05,
                  ),
                  child: AnimatedScale(
                    scale: start ? 1 : 0,
                    duration: Duration(milliseconds: 180),
                    child: Ink(
                      width: 3 * x,
                      height: 3 * x,
                      decoration: BoxDecoration(
                        color: color(CardColor.yellow),
                        borderRadius: BorderRadius.circular(
                          positions.screenSize.height * 0.05,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
