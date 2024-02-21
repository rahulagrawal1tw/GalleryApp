import 'package:flutter/material.dart';
import 'package:gallery_app/gallery_widget.dart';
import 'package:gallery_app/native_preference_helper.dart';
import 'package:gallery_app/widgets/dropdown_button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'dart:async';

enum ViewType { list, carousel, grid }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen> {
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

  late List<Color> _colors; // Initial color
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _saveViewPreference('list');
    _loadViewPreference();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _colors = _generateRandomGradient();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _colors = _generateRandomGradient();
      });
    });
  }

  List<Color> _generateRandomGradient() {
    final Random random = Random();
    return [
      Color.fromARGB(
        255,
        random.nextInt(255),
        random.nextInt(255),
        random.nextInt(255),
      ),
      Color.fromARGB(
        255,
        random.nextInt(255),
        random.nextInt(255),
        random.nextInt(255),
      ),
    ];
  }

  // Load user preference from SharedPreferences
/*  _loadViewPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _viewType = (prefs.getString('viewPreference') ?? ViewType.list.name);
    });
  }

  // Save user preference to SharedPreferences
  _saveViewPreference(String preference) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('viewPreference', preference);
    setState(() {
      _viewType = preference;
    });
  }*/

  _loadViewPreference() async {
    final value = await NativePreferenceHelper.getValue('viewPreference') ?? ViewType.list.name;
    setState(() {
      _viewType = value;
    });
  }

  // Save user preference to SharedPreferences
  _saveViewPreference(String preference) async {
    await NativePreferenceHelper.setValue('viewPreference', preference);
    setState(() {
      _viewType = preference;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context); // Access app theme here
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gallery App"),
        actions: <Widget>[
          DropdownButtonWidget(saveViewPreference: _saveViewPreference)
        ],
        //backgroundColor: theme.appBarTheme.backgroundColor,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _colors,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ),
      body: GalleryWidget(viewType: _viewType, imagePaths: imagePaths),
    );
  }
}
