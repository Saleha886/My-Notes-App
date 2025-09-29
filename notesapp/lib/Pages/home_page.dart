import 'package:flutter/material.dart';
import 'package:notesapp/Pages/create_note_page.dart';
import 'package:notesapp/Widget/custom_drawer.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Map<String, String>> _notes = [];
  final List<Map<String, String>> _favorites = [];

  void _addNote() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateNotePage(),
      ),
    );
    if (result != null && result is Map<String, String>) {
      setState(() {
        _notes.add(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notely',
            style: TextStyle(
                color: const Color.fromARGB(255, 232, 229, 233),
                fontWeight: FontWeight.bold)),
        backgroundColor: const Color.fromARGB(255, 88, 16, 70),
        centerTitle: true,
      ),
      drawer: CustomDrawer(favorites: _favorites),
      body: _notes.isEmpty
          ? const Center(child: Text('Welcome to Notes App'))
          : ListView.builder(
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                final note = _notes[index];
                final isFav = _favorites.contains(note);
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(note['title'] ?? ''),
                    subtitle: Text(note['description'] ?? ''),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: isFav ? Colors.red : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              if (isFav) {
                                _favorites.remove(note);
                              } else {
                                _favorites.add(note);
                              }
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreateNotePage(
                                    // Optionally pass initial values for editing
                                ),
                              ),
                            );
                            if (result != null && result is Map<String, String>) {
                              setState(() {
                                _notes[index] = result;
                              });
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              _notes.removeAt(index);
                              _favorites.remove(note);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,
       
        backgroundColor: const Color.fromARGB(255, 88, 16, 70),
        tooltip: 'Add Note',
         child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
                            }

  

