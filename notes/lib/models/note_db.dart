import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:notes/models/note.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase extends ChangeNotifier {
  static late Isar isar;
  // intiialize database
  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([NoteSchema], directory: dir.path);
  }

  // list of notes
  final List<Note> notes = [];

  // create
  Future<void> addNote(String noteContent) async {
    final newNote = Note()..text = noteContent;

    await isar.writeTxn(() => isar.notes.put(newNote));

    // re-read from the database
    await getNotes();
  }

  // read
  Future<void> getNotes() async {
    final allNotes = await isar.notes.where().findAll();
    notes.clear();
    notes.addAll(allNotes);
    notifyListeners();
  }

  // update
  Future<void> updateNote(int id, String noteContent) async {
    final note = await isar.notes.get(id);
    if (note == null) {
      return;
    }
    note.text = noteContent;
    await isar.writeTxn(() => isar.notes.put(note));

    // re-read from the database
    await getNotes();
  }

  // delete
  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));

    // re-read from the database
    await getNotes();
  }
}
