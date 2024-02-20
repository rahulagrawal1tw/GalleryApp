import 'package:flutter/material.dart';

class ImageListView extends StatelessWidget {
  const ImageListView({super.key, required this.imagePaths});
  final List<String> imagePaths;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: imagePaths.length,
      itemBuilder: (context, index) {
        return Image.asset(
          imagePaths[index],
          fit: BoxFit.scaleDown,
        );
      },
    );
  }
}
