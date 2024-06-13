import 'dart:collection';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pieklo_nurki/components/animated_toggle.dart';
import 'package:pieklo_nurki/components/arrows.dart';
import 'package:pieklo_nurki/components/connection_pad.dart';
import 'package:pieklo_nurki/providers/providers.dart';

class GameConnection extends ConsumerWidget {
  const GameConnection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final socketService = ref.watch(socketConnectionProvider);
    final bool isConnected = socketService.isConnected;

    ref.listen<bool>(toggleProvider, (previous, next) {
      if (isConnected) {
        final command = next ? 'T' : 'F';
        socketService.sendCommand(command);
      }
    });

    ref.listen<Queue<String>>(pressedArrowsQueueProvider, (previous, next) {
      if (isConnected && next.isNotEmpty) {
        final lastArrow = next.last;
        socketService.sendCommand(lastArrow[0]);
      }
    });

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
                        width: 50.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: const Color(0xffffe80a),
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: Colors.black,
                          icon: const Icon(Icons.arrow_back, size: 30.0),
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
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Activate Stratagems Console',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                AnimatedToggle(),
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
                                  child: ArrowPad(),
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
