import 'package:flutter/material.dart';
import 'package:tcp_socket_connection/tcp_socket_connection.dart';

class SocketConnectionService extends ChangeNotifier {
  TcpSocketConnection? _socketConnection;
  bool _connected = false;
  bool _isConnecting = false;

  bool get isConnected => _connected;
  bool get isConnecting => _isConnecting;

  Future<void> connectToServer(String ip, int port) async {
    _isConnecting = true;
    notifyListeners();

    _socketConnection = TcpSocketConnection(ip, port);

    try {
      final result =
          await _socketConnection!.connect(5000, _handleMessage, attempts: 3);
      if (result == null || !result) {
        _connected = false;
      } else {
        _connected = true;
      }
    } catch (e) {
      print('Exception during connection: $e');
      _connected = false;
    } finally {
      _isConnecting = false;
      notifyListeners();
    }
  }

  void disconnect() {
    if (_socketConnection != null) {
      _socketConnection!.disconnect();
      _connected = false;
      notifyListeners();
    }
  }

  void sendCommand(String command) {
    if (_connected && _socketConnection != null) {
      _socketConnection!.sendMessage(command);
    }
  }

  void _handleMessage(String msg) {
    if (msg == "Connection established") {
      _connected = true;
      notifyListeners();
    } else if (msg == "STOP") {
      disconnect();
    }
  }

  @override
  void dispose() {
    disconnect();
    super.dispose();
  }
}
