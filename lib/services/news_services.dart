import 'package:dio/dio.dart';
import 'package:news/models/articlesModel.dart';

class NewsServices {
  Dio dio = Dio();
  final String baseUrl = 'https://newsapi.org/v2/everything';
  final String apiKey = '01e733f14a144d409430830f29fd1ebd';

  Future<List<Articlesmodel>> getNews(String category) async {
    try {
      Response res = await dio.get(
        '${baseUrl}?q=${category}&from=2025-07-24&sortBy=publishedAt&apiKey=${apiKey}',
      );
      List<dynamic> articles = res.data['articles'];
      return articles.map((item) {
        return Articlesmodel.fromJson(item);
      }).toList();
    } catch (err) {
      throw new Exception(err);
    }
  }
}
