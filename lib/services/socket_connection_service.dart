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
      print('Attempting to connect to $ip:$port');
      final result =
          await _socketConnection!.connect(5000, messageReceived, attempts: 3);
      if (result == null || !result) {
        print('Failed to connect');
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

    if (_connected) {
      print('Connected to server');
    } else {
      print('Failed to connect to the server');
    }
  }

  void disconnect() {
    if (_socketConnection != null) {
      _socketConnection!.disconnect();
      _connected = false;
      notifyListeners();
      print('Disconnected from server');
    }
  }

  void sendCommand(String command) {
    if (_connected && _socketConnection != null) {
      print('Sending command: $command');
      _socketConnection!.sendMessage(command);
    } else {
      print('Not connected to the server');
    }
  }

  void messageReceived(String msg) {
    print('Message received: $msg');
    if (msg == "Connection established") {
      print('Server connection confirmed');
      _connected = true;
      notifyListeners();
    } else {
      // Handle other messages
    }
    if (_connected && _socketConnection != null) {
      _socketConnection!.sendMessage("MessageIsReceived :D ");
    }
  }

  @override
  void dispose() {
    disconnect();
    super.dispose();
  }
}
