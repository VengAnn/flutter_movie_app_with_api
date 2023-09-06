import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewAppWidget extends StatefulWidget {
  const WebViewAppWidget({super.key, required this.title, required this.url});
  final String title;
  final String url;

  @override
  State<WebViewAppWidget> createState() => _WebViewAppWidgetState();
}

class _WebViewAppWidgetState extends State<WebViewAppWidget> {
  late final WebViewController controller;
  var loadingPercentage = 0;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse(widget.url),
      );
    controller.setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            loadingPercentage = 0;
          });
        },
        onProgress: (progress) {
          setState(() {
            loadingPercentage = progress;
          });
        },
        onPageFinished: (url) {
          setState(() {
            loadingPercentage = 100;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Builder(
        builder: (_) {
          //if url isEmpty show Text
          if (widget.url.isEmpty) {
            return const Center(
              child: Text('HomePage is Empty'),
            );
          }
          //otherwise
          return Stack(
            children: [
              WebViewWidget(
                controller: controller,
              ),
              //let's check condition if loading < 100 mean it prossesing
              loadingPercentage < 100
                  ? const Positioned.fill(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  //and when loading = 100 show sizebox;
                  : const SizedBox(),
            ],
          );
        },
      ),
    );
  }
}
