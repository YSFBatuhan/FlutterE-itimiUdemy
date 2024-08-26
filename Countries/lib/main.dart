import 'package:flutter/material.dart';
import 'package:world_countries/anasayfa.dart';

void main() {
  runApp(const MyApp());
}
const String apiKey = "https://restcountries.com/v3.1/all?fields=name,flags,cca2,capital,region,languages,population,currencies";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
    );
  }
}

