import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:book_app/providers/book_provider.dart';
import 'package:book_app/providers/search_provider.dart';
import 'package:book_app/providers/book_detail_provider.dart';
import 'package:book_app/screens/book_list_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BookProvider()),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
        ChangeNotifierProvider(create: (context) => BookDetailProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BookListScreen(),
    );
  }
}
