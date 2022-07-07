import 'package:flutter/material.dart';

import 'page/first_page.dart';
import 'page/second_page.dart';
import 'page/third_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        FirstPage.routeName : (context) => FirstPage(),
        SecondPage.routeName : (context) => SecondPage(),
        ThirdPage.routeName : (context) => ThirdPage(),
      },
      home: FirstPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
