import 'package:flutter/material.dart';
 
 void main() {
   runApp(const MyApp());
 }
 
 class MyApp extends StatelessWidget {
   const MyApp({super.key});
 
   @override
   Widget build(BuildContext context) {
     return MaterialApp(
       title: 'The Tracker App',
       debugShowCheckedModeBanner: false,
       theme: ThemeData(
         primarySwatch: Colors.red,
         visualDensity: VisualDensity.adaptivePlatformDensity,
       ),
       home: const CardListScreen(),
     );
   }
 }
 
 class CardListScreen extends StatelessWidget {
   const CardListScreen({super.key});
 
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       body: ListView.builder(
         padding: const EdgeInsets.all(16.0),
         itemCount: demoItems.length,
         itemBuilder: (context, index) {
           return Padding(
             padding: const EdgeInsets.only(bottom: 16.0),
             child: CustomAnimatedCard(item: demoItems[index]),
           );
         },
       ),
     );
   }
 }
 
 class CustomAnimatedCard extends StatefulWidget {
   final ItemModel item;
 
   const CustomAnimatedCard({super.key, required this.item});
 
   @override
   State<CustomAnimatedCard> createState() => _CustomAnimatedCardState();
 }
 
 class _CustomAnimatedCardState extends State<CustomAnimatedCard>
     with SingleTickerProviderStateMixin {
   late AnimationController _controller;
   late Animation<double> _scaleAnimation;
   late Animation<double> _shadowAnimation;
   bool _isPressed = false;
 
   @override
   void initState() {
     super.initState();
     _controller = AnimationController(
       duration: const Duration(milliseconds: 150),
       vsync: this,
     );
 
     _scaleAnimation = Tween<double>(
       begin: 1.0,
       end: 0.98,
     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
 
     _shadowAnimation = Tween<double>(
       begin: 8.0,
       end: 2.0,
     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
   }
 
   @override
   void dispose() {
     _controller.dispose();
     super.dispose();
   }
 
   void _onTapDown(TapDownDetails details) {
     if (!_isPressed) {
       _controller.forward();
       setState(() {
         _isPressed = true;
       });
     }
   }
 
   void _onTapUp(TapUpDetails details) {
     if (_isPressed) {
       _controller.reverse();
       setState(() {
         _isPressed = false;
       });
     }
   }
 
   void _onTapCancel() {
     if (_isPressed) {
       _controller.reverse();
       setState(() {
         _isPressed = false;
       });
     }
   }
 
   @override
   Widget build(BuildContext context) {
     return GestureDetector(
       onTapDown: _onTapDown,
       onTapUp: _onTapUp,
       onTapCancel: _onTapCancel,
       onTap: () {
         ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
             content: Text('You tapped on ${widget.item.title}'),
             duration: const Duration(seconds: 1),
           ),
         );
       },
       child: AnimatedBuilder(
         animation: _controller,
         builder: (context, child) {
           return Transform.scale(
             scale: _scaleAnimation.value,
             child: Container(
               decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(16.0),
                 boxShadow: [
                   BoxShadow(
                     color: Colors.black.withOpacity(0.2),
                     blurRadius: _shadowAnimation.value,
                     offset: const Offset(0, 2),
                   ),
                 ],
               ),
               child: ClipRRect(
                 borderRadius: BorderRadius.circular(16.0),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     // Image section
                     Hero(
                       tag: 'image-${widget.item.id}',
                       child: Image.network(
                         widget.item.imageUrl,
                         height: 180.0,
                         width: double.infinity,
                         fit: BoxFit.cover,
                         errorBuilder: (context, error, stackTrace) {
                           return Container(
                             height: 180.0,
                             color: Colors.grey[300],
                             child: const Center(
                               child: Icon(Icons.error, size: 50.0),
                             ),
                           );
                         },
                       ),
                     ),
                     // Content section
                     Padding(
                       padding: const EdgeInsets.all(16.0),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text(
                             widget.item.title,
                             style: const TextStyle(
                               fontSize: 20.0,
                               fontWeight: FontWeight.bold,
                             ),
                           ),
                           const SizedBox(height: 4.0),
                           Text(
                             widget.item.subtitle,
                             style: TextStyle(
                               fontSize: 14.0,
                               color: Colors.grey[600],
                             ),
                           ),
                           const SizedBox(height: 12.0),
                           Text(
                             widget.item.description,
                             style: const TextStyle(fontSize: 16.0),
                             maxLines: 3,
                             overflow: TextOverflow.ellipsis,
                           ),
                         ],
                       ),
                     ),
                   ],
                 ),
               ),
             ),
           );
         },
       ),
     );
   }
 }
 
 // Model for card items
 class ItemModel {
   final String id;
   final String imageUrl;
   final String title;
   final String subtitle;
   final String description;
 
   const ItemModel({
     required this.id,
     required this.imageUrl,
     required this.title,
     required this.subtitle,
     required this.description,
   });
 }
 
 // Sample data for the ListView
 final List<ItemModel> demoItems = [
   const ItemModel(
     id: '1',
     imageUrl: 'https://steemitimages.com/640x0/http://i63.tinypic.com/de7h2u.jpg',
     title: 'Jaflong',
     subtitle: 'Nature',
     description:
         'Jaflong is a tourist spot in Sylhet division. It is about 60 km from Sylhet town and takes around a two hours drive to reach there. Jaflong is located amidst tea gardens and hills. It is situated beside the river Sari in the lap of Hill Khashia.',
   ),
   const ItemModel(
     id: '2',
     imageUrl:
         'https://encrypted-tbn0.gstatic.com/licensed-image?q=tbn:ANd9GcSYxhLWf1hLGA3HBN9UTHKRXyqFlFxnhQrlbng5XHclclGAw7VQope0cnBWPdYuzoKOsU0yW2R5NpklWYx-pd8jLnQmdDQgEZwJjB0AMg',
     title: 'Cox\'s Bazar',
     subtitle: 'Bay of Bengal',
     description:
         'Cox\'s Bazar  is a city, fishing port, tourism centre, and district headquarters in south-eastern Bangladesh.',
   ),
   const ItemModel(
     id: '3',
     imageUrl:
         'https://lh3.googleusercontent.com/gps-cs-s/AB5caB_U4tPbH-QYPn-5871ygf1_XnXTNdomK7pkyM7lfSw9jqG15_g2mGOJYihwJ2rJ_UPiekDD6j74sMwviU1sbxfP3qwz7xTl-W3bgW4u1oOGbow2KumodXhXQBz77D36ly89MtQ=w540-h312-n-k-no',
     title: 'Sajek',
     subtitle: 'A Beautiful Place In Bangladesh',
     description:
         'Sajek Valley is a popular tourist spot in Bangladesh, situated among the hills of the Kasalong range of mountains in the northern area of the Chittagong Hill Tracts.',
   ),
 
 ];