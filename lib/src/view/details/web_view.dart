import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newz/src/widget/error_show.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:webview_flutter/webview_flutter.dart';

import '../../widget/custom_list_tiles.dart';
import '../../widget/utils.dart';

class NewsDetailsWeb extends StatefulWidget {
  final String url;

  const NewsDetailsWeb({super.key, required this.url});

  @override
  State<NewsDetailsWeb> createState() => _NewsDetailsWebState();
}

class _NewsDetailsWebState extends State<NewsDetailsWeb> {
  WebViewController? _webViewController;
  double _progress = 0.0;
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
    return WillPopScope(
      onWillPop: () async {
        if (await _webViewController!.canGoBack()) {
          _webViewController!.goBack();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: color),
          elevation: 0,
          centerTitle: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            "NewZ",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18.sp, color: color),
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  await _showModelSheet();
                },
                icon: Icon(
                  Icons.more_horiz,
                  size: 20.w,
                ))
          ],
        ),
        body: Column(
          children: [
            LinearProgressIndicator(
              value: _progress,
              color: _progress == 1.0 ? Colors.transparent : Colors.blueAccent,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
            Expanded(
              child: WebView(
                initialUrl: widget.url,
                zoomEnabled: true,
                onProgress: (progress) {
                  _progress = progress / 100;
                },
                onWebViewCreated: (controller) {
                  _webViewController = controller;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showModelSheet() async {
    await showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.w),
          ),
        ),
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20.w),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 5.h,
                ),
                Center(
                  child: Container(
                    height: 7.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20.w)),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "More Option",
                  style:
                      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Divider(
                  thickness: 2.h,
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomListTiles(
                    icons: Icons.share,
                    onTap: () async {
                      try {
                        Share.share(widget.url, subject: "Look what I made");
                      } catch (e) {
                        showMessage(e.toString(), context);
                        ;
                      } finally {
                        Navigator.pop(context);
                      }
                    },
                    title: "Share"),
                CustomListTiles(
                    icons: Icons.open_in_browser,
                    onTap: () async {
                      try {
                        if (!await launchUrl(Uri.parse(widget.url)))
                          throw showMessage(
                              "Could not launch {$widget.url} ", context);
                      } catch (e) {
                        showMessage(e.toString(), context);
                        ;
                      } finally {
                        Navigator.pop(context);
                      }
                    },
                    title: "Open in browser"),
                CustomListTiles(
                    icons: Icons.refresh,
                    onTap: () async {
                      try {
                        _webViewController!.reload();
                      } catch (e) {
                        showMessage(e.toString(), context);
                      } finally {
                        Navigator.pop(context);
                      }
                    },
                    title: "Refresh"),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          );
        });
  }
}
