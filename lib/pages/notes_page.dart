import 'package:flutter/material.dart';

import '../models/note.dart';
import '../services/auth_service.dart';
import '../services/note_service.dart';
import 'login_page.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List<Note> notes = [];

  final TextEditingController titleController =
      TextEditingController();

  final TextEditingController contentController =
      TextEditingController();

  final NoteService noteService =
      NoteService();

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  Future<void> loadNotes() async {
    notes = await noteService.getNotes();

    setState(() {});
  }

  Future<void> addNote() async {
    if (titleController.text.trim().isEmpty) {
      return;
    }

    await noteService.addNote(
      titleController.text,
      contentController.text,
    );

    titleController.clear();
    contentController.clear();

    await loadNotes();
  }

  Future<void> editNote(
    int id,
    String title,
    String content,
  ) async {
    await noteService.editNote(
      id,
      title,
      content,
    );

    await loadNotes();
  }

  Future<void> deleteNote(int id) async {
    await noteService.deleteNote(id);

    await loadNotes();
  }

  Future<void> logout() async {
    await AuthService().logout();

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginPage(),
      ),
    );
  }

  void showEditDialog(Note note) {
    final editTitleController =
        TextEditingController(text: note.title);

    final editContentController =
        TextEditingController(text: note.content);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Edit Catatan",
          ),

          content: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller:
                      editTitleController,
                  decoration:
                      const InputDecoration(
                    labelText: "Judul",
                    border:
                        OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 10),

                TextField(
                  controller:
                      editContentController,
                  maxLines: 4,
                  decoration:
                      const InputDecoration(
                    labelText:
                        "Isi Catatan",
                    border:
                        OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Batal",
              ),
            ),

            ElevatedButton(
              onPressed: () async {
                await editNote(
                  note.id,
                  editTitleController.text,
                  editContentController.text,
                );

                if (!mounted) return;

                Navigator.pop(context);
              },
              child: const Text(
                "Simpan",
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Notes",
        ),

        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
            ),
            onPressed: logout,
          ),
        ],
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(16),

        child: Column(
          children: [
            TextField(
              controller:
                  titleController,
              decoration:
                  const InputDecoration(
                labelText: "Judul",
                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller:
                  contentController,
              maxLines: 4,
              decoration:
                  const InputDecoration(
                labelText:
                    "Isi Catatan",
                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: addNote,
                child: const Text(
                  "Tambah Catatan",
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: notes.length,

                itemBuilder:
                    (context, index) {

                  final note =
                      notes[index];

                  return Card(
                    child: ListTile(
                      title:
                          Text(note.title),

                      subtitle: Text(
                        note.content,
                        maxLines: 2,
                        overflow:
                            TextOverflow
                                .ellipsis,
                      ),

                      leading:
                          IconButton(
                        icon:
                            const Icon(
                          Icons.edit,
                        ),
                        onPressed: () {
                          showEditDialog(
                            note,
                          );
                        },
                      ),

                      trailing:
                          IconButton(
                        icon:
                            const Icon(
                          Icons.delete,
                        ),
                        onPressed: () {
                          deleteNote(
                            note.id,
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}