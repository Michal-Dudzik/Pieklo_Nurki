import 'dart:collection';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pieklo_nurki/components/animated_toggle.dart';
import 'package:pieklo_nurki/components/arrows.dart';
import 'package:pieklo_nurki/components/connection_pad.dart';
import 'package:pieklo_nurki/providers/providers.dart';
import 'package:pieklo_nurki/services/socket_connection_service.dart';

class GameConnection extends ConsumerStatefulWidget {
  const GameConnection({Key? key}) : super(key: key);

  @override
  _GameConnectionState createState() => _GameConnectionState();
}

class _GameConnectionState extends ConsumerState<GameConnection> {
  late final SocketConnectionService _socketService;

  @override
  void initState() {
    super.initState();
    _socketService = ref.read(socketConnectionProvider);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<bool>(toggleProvider, (previous, next) {
      if (_socketService.isConnected) {
        _socketService.sendCommand(next as String);
      } else {
        print('Not connected to the server, cannot send toggle state');
      }
    });

    ref.listen<Queue<String>>(pressedArrowsQueueProvider, (previous, next) {
      if (_socketService.isConnected && next.isNotEmpty) {
        final lastArrow = next.last;
        _socketService.sendCommand(lastArrow);
      } else {
        print('Not connected to the server, cannot send last pressed arrow');
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
