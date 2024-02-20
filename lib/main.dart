import 'package:flutter/material.dart';
import 'color_schemes.dart';
import 'home_screen.dart';

void main() => runApp(
      MaterialApp(
        theme: ThemeData.from(colorScheme: lightColorScheme),
        darkTheme: ThemeData.from(colorScheme: darkColorScheme),
        home: const HomeScreen(),
      ),
    );
