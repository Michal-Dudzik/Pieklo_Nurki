import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pieklo_nurki/providers/providers.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScanner extends ConsumerStatefulWidget {
  const QrScanner({Key? key}) : super(key: key);

  @override
  _QrScannerState createState() => _QrScannerState();
}

class _QrScannerState extends ConsumerState<QrScanner> {
  QRViewController? _qrController;

  @override
  Widget build(BuildContext context) {
    return QRView(
      key: GlobalKey(debugLabel: 'QR'),
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderRadius: 10,
        borderWidth: 5,
        borderColor: const Color(0xffffe80a),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    _qrController = controller;
    controller.scannedDataStream.listen((scanData) {
      controller.pauseCamera();
      ref.read(scannedDataProvider.notifier).state = scanData.code;
      Navigator.of(context).pop();
    });
  }

  @override
  void dispose() {
    _qrController?.dispose();
    super.dispose();
  }
}
