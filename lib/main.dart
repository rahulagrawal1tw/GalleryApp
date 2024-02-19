import 'package:flutter/material.dart';

import 'color_schemes.dart';
import 'image_screen.dart';

void main() => runApp(
      MaterialApp(
        theme: ThemeData.from(colorScheme: lightColorScheme),
        darkTheme: ThemeData.from(colorScheme: darkColorScheme),
        home: ImageScreen(),
      ),
    );
