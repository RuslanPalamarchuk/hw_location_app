import 'package:flutter/material.dart';
import 'my_home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Location',
      home: MyHomePage(title: 'Location'),
    );
  }
}
