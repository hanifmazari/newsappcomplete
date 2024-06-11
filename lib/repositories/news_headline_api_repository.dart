import 'package:http/http.dart' as http;
import 'package:newsapp/model/categories_news_model.dart';
import 'dart:convert';
import '../model/news_headlines_api_model.dart';

class NewsRepository {
  // fetchNewsHeadlineApi
  Future<NewsHeadlineApiModel> fetchNewsHeadlineApi(String channelName) async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=$channelName&apiKey=3b086e1c3e0646c1b8f0316c40bb9c03';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsHeadlineApiModel.fromJson(body);
    } else {
      throw Exception('Error: Failed to load');
    }
  }

  // fetch News category Api
  Future<CategoryNewsModel> fetchNewsCategoryApi(String categoryName) async {
    String url =
        'https://newsapi.org/v2/top-headlines?country=us&category=$categoryName&apiKey=3b086e1c3e0646c1b8f0316c40bb9c03';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CategoryNewsModel.fromJson(body);
    } else {
      throw Exception('Error: Failed to load');
    }
  }
}
