import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MediaIG extends StatelessWidget {
  const MediaIG({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: "https://www.instagram.com/soyes.susukedelai/",
      ),
    );
  }
}
