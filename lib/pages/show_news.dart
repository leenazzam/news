import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news/models/articlesModel.dart';
import 'package:news/services/news_services.dart';

class ShowNews extends StatefulWidget {
  const ShowNews({super.key});

  @override
  State<ShowNews> createState() => _ShowNewsState();
}

class _ShowNewsState extends State<ShowNews> {
  bool isLoader = true;
  String errMsg = '';
  final List<String> categories = [
    'business',
    'entertainment',
    'general',
    'health',
    'science',
    'sports',
    'technology',
  ];
  String selectedCategory = 'general';
  List<Articlesmodel> listArticle = [];
  final NewsServices newsServices = NewsServices();
  void fetchNews() async {
    try {
      List<Articlesmodel> articles = await newsServices.getNews(
        selectedCategory,
      );
      setState(() {
        listArticle = articles;
        isLoader = false;
      });
    } catch (err) {
      setState(() {
        isLoader = false;
        errMsg = err.toString();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text('News'),
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 30),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              children: [
                DropdownButton(
                  hint: Text('Category'),
                  items: categories.map((category) {
                    return DropdownMenuItem(
                      child: Text(category),
                      value: category,
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      selectedCategory = value;
                      fetchNews();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),

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
