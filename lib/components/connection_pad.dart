import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pieklo_nurki/components/connection_status.dart';
import 'package:pieklo_nurki/components/masked_text_field.dart';
import 'package:pieklo_nurki/components/qr_scanner.dart';
import 'package:pieklo_nurki/providers/providers.dart';
import 'package:pieklo_nurki/services/socket_connection_service.dart';

class ConnectionPad extends ConsumerStatefulWidget {
  const ConnectionPad({Key? key}) : super(key: key);

  @override
  _ConnectionPadState createState() => _ConnectionPadState();
}

class _ConnectionPadState extends ConsumerState<ConnectionPad> {
  late TextEditingController _textControllerIP;
  late TextEditingController _textControllerPort;
  String _port = '';
  String _serverIp = '';

  @override
  void initState() {
    super.initState();
    _textControllerIP = TextEditingController();
    _textControllerPort = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final socketService = ref.watch(socketConnectionProvider);
    final connectionStatus = _getConnectionStatus(socketService);

    return Consumer(builder: (context, ref, child) {
      ref.listen<String?>(scannedDataProvider, (previous, next) {
        if (next != null) {
          _processScannedData(next);
        }
      });
      return Container(
        padding: const EdgeInsets.all(10.0),
        color: Colors.black.withOpacity(.4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildConnectionStatusIndicator(connectionStatus),
            const SizedBox(width: 10),
            _buildIpAddressTextField(),
            const SizedBox(width: 10),
            _buildPortTextField(),
            const SizedBox(width: 10),
            _buildConnectButton(connectionStatus),
            const SizedBox(width: 10),
            _buildQrCodeButton(),
          ],
        ),
      );
    });
  }

  Widget _buildConnectionStatusIndicator(ConnectionStatus status) {
    return ConnectionStatusIndicator(status: status);
  }

  Widget _buildIpAddressTextField() {
    return Expanded(
      child: MaskedTextField(
        onChange: (value) => _serverIp = value,
        textFieldController: _textControllerIP,
        mask: "xxx.xxx.xxx.xxx",
        maxLength: 15,
        keyboardType: TextInputType.number,
        inputDecoration: _getTextFieldDecoration('IP Address'),
      ),
    );
  }

  Widget _buildPortTextField() {
    return Expanded(
      child: MaskedTextField(
        onChange: (value) => _port = value,
        textFieldController: _textControllerPort,
        mask: "xxxx",
        maxLength: 4,
        keyboardType: TextInputType.number,
        inputDecoration: _getTextFieldDecoration('Port'),
      ),
    );
  }

  InputDecoration _getTextFieldDecoration(String hintText) {
    return InputDecoration(
      isDense: true,
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.white),
      counterText: "",
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xffffe80a)),
      ),
      contentPadding: EdgeInsets.all(10.0),
    );
  }

  Widget _buildConnectButton(ConnectionStatus status) {
    final isConnected = status == ConnectionStatus.connected;
    return ElevatedButton(
      onPressed: () => _handleConnectButtonPressed(isConnected),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: const Color(0xffffe80a),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
      ),
      child: Text(
        isConnected ? 'Disconnect' : 'Connect',
        style: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _handleConnectButtonPressed(bool isConnected) async {
    if (isConnected) {
      ref.read(socketConnectionProvider).disconnect();
    } else {
      if (_serverIp.isEmpty || _port.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Center(child: Text('Please enter IP and Port of the server')),
          ),
        );
      } else {
        await ref
            .read(socketConnectionProvider)
            .connectToServer(_serverIp, int.parse(_port));
      }
    }
  }

  Widget _buildQrCodeButton() {
    return ElevatedButton(
      onPressed: _showQrScannerDialog,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xffffe80a),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
      ),
      child: const Icon(Icons.qr_code, color: Colors.black, size: 30.0),
    );
  }

  void _showQrScannerDialog() {
    showDialog(
      context: context,
      builder: (context) => Align(
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: const QrScanner(),
            ),
          ],
        ),
      ),
    );
  }

  ConnectionStatus _getConnectionStatus(SocketConnectionService socketService) {
    if (socketService.isConnecting) {
      return ConnectionStatus.connecting;
    } else if (socketService.isConnected) {
      return ConnectionStatus.connected;
    } else {
      return ConnectionStatus.disconnected;
    }
  }

  void _processScannedData(String scannedData) {
    List<String> parts = scannedData.split(';');
    if (parts.length == 2) {
      setState(() {
        _serverIp = parts[0];
        _port = parts[1];
        _textControllerIP.text = _serverIp;
        _textControllerPort.text = _port;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(child: Text('Invalid QR code format')),
        ),
      );
    }
  }

  @override
  void dispose() {
    ref.read(socketConnectionProvider).disconnect();
    _textControllerIP.dispose();
    _textControllerPort.dispose();
    super.dispose();
  }
}
