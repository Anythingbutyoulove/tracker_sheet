import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello World App',
      theme: ThemeData(
        fontFamily: 'Roboto', // Set custom font
      ),
      home: const HelloWorldScreen(),
    );
  }
}

class HelloWorldScreen extends StatelessWidget {
  const HelloWorldScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Hello World!',
          style: TextStyle(
            fontSize: 32,
            color: Colors.deepPurple, // Custom color
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
