import 'package:flutter/material.dart';
import 'package:guillaume_pelletier/Accueil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Auth Demo',
      home:Accueil(),
    );
  }
}