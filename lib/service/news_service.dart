import 'dart:convert';
import 'dart:developer';

import 'package:flutter_1/model/news.dart';
import 'package:http/http.dart' as http;

class NewsService {
  static String BASE_URL = "https://newsapi.org/v2/everything?q=";
  getNewsList(String query) async {
    var response = await http.get(Uri.parse(BASE_URL+query+"&apiKey=1cee32705efc4f33b48789fbb74b3676"));
    if (response.statusCode == 200) {
       List<News> newsList;
       var finalResult = json.decode(response.body);
       newsList = (finalResult['articles'] as List).map((i) => News.fromJson(i)).toList();
       return newsList;
    } else {
      log('problems in getting news');
    }
  }
}