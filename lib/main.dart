import 'package:flutter/material.dart';
import 'package:news/pages/show_news.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ShowNews());
  }
}
