import 'package:flutter_test/flutter_test.dart';
import 'package:notesapp/services/note_service.dart';

void main() {

  late NoteService noteService;

  setUp(() {
    noteService = NoteService();
  });

  test(
    'Get Notes berhasil',
    () async {

      final notes =
          await noteService.getNotes();

      expect(
        notes,
        isA<List>(),
      );
    },
  );
}