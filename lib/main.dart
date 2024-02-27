import 'package:flutter/material.dart';
import 'package:gallery_app/theme_provider.dart';
import 'color_schemes.dart';
import 'home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    const SampleApp()
  );
}

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Builder(
        builder: (context) {
          return MaterialApp(
            theme: ThemeData.from(colorScheme: lightColorScheme),
            darkTheme: ThemeData.from(colorScheme: darkColorScheme),
            home: const HomeScreen(),
            themeMode: Provider.of<ThemeProvider>(context).isDarkMode ? ThemeMode.dark :ThemeMode.light,
          );
        }
      ),
    );
  }
}