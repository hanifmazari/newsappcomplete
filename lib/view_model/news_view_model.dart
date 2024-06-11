import 'package:newsapp/model/categories_news_model.dart';
import 'package:newsapp/model/news_headlines_api_model.dart';
import 'package:newsapp/repositories/news_headline_api_repository.dart';

class NewsViewModel {
  Future<NewsHeadlineApiModel> fetchNewsHeadlineApi(String channelName ) async {
    final response = await NewsRepository().fetchNewsHeadlineApi(channelName);
    return response;
  }

  //CAtegory news view
  Future<CategoryNewsModel> fetchNewsCategoryApi(String categoryName ) async {
    final response = await NewsRepository().fetchNewsCategoryApi(categoryName);
    return response;
  }
}
