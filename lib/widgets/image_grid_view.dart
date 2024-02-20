import 'package:flutter/material.dart';

class ImageGridView extends StatelessWidget {
  const ImageGridView({super.key, required this.imagePaths});
  final List<String> imagePaths;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: imagePaths.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 4, mainAxisSpacing: 4),
      itemBuilder: (context, index) {
        return Image.asset(
          imagePaths[index],
          fit: BoxFit.scaleDown,
        );
      },
    );
  }
}
