import 'package:flutter/material.dart';
import 'package:toko_online/screens/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'BayPedia',
      home: HomePage(),
    );
  }
}
