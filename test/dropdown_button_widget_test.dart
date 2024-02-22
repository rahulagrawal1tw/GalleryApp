import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gallery_app/home_screen.dart'; // Import ViewType if needed
import 'package:gallery_app/widgets/dropdown_button_widget.dart';

void main() {
  testWidgets('DropdownButtonWidget test', (WidgetTester tester) async {
    // Define mock callback function for saveViewPreference
    String savedViewPreference = '';
    void mockSaveViewPreference(String viewType) {
      savedViewPreference = viewType;
    }

    // Build the DropdownButtonWidget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DropdownButtonWidget(
            saveViewPreference: mockSaveViewPreference,
            viewType: ViewType.list.name, // Set initial viewType
          ),
        ),
      ),
    );

    // Verify that DropdownButtonWidget is rendered with initial value
    expect(find.text(ViewType.list.name), findsOneWidget);

    // Tap the dropdown button to open the dropdown menu
    await tester.tap(find.byType(DropdownButton<String>));
    await tester.pumpAndSettle();

    // Tap on one of the dropdown menu items
    await tester.tap(find.text(ViewType.grid.name));
    await tester.pumpAndSettle();

    // Verify that the dropdown menu item was selected and callback function was called
    expect(savedViewPreference, equals(ViewType.grid.name));
  });
}
