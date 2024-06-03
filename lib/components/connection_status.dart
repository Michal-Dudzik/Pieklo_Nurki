import 'package:flutter/material.dart';

enum ConnectionStatus {
  connecting,
  connected,
  disconnected,
}

class ConnectionStatusIndicator extends StatelessWidget {
  final ConnectionStatus status;

  const ConnectionStatusIndicator({Key? key, required this.status})
      : super(key: key);

  Color _getColor(ConnectionStatus status) {
    switch (status) {
      case ConnectionStatus.connecting:
        return const Color(0xffffe80a);
      case ConnectionStatus.connected:
        return Colors.green;
      case ConnectionStatus.disconnected:
        return Colors.red;
    }
  }

  String _getText(ConnectionStatus status) {
    switch (status) {
      case ConnectionStatus.connecting:
        return 'Connecting';
      case ConnectionStatus.connected:
        return 'Connected';
      case ConnectionStatus.disconnected:
        return 'Disconnected';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (status == ConnectionStatus.connecting)
          SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(_getColor(status)),
            ),
          )
        else
          Icon(
            Icons.wifi,
            color: _getColor(status),
          ),
        const SizedBox(width: 10),
        Text(
          'Status: ',
          style: TextStyle(
            color: _getColor(status),
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          _getText(status),
          style: TextStyle(
            color: _getColor(status),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
