import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselView extends StatelessWidget {
  const CarouselView({
    Key? key,
    required this.imagePaths,
    required this.onImageClicked,
  }) : super(key: key);

  final List<String> imagePaths;
  final Function(String) onImageClicked;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 16 / 9,
          viewportFraction: 0.8,
          autoPlay: false,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          pauseAutoPlayOnTouch: true,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ),
        items: imagePaths.map((item) {
          return Builder(
            builder: (BuildContext context) {
              Key itemKey = ValueKey(item);
              return Container(
                width: double.infinity,
                height: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                child: GestureDetector(
                  onTap: () => onImageClicked(item),
                  child: Image.asset(
                    item,
                    fit: BoxFit.fill,
                    key: itemKey,
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
