import 'package:flutter/material.dart';

void main() {
  runApp(const AnimatedBoxApp());
}

class AnimatedBoxApp extends StatelessWidget {
  const AnimatedBoxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Container Example',
      debugShowCheckedModeBanner: false,
      home: const AnimatedBoxScreen(),
    );
  }
}

class AnimatedBoxScreen extends StatefulWidget {
  const AnimatedBoxScreen({super.key});

  @override
  State<AnimatedBoxScreen> createState() => _AnimatedBoxScreenState();
}

class _AnimatedBoxScreenState extends State<AnimatedBoxScreen> {
  bool _isTransformed = false;

  void _changeShape() {
    setState(() {
      _isTransformed = !_isTransformed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animated Container')),
      body: Center(
        child: AnimatedContainer(
          width: _isTransformed ? 200 : 100,
          height: _isTransformed ? 200 : 100,
          decoration: BoxDecoration(
            color: _isTransformed ? Colors.purple : Colors.blue,
            borderRadius: BorderRadius.circular(_isTransformed ? 50 : 8),
          ),
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _changeShape,
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
