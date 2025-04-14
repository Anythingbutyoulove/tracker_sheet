import 'package:flutter/material.dart';

void main() {
  runApp(const AnimatedDrawerApp());
}

class AnimatedDrawerApp extends StatelessWidget {
  const AnimatedDrawerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Animated Drawer',
      debugShowCheckedModeBanner: false,
      home: const DrawerHomePage(),
    );
  }
}

class DrawerHomePage extends StatefulWidget {
  const DrawerHomePage({super.key});

  @override
  State<DrawerHomePage> createState() => _DrawerHomePageState();
}

class _DrawerHomePageState extends State<DrawerHomePage>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  void _toggleDrawer() {
    if (_controller.isCompleted) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('Custom Animated Drawer'),
            leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: _toggleDrawer,
            ),
          ),
          body: const Center(
            child: Text('Main Content'),
          ),
        ),
        SlideTransition(
          position: _slideAnimation,
          child: SafeArea(
            child: Material(
              elevation: 16,
              child: Container(
                width: 250,
                height: double.infinity,
                color: Colors.blueGrey[900],
                child: ListView(
                  children: const [
                    DrawerHeader(
                      child: Text(
                        'Navigation',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.home, color: Colors.white),
                      title: Text('Home', style: TextStyle(color: Colors.white)),
                    ),
                    ListTile(
                      leading: Icon(Icons.settings, color: Colors.white),
                      title: Text('Settings', style: TextStyle(color: Colors.white)),
                    ),
                    ListTile(
                      leading: Icon(Icons.logout, color: Colors.white),
                      title: Text('Logout', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
