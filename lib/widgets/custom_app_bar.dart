import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gallery_app/widgets/dropdown_button_widget.dart';


class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.saveViewPreference});

  final void Function(String) saveViewPreference;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size(double.infinity, 56);
}

class _CustomAppBarState extends State<CustomAppBar> {
  late List<Color> _colors; // Initial color
  Timer? _timer;

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context); // Access app theme here
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gallery App"),
        actions: <Widget>[
          DropdownButtonWidget(saveViewPreference: widget.saveViewPreference)
        ],
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
    );
  }
}