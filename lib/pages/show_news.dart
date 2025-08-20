import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news/models/articlesModel.dart';

class ShowNews extends StatefulWidget {
  const ShowNews({super.key});

  @override
  State<ShowNews> createState() => _ShowNewsState();
}

class _ShowNewsState extends State<ShowNews> {
  List<Articlesmodel> listArticle = [];
  bool isLoader = true;
  String errMsg = '';
  void getNews() async {
    try {
      Dio dio = Dio();
      Response res = await dio.get(
        'https://newsapi.org/v2/everything?q=tesla&from=2025-07-19&sortBy=publishedAt&apiKey=01e733f14a144d409430830f29fd1ebd',
      );
      Map<String, dynamic> data = res.data;
      List<dynamic> articles = data['articles'];
      List<Articlesmodel> articleList = [];
      for (var element in articles) {
        Articlesmodel article = Articlesmodel(
          title: element['title'],
          desc: element['title'],
          img: element['title'],
        );
        articleList.add(article);
      }
      setState(() {
        listArticle = articleList;
        isLoader = false;
      });
    } catch (err) {
      setState(() {
        isLoader = false;
        errMsg = 'Server Error';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('News')),
      body: isLoader
          ? Center(child: CircularProgressIndicator())
          : errMsg.isNotEmpty
          ? Center(
              child: Text(errMsg, style: TextStyle(color: Colors.red)),
            )
          : ListView.builder(
              itemCount: listArticle.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.blueAccent,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(listArticle[index].title),
                  ),
                );
              },
            ),
    );
  }
}
