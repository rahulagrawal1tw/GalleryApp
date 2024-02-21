import 'package:flutter/material.dart';
import 'package:gallery_app/preview_screen.dart';

class ImageListView extends StatelessWidget {
  const ImageListView({super.key, required this.imagePaths});

  final List<String> imagePaths;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: imagePaths.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        PreviewScreen(image: imagePaths[index])));
          },
          child: Image.asset(
            imagePaths[index],
            fit: BoxFit.scaleDown,
          ),
        );
      },
    );
  }
}
