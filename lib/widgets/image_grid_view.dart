import 'package:flutter/material.dart';

class ImageGridView extends StatelessWidget {
  const ImageGridView({super.key, required this.imagePaths});
  final List<String> imagePaths;

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final isPortrait = orientation == Orientation.portrait;
    int crossAxisCount = isPortrait ? 2 : 3;

    return GridView.builder(
      itemCount: imagePaths.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemBuilder: (context, index) {
        return Image.asset(
          imagePaths[index],
          fit: BoxFit.scaleDown,
        );
      },
    );
  }
}
