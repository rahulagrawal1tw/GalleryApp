import 'package:flutter/material.dart';
import 'package:gallery_app/home_screen.dart';

class DropdownButtonWidget extends StatefulWidget {
  const DropdownButtonWidget({super.key, required this.saveViewPreference, required this.viewType});
  final void Function(String) saveViewPreference;
   final String viewType;

  @override
  State<DropdownButtonWidget> createState() => _DropdownButtonWidgetState();
}

class _DropdownButtonWidgetState extends State<DropdownButtonWidget> {
  @override
  Widget build(BuildContext context) {
    String viewType = widget.viewType;
    return DropdownButton<String>(
      value: viewType,
      onChanged: (value) {
        setState(() {
          viewType = value ?? "";
          widget.saveViewPreference(viewType);
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
