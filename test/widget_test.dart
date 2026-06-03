import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notesapp/main.dart';

void main() {
  testWidgets('Tambah note ke dalam list', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    final textField = find.byType(TextField);

    await tester.enterText(textField, 'Catatan Baru');

    await tester.tap(find.text('Tambah Catatan'));

    await tester.pump();

    expect(find.text('Catatan Baru'), findsOneWidget);
  });
}