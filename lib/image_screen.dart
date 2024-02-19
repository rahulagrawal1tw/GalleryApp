import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ViewType { list, carousel, grid }

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ImageScreen();
  }
}

class _ImageScreen extends State<ImageScreen> {
  String _viewType = ViewType.list.name; // Default to list view

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
  void initState() {
    super.initState();
    _loadViewPreference();
  }

  // Load user preference from SharedPreferences
  _loadViewPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _viewType = (prefs.getString('viewPreference') ?? ViewType.list.name);
    });
  }

  // Save user preference to SharedPreferences
  _saveViewPreference(String preference) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('viewPreference', preference);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gallery App"),
        actions: <Widget>[
          DropdownButton<String>(
            value: _viewType,
            onChanged: (value) {
              setState(() {
                _viewType = value ?? "";
                _saveViewPreference(_viewType);
              });
            },
            items: <ViewType>[ViewType.list, ViewType.grid, ViewType.carousel]
                .map<DropdownMenuItem<String>>((ViewType value) {
              return DropdownMenuItem<String>(
                value: value.name,
                child: Text(value.name),
              );
            }).toList(),
          ),
        ],
        backgroundColor: Colors.blue.shade900,
      ),
      body: getViewWidget(_viewType),
    );
  }

  Widget getViewWidget(String viewType) {
    switch (viewType) {
      case 'list':
        return buildListView();
      case 'grid':
        return buildGridView();
      case 'carousel':
        return buildCarouselView(imagePaths);
      default:
        return Container(); // Or any other default widget
    }
  }

  Widget buildListView() {
    // Implement your ListView logic here
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

  Widget buildGridView() {
    // Implement your GridView logic here
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

  Widget buildCarouselView(List<String> imagePaths) {
    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 16/9,
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
            return Container(
              width: double.infinity,
              height: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Image.asset(
                item,
                fit: BoxFit.cover,
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
