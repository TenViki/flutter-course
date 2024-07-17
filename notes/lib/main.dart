import 'package:flutter/material.dart';
import 'package:notes/models/note_db.dart';
import 'package:notes/pages/notes.dart';
import 'package:notes/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.init();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => NoteDatabase()),
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const NotesPage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
