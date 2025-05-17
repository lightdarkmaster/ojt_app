import 'package:flutter/material.dart';
import 'note_database.dart';
import 'note_model.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  String _selectedMood = 'Neutral';
  List<Note> _notes = [];

  @override
  void initState() {
    super.initState();
    _refreshNotes();
  }

  Future<void> _refreshNotes() async {
    final notes = await NoteDatabase.instance.getNotes();
    setState(() {
      _notes = notes;
    });
  }

  Future<void> _addOrUpdateNote({Note? existingNote}) async {
    final isEditing = existingNote != null;

    if (isEditing) {
      _titleController.text = existingNote.title;
      _bodyController.text = existingNote.body;
      _selectedMood = existingNote.mood;
    } else {
      _titleController.clear();
      _bodyController.clear();
      _selectedMood = 'Neutral';
    }

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return AnimatedPadding(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: const LinearGradient(
                        colors: [Color(0xFFEF5350), Color(0xFFFFA726)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      isEditing ? '✏️ Edit Note' : '📝 Add New Note',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      prefixIcon: const Icon(Icons.title),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _bodyController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: 'Note Details',
                      prefixIcon: const Icon(Icons.notes),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                    ),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _selectedMood,
                    decoration: InputDecoration(
                      labelText: 'Mood',
                      prefixIcon: const Icon(Icons.mood),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                    ),
                    items: const [
                      DropdownMenuItem(value: 'Happy', child: Text('😊 Happy')),
                      DropdownMenuItem(
                        value: 'Neutral',
                        child: Text('😐 Neutral'),
                      ),
                      DropdownMenuItem(value: 'Love', child: Text('😍 Love')),
                      DropdownMenuItem(
                        value: 'Excited',
                        child: Text('😊 Excited'),
                      ),
                      DropdownMenuItem(value: 'Sad', child: Text('😔 Sad')),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _selectedMood = value);
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.cancel),
                          label: const Text('Cancel'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.grey.shade700,
                            side: BorderSide(color: Colors.grey.shade400),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            final note = Note(
                              id: existingNote?.id,
                              title: _titleController.text.trim(),
                              body: _bodyController.text.trim(),
                              mood: _selectedMood,
                            );
                            if (isEditing) {
                              await NoteDatabase.instance.updateNote(note);
                            } else {
                              await NoteDatabase.instance.insertNote(note);
                            }
                            Navigator.of(context).pop();
                            _refreshNotes();
                          },
                          icon: Icon(isEditing ? Icons.save : Icons.add),
                          label: Text(isEditing ? 'Update' : 'Save'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFEF5350),
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _deleteNote(Note note) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Delete Note'),
            content: const Text('Are you sure you want to delete this note?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Delete'),
              ),
            ],
          ),
    );

    if (confirmed == true) {
      await NoteDatabase.instance.deleteNote(note);
      _refreshNotes();
    }
  }

  Widget _buildNoteCard(Note note) {
    final moodColors = {
      'Happy': Colors.lightGreenAccent.shade100,
      'Neutral': Colors.grey.shade200,
      'Sad': Colors.redAccent.shade100,
      'Love': Colors.pinkAccent.shade100,
      'Excited': Colors.orangeAccent.shade100,
    };

    final moodEmoji = {
      'Happy': '😊',
      'Neutral': '😐',
      'Sad': '😔',
      'Love': '😍',
      'Excited': '😊',
    };

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Material(
          elevation: 3,
          color: moodColors[note.mood], // Change background color
          child: InkWell(
            onTap: () => _addOrUpdateNote(existingNote: note),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: moodColors[note.mood],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          moodEmoji[note.mood] ?? '😐',
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              note.title.isNotEmpty ? note.title : '(No Title)',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 1,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              note.body.isNotEmpty ? note.body : '(No Content)',
                              style: const TextStyle(fontSize: 16),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => _addOrUpdateNote(existingNote: note),
                        style: TextButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            80,
                            165,
                            239,
                          ),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Edit'),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () => _deleteNote(note),
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFFEF5350),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        backgroundColor: const Color(0xFFEF5350),
        foregroundColor: Colors.white,
        elevation: 2,
        actions: [
          if (_notes.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_forever),
              onPressed: () => _deleteAllNotes(),
            ),
        ],
      ),
      body:
          _notes.isEmpty
              ? Center(
                child: Text(
                  'No notes yet.\nTap the + button to add one!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              )
              : ListView.builder(
                itemCount: _notes.length,
                itemBuilder: (context, index) => _buildNoteCard(_notes[index]),
              ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _addOrUpdateNote(),
        label: const Text('Add Note', style: TextStyle(color: Colors.white)),
        icon: const Icon(Icons.add, color: Colors.white),
        backgroundColor: const Color(0xFFEF5350),
      ),
    );
  }
  
  Future<void> _deleteAllNotes() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete All Notes'),
        content: const Text('Are you sure you want to delete all notes?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await NoteDatabase.instance.deleteAllNotes();
      _refreshNotes();
    }
  }
}
