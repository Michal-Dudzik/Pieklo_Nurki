import 'dart:collection';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pieklo_nurki/services/socket_connection_service.dart';

class GameConnectionState extends StateNotifier<bool> {
  final SocketConnectionService _socketService;

  GameConnectionState(this._socketService) : super(false);

  void listenToToggle(bool next) {
    state = next;
  }

  void listenToPressedArrows(Queue<String> next) {
    if (_socketService.isConnected && next.isNotEmpty) {
      final lastArrow = next.last;
      _socketService.sendCommand(lastArrow[0]);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
