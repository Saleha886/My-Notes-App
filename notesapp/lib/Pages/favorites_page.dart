import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  final List<Map<String, String>> favorites;
  const FavoritesPage({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Notes',
            style: TextStyle(
                color: const Color.fromARGB(255, 232, 229, 233),
                fontWeight: FontWeight.bold)),
        backgroundColor: const Color.fromARGB(255, 88, 16, 70),
      ),
      body: favorites.isEmpty
          ? const Center(child: Text('No favorite notes'))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final note = favorites[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(note['title'] ?? ''),
                    subtitle: Text(note['description'] ?? ''),
                  ),
                );
              },
            ),
    );
  }
}
