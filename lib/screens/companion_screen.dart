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
      ..loadRequest(Uri.parse('https://helldiverscompanion.com/'));
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
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 40.0, // Adjust width as needed
                    height: 120.0, // Adjust height as needed
                    decoration: BoxDecoration(
                      color: Color(0xffffe80a),
                      borderRadius: BorderRadius.circular(10.0), // Adjust the border radius for rounded corners
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Colors.black,
                      icon: Icon(Icons.arrow_back),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
