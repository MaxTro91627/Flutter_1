import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_1/model/news.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart' as extended;
import 'package:url_launcher/url_launcher.dart';

class NewsInfo extends StatefulWidget {
  final News? news;
  NewsInfo(News newsList, {required this.news});

  @override
  _NewsInfoState createState() => _NewsInfoState();
}

class _NewsInfoState extends State<NewsInfo> {
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    var pinnedHeaderHeight = statusBarHeight + kToolbarHeight;
    return Scaffold (
      body: extended.ExtendedNestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget> [
            SliverAppBar(
              pinned: true,
              expandedHeight: 200,
              title: Text(widget.news?.title ?? ""),
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(widget.news?.urlToImage ?? "", fit: BoxFit.fill),
              ),
            )
          ];
        },
        pinnedHeaderSliverHeightBuilder: () => pinnedHeaderHeight,
        body: Container(
          child: Card(
            borderOnForeground: true,
            elevation: 5,
            margin: EdgeInsets.all(10),
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.news?.title ?? "",
                    style: TextStyle(
                      fontSize: 20, 
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    widget.news?.description ?? "", 
                    style: TextStyle(fontSize: 18)
                  ),
                  SizedBox(height: 20,),
                  Container(
                    child: InkWell (  
                      onTap: () async {
                        if (await canLaunchUrl((widget.news?.url ?? "") as Uri)) {
                          await launchUrl((widget.news?.url ?? "") as Uri);
                        } else {
                          log('problem in launching');
                        }
                      },                     
                      child: Text(
                        widget.news?.url ?? "",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                    )
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}