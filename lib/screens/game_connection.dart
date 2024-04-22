import 'dart:collection';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pieklo_nurki/components/animated_toggle.dart';
import 'package:pieklo_nurki/components/arrows.dart';
import 'package:pieklo_nurki/components/connection_pad.dart';
import 'package:pieklo_nurki/utility/app_state.dart';
import 'package:provider/provider.dart';

class GameConnection extends StatefulWidget {
  const GameConnection({Key? key}) : super(key: key);

  @override
  State<GameConnection> createState() => _GameConnectionState();
}

class _GameConnectionState extends State<GameConnection> {
  // bool _switchValue = false;
  // final Queue<String> _pressedArrowsQueue = Queue<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        top: true,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/background.png',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ConnectionPad(),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: const Color(0xffffe80a),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: Colors.black,
                          icon: const Icon(Icons.arrow_back),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 3,
                          color: Colors.black.withOpacity(.4),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'Activate Stratagems Console',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                AnimatedToggle(
                                  activation:
                                      context.watch<AppState>().switchValue,
                                  onChanged: (value) {
                                    context.read<AppState>().switchValue =
                                        value;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: Container(
                                color: Colors.black.withOpacity(.4),
                                child: Center(
                                  child: ArrowPad(
                                    onArrowsPressed: (arrows) {
                                      context
                                          .read<AppState>()
                                          .addPressedArrow(arrows.last);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
