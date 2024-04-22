import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pieklo_nurki/components/arrows.dart';

class GameConnection extends StatefulWidget {
  const GameConnection({Key? key}) : super(key: key);

  @override
  State<GameConnection> createState() => _GameConnectionState();
}

class _GameConnectionState extends State<GameConnection> {
  bool _switchValue = false;

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
                      const SizedBox(width: 10),
                      Expanded(
                        child: ConnectionStatus(switchValue: _switchValue),
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
                          child: Switch(
                            value: _switchValue,
                            onChanged: (value) {
                              setState(() {
                                _switchValue = value;
                              });
                            },
                            activeColor: Colors.yellow,
                            activeTrackColor: Colors.yellow,
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
                                      print(arrows);
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

class ConnectionStatus extends StatelessWidget {
  const ConnectionStatus({
    Key? key,
    required this.switchValue,
  }) : super(key: key);

  final bool switchValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.black.withOpacity(.4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(
            Icons.wifi,
            color: switchValue ? Colors.green : Colors.red,
          ),
          SizedBox(width: 8),
          Text(
            switchValue ? 'Connected' : 'Disconnected',
            style: TextStyle(
              color: switchValue ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
