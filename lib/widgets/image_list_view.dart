import 'package:flutter/material.dart';

class ImageListView extends StatelessWidget {
  const ImageListView({
    Key? key,
    required this.imagePaths,
    required this.onImageClicked,
  }) : super(key: key);

  final List<String> imagePaths;
  final Function(String) onImageClicked;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: imagePaths.length,
      itemBuilder: (context, index) {
        Key itemKey = ValueKey(imagePaths[index]);
        return GestureDetector(
          onTap: () => onImageClicked(imagePaths[index]),
          child: Image.asset(
            imagePaths[index],
            fit: BoxFit.scaleDown,
            key: itemKey,
          ),
        );
      },
    );
  }
}
