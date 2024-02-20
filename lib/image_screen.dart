import 'package:flutter/material.dart';
import 'package:gallery_app/view_widget.dart';
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
    final ThemeData theme = Theme.of(context); // Access app theme here
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
        backgroundColor: theme.appBarTheme.backgroundColor,
      ),
      body: ViewWidget(viewType: _viewType, imagePaths: imagePaths),
    );
  }
}
