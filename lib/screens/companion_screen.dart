import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CompanionScreen extends StatefulWidget {
  const CompanionScreen({Key? key}) : super(key: key);

  @override
  State<CompanionScreen> createState() => _CompanionScreenState();
}

class _CompanionScreenState extends State<CompanionScreen> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..clearCache()
      ..loadRequest(Uri.parse('https://helldiverscompanion.com/'));
  }

  void clearCache() async {
    await _controller.clearCache();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              WebViewWidget(controller: _controller),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: const BoxDecoration(
                      color: Color(0xffffe80a),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Colors.black,
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
