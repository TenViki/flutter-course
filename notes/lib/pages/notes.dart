import 'package:flutter/material.dart';
import 'package:notes/components/drawer.dart';
import 'package:notes/components/note_tile.dart';
import 'package:notes/models/note.dart';
import 'package:notes/models/note_db.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final textContoller = TextEditingController();

  @override
  void initState() {
    super.initState();

    // on app startup fetch notes from the database
    readNotets();
  }

  void createNote() {
    textContoller.clear();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create a new note'),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
        content: TextField(
          controller: textContoller,
          decoration: const InputDecoration(
            hintText: 'Enter your note',
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              context.read<NoteDatabase>().addNote(textContoller.text);
              Navigator.of(context).pop();
              textContoller.clear();
            },
            child: const Text("Create"),
          ),
        ],
      ),
    );
  }

  void readNotets() {
    context.read<NoteDatabase>().getNotes();
  }

  void updateNote(Note note) {
    textContoller.text = note.text;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update note'),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
        content: TextField(
          controller: textContoller,
          decoration: const InputDecoration(
            hintText: 'Enter your note',
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              context
                  .read<NoteDatabase>()
                  .updateNote(note.id, textContoller.text);
              Navigator.of(context).pop();
              textContoller.clear();
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }

  void deleteNote(Note note) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete note'),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
        content: const Text('Are you sure you want to delete this note?'),
        actions: [
          ElevatedButton(
            onPressed: () {
              context.read<NoteDatabase>().deleteNote(note.id);
              Navigator.of(context).pop();
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final noteDb = context.watch<NoteDatabase>();

    final currentNotes = noteDb.notes;

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNote,
          child: const Icon(Icons.add),
        ),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
        drawer: MainDrawer(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Text(
                "Notes",
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  itemCount: currentNotes.length,
                  itemBuilder: (context, index) {
                    final note = currentNotes[index];

                    return NoteTile(
                      text: note.text,
                      onEdit: () => updateNote(note),
                      onDelete: () => deleteNote(note),
                    );
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
