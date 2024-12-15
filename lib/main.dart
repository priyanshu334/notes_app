import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:notesapp/models/note_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();
  runApp(ChangeNotifierProvider(
  create: (context) => NoteDatabase(),child: const MyApp(),),

  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Material();
  }
}
