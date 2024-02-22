import 'package:flutter/material.dart';
import 'package:gallery_app/theme_provider.dart';
import 'package:provider/provider.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final bodyColor =
        themeProvider.isDarkMode ? Colors.blue.shade900 : Colors.blue.shade200;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Preview'),
      ),
      body: Center(
        child: Container(
          color: bodyColor,
          child: Image(
            image: AssetImage(image),
            width: double.maxFinite,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
