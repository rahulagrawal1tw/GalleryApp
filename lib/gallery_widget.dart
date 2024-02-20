import 'package:flutter/material.dart';
import 'package:gallery_app/widgets/carousel_view.dart';
import 'package:gallery_app/widgets/image_grid_view.dart';
import 'package:gallery_app/widgets/image_list_view.dart';

class GalleryWidget extends StatelessWidget {
  const GalleryWidget(
      {super.key, required this.viewType, required this.imagePaths});
  final String viewType;
  final List<String> imagePaths;
  //final void Function() getImage;

  @override
  Widget build(BuildContext context) {
    switch (viewType) {
      case 'list':
        return ImageListView(imagePaths: imagePaths);
      case 'grid':
        return ImageGridView(imagePaths: imagePaths);
      case 'carousel':
        return CarouselView(imagePaths: imagePaths);
      default:
        return Container();
    }
  }
}
