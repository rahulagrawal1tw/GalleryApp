import 'package:flutter/material.dart';

class ImageScreen extends StatelessWidget {
  ImageScreen({super.key});

  // Define a list of asset paths representing your images
  final List<String> imagePaths = [
    'images/bird.png',
    'images/decor.png',
    'images/dog.png',
    'images/earth.png',
    'images/flower.png',
    'images/fruit.png',
    'images/earth.png',
    'images/flower.png',
    'images/fruit.png',
    'images/earth.png',
    'images/flower.png',
    'images/fruit.png',
    // Add more image paths as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gallery App"),
        backgroundColor: Colors.blue.shade900,
      ),
      body: GridView.builder(
          itemCount: imagePaths.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 4, mainAxisSpacing: 4),
          itemBuilder: (context, index) {
            return Image.asset(
              imagePaths[index],
              fit: BoxFit.scaleDown,
            );
          }),
    );
  }
}
