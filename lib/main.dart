import 'package:flutter/material.dart';
import 'package:gallery_app/theme_provider.dart';
import 'color_schemes.dart';
import 'home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MaterialApp(
        theme: ThemeData.from(colorScheme: lightColorScheme),
        darkTheme: ThemeData.from(colorScheme: darkColorScheme),
        home: const HomeScreen(),
      ),
    ),
  );
}