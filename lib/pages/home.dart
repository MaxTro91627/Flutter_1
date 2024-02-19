import 'package:flutter/material.dart';
import 'package:flutter_1/model/news.dart';
import 'package:flutter_1/pages/news_info.dart';
import 'package:flutter_1/service/news_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<News> newsList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: Text("Home page"),
      ),
      body: Container(
        child: FutureBuilder(
          future: getNewsList('trending'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (newsList.length == 0) {
                return Center(child: Text('Nothing new'),);
              } else {
                return ListView.builder(
                  itemCount: newsList.length,
                  itemBuilder: (context, index) {
                    return InkWell (
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return NewsInfo(newsList[index], news: newsList[index],);
                        },));
                      },
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: FadeInImage(
                          height: 200,
                          width: 100,
                          fit: BoxFit.fill,
                          placeholder: AssetImage(
                            "assets/photo.jpg"
                          ),
                          image: NetworkImage(
                            newsList[index].urlToImage ?? "https://static.tildacdn.com/tild3238-3765-4061-b862-626663363738/photo.jpg"
                          ),
                        ),
                      ),
                      title: Text(newsList[index].title ?? ":("),
                      subtitle: Text(
                        newsList[index].description ?? "",
                        maxLines: 2,
                      ),
                     ),
                   );
                },);
              }
            } else if (snapshot.hasError) {
              return Center(child: Text("Problem in getting news \n${snapshot.error}"),);
            } else {
              return Center(child: CircularProgressIndicator(),);
            }
          },
        ),
      )
    );
  }
  
  getNewsList(String s) async {
    newsList = await NewsService().getNewsList(s);
    return newsList;
  }
}