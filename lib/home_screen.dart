import 'package:flutter/material.dart';
import 'package:gallery_app/gallery_widget.dart';
import 'package:gallery_app/utils/native_permission_helper.dart';
import 'package:gallery_app/utils/native_preference_helper.dart';
import 'package:gallery_app/theme_provider.dart';
import 'package:gallery_app/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';

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
  final permissionHelper = NativePermissionHelper();

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
    _requestImagesPermission();
    _loadViewPreference();
  }

  _requestImagesPermission() async {
    final isPermissionGranted =
        await permissionHelper.requestImagesPermission();
    print('Permission Granted: $isPermissionGranted');
  }

  _loadViewPreference() async {
    final value = await NativePreferenceHelper.getValue('viewPreference') ??
        ViewType.list.name;
    setState(() {
      _viewType = value.isNotEmpty ? value : ViewType.list.name;
    });
  }

  // Save user preference to SharedPreferences
  _saveViewPreference(String preference) async {
    NativePreferenceHelper.setValue('viewPreference', preference);
    setState(() {
      _viewType = preference;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final bodyColor =
        themeProvider.isDarkMode ? Colors.blue.shade900 : Colors.blue.shade200;
    return Scaffold(
      appBar: CustomAppBar(
          saveViewPreference: _saveViewPreference, viewType: _viewType),
      body: Container(
        color: bodyColor,
        child: GalleryWidget(viewType: _viewType, imagePaths: imagePaths),
      ),
    );
  }
}
