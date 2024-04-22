import 'dart:collection';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pieklo_nurki/components/masked_text_field.dart';
import 'package:pieklo_nurki/utility/app_state.dart';
import 'package:provider/provider.dart';

class ConnectionPad extends StatefulWidget {
  const ConnectionPad({
    Key? key,
  }) : super(key: key);

  @override
  _ConnectionPadState createState() => _ConnectionPadState();
}

class _ConnectionPadState extends State<ConnectionPad> {
  late TextEditingController _textControllerIP;
  late TextEditingController _textControllerPort;
  late Socket _socket;
  bool _connected = false;
  String _port = '';
  String _serverIp = '';

  @override
  void initState() {
    super.initState();
    _textControllerIP = TextEditingController();
    _textControllerPort = TextEditingController();
  }

  void _startKeyboardListener() {
    Socket.connect(_serverIp, _port as int).then((socket) {
      // Handle socket communication
      // e.g., listen for incoming data, send data to server, etc.
      _setupArrowButtons(socket);
    }).catchError((error) {
      print('Error connecting to server: $error');
    });
  }

  void _setupArrowButtons(Socket socket) {
    // it will be checking last element in the arrows queue and send the command to the server based on the last element
    _sendCommand(socket, 'UP');
    _sendCommand(socket, 'DOWN');
    _sendCommand(socket, 'LEFT');
    _sendCommand(socket, 'RIGHT');
  }

  void _sendCommand(Socket socket, String command) {
    socket.write(command);
  }

  @override
  void dispose() {
    _socket.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      color: Colors.black.withOpacity(.4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.wifi,
            color: _connected ? Colors.green : Colors.red,
          ),
          const SizedBox(width: 10),
          Text(
            'Status: ',
            style: TextStyle(
              color: _connected ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            _connected ? 'Connected' : 'Disconnected',
            style: TextStyle(
              color: _connected ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: MaskedTextField(
              onChange: (value) {
                _serverIp = value;
              },
              textFieldController: _textControllerIP,
              mask: "xxx.xxx.xxx.xxx",
              maxLength: 15,
              keyboardType: TextInputType.number,
              inputDecoration: const InputDecoration(
                isDense: true,
                hintText: 'IP Address',
                hintStyle: TextStyle(color: Colors.white),
                counterText: "",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffffe80a)),
                ),
                contentPadding: EdgeInsets.all(10.0),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: MaskedTextField(
              onChange: (value) {
                _port = value;
              },
              textFieldController: _textControllerPort,
              mask: "xxxx",
              maxLength: 4,
              keyboardType: TextInputType.number,
              inputDecoration: const InputDecoration(
                isDense: true,
                hintText: 'Port',
                hintStyle: TextStyle(color: Colors.white),
                counterText: "",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffffe80a)),
                ),
                contentPadding: EdgeInsets.all(10.0),
              ),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              if (_connected) {
                _socket.close();
              } else {
                if (_serverIp.isEmpty || _port.isEmpty) {
                  print('Server IP and Port are required');
                } else {
                  _startKeyboardListener();
                }
              }
              setState(() {
                _connected = !_connected;
              });
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: const Color(0xffffe80a),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
            ),
            child: Text(
              _connected ? 'Disconnect' : 'Connect',
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
