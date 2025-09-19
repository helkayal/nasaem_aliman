import 'package:flutter/material.dart';
import 'package:nasaem_aliman/features/quran/domain/entities/bookmark.dart';
import 'package:nasaem_aliman/features/quran/domain/entities/surah.dart';
import 'package:uuid/uuid.dart';

class AddBookmarkDialog extends StatefulWidget {
  final Surah surah;

  const AddBookmarkDialog({super.key, required this.surah});

  @override
  State<AddBookmarkDialog> createState() => _AddBookmarkDialogState();
}

class _AddBookmarkDialogState extends State<AddBookmarkDialog> {
  final TextEditingController _nameController = TextEditingController();

  Color _selectedColor = Colors.red;

  final List<Color> _availableColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.brown,
    Colors.indigo,
    Colors.pink,
    Colors.cyan,
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Bookmark"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: "Name"),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: _availableColors.map((c) {
              return GestureDetector(
                onTap: () => setState(() => _selectedColor = c),
                child: CircleAvatar(
                  backgroundColor: c,
                  child: _selectedColor == c
                      ? const Icon(Icons.check, color: Colors.white)
                      : null,
                ),
              );
            }).toList(),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text("Cancel"),
          onPressed: () => Navigator.pop(context),
        ),
        ElevatedButton(
          child: const Text("Save"),
          onPressed: () {
            final bookmark = Bookmark(
              id: int.parse(Uuid().v4()),
              surahId: widget.surah.id,
              ayahId:
                  1, // default: first Ayah (we can extend to allow selection)
              name: _nameController.text.isEmpty
                  ? "Bookmark"
                  : _nameController.text,
              // color: _selectedColor,
              color: 1,
              isLastRead: false,
            );
            Navigator.pop(context, bookmark);
          },
        ),
      ],
    );
  }
}
