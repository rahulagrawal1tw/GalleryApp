import 'package:flutter/material.dart';

class ImageGridView extends StatelessWidget {
  const ImageGridView(
      {super.key, required this.imagePaths, required this.onImageClicked});

  final List<String> imagePaths;
  final Function(String) onImageClicked;

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
        return GestureDetector(
          onTap: () => onImageClicked(imagePaths[index]),
          child: Image.asset(
            imagePaths[index],
            fit: BoxFit.scaleDown,
          ),
        );
      },
    );
  }
}
