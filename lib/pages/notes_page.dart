import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notesapp/components/note_tile.dart';
import 'package:notesapp/main.dart';
import 'package:notesapp/models/note.dart';
import 'package:notesapp/models/note_database.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final textController = TextEditingController();
  void createNote() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(
                controller: textController,
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    context.read<NoteDatabase>().addNote(textController.text);
                    textController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("create"),
                )
              ],
            ));
  }

  void readNotes() {
    context.read<NoteDatabase>().fetchNotes();
  }

  void updateNote(Note note) {
    textController.text = note.text;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Update Note"),
              content: TextField(
                controller: textController,
              ),
              actions: [
                MaterialButton(onPressed: () {
                  context
                      .read<NoteDatabase>()
                      .updateNotes(note.id, textController.text);
                  textController.clear();
                  Navigator.pop(context);
                })
              ],
            ));
  }

  void deleteNote(int id) {
    context.read<NoteDatabase>().deleteNote(id);
  }

  @override
  void initState() {
    super.initState();
    readNotes();
  }

  Widget build(BuildContext context) {
    final noteDatabase = context.watch<NoteDatabase>();
    List<Note> currentNodes = noteDatabase.currentNotes;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
        title: Text("Notes"),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        child: const Icon(Icons.add),
      ),
      drawer: Drawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text("Notes",
                style: GoogleFonts.dmSerifText(
                  fontSize: 48,
                  color: Theme.of(context).colorScheme.inversePrimary,
                )),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: currentNodes.length,
                itemBuilder: (context, index) {
                  final note = currentNodes[index];
                  return NoteTile(text: textController.text,onEditPressed: ()=>updateNote,onDeletePressed: ()=>deleteNote,);
                }),
          ),
        ],
      ),
    );
  }
}
