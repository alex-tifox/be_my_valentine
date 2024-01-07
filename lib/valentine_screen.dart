import 'dart:developer' as dev;
import 'dart:math';

import 'package:be_my_valentine/screen_size_util.dart';
import 'package:flutter/material.dart';

class ValentineScreen extends StatefulWidget {
  const ValentineScreen({super.key});

  @override
  State<ValentineScreen> createState() => _ValentineScreenState();
}

class _ValentineScreenState extends State<ValentineScreen> {
  final random = Random();
  double topPosition = 0;
  double rightPosition = 0;
  bool clickable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          print(constraints.maxHeight);
          print(constraints.maxWidth);
          final screenType = getFormFactor(context);
          final verticalPadding = screenType == ScreenType.desktop
              ? constraints.maxHeight / 2
              : (constraints.maxHeight / 3) * 2;
          return ElevatedButtonTheme(
            data: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                textStyle: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Will You Be My Valentine?',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/kitty.png'),
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      child: SizedBox(
                        height: 200,
                        width: 200,
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: topPosition == 0 ? verticalPadding : topPosition,
                  right: rightPosition == 0
                      ? constraints.maxWidth / 6
                      : rightPosition,
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onHover: clickable
                          ? null
                          : (value) {
                              if (value) {
                                setState(() {
                                  topPosition = random.nextDouble() *
                                      constraints.maxHeight;
                                  rightPosition = random.nextDouble() *
                                      constraints.maxWidth;
                                  clickable = random.nextBool();

                                  if (constraints.maxHeight - topPosition <
                                      80) {
                                    topPosition = constraints.maxHeight - 80;
                                  }

                                  if (constraints.maxWidth - rightPosition <
                                      80) {
                                    rightPosition = constraints.maxWidth - 80;
                                  }
                                });
                              }
                            },
                      onPressed: () {
                        setState(() {
                          topPosition =
                              random.nextDouble() * constraints.maxHeight;
                          rightPosition =
                              random.nextDouble() * constraints.maxWidth;
                          clickable = random.nextBool();

                          if (constraints.maxHeight - topPosition < 80) {
                            topPosition = constraints.maxHeight - 80;
                          }

                          if (constraints.maxWidth - rightPosition < 80) {
                            rightPosition = constraints.maxWidth - 80;
                          }
                          dev.log('Position: ${topPosition.toString()}');
                          dev.log(rightPosition.toString());
                        });
                      },
                      child: Text('No'),
                    ),
                  ),
                ),
                Positioned(
                  top: verticalPadding,
                  left: constraints.maxWidth / 6,
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => showDialog(
                        context: context,
                        builder: (_) => const AlertDialog(
                          title: Text('YES?'),
                          content: Text('Let\'s GOO!!'),
                        ),
                      ),
                      onHover: (value) {
                        // log('onHover: $value');
                      },
                      child: const Text('Yes'),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
