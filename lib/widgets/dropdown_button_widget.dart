import 'package:flutter/material.dart';
import 'package:gallery_app/home_screen.dart';

class DropdownButtonWidget extends StatefulWidget {
  const DropdownButtonWidget({super.key, required this.saveViewPreference});
  final void Function(String) saveViewPreference;

  @override
  State<DropdownButtonWidget> createState() => _DropdownButtonWidgetState();
}

class _DropdownButtonWidgetState extends State<DropdownButtonWidget> {
  String _viewType = ViewType.list.name;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _viewType,
      onChanged: (value) {
        setState(() {
          _viewType = value ?? "";
          widget.saveViewPreference(_viewType);
        });
      },
      items: <ViewType>[ViewType.list, ViewType.grid, ViewType.carousel]
          .map<DropdownMenuItem<String>>((ViewType value) {
        return DropdownMenuItem<String>(
          value: value.name,
          child: Text(value.name),
        );
      }).toList(),
    );
  }
}
