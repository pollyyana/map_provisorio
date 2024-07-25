import 'package:app_teste/app/person_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_teste/app/map_screen.dart'; 

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PersonProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MapScreen(),
    );
  }
}
