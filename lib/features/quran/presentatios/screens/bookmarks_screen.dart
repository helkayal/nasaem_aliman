import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasaem_aliman/features/quran/presentatios/screens/surah_details_screen.dart';
import '../cubit/quran_cubit.dart';
import '../cubit/quran_state.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<QuranCubit>();
    cubit.fetchBookmarks();

    return Scaffold(
      appBar: AppBar(title: const Text("Bookmarks")),
      body: BlocBuilder<QuranCubit, QuranState>(
        builder: (context, state) {
          if (state is BookmarksLoaded) {
            if (state.bookmarks.isEmpty) {
              return const Center(child: Text("No bookmarks yet."));
            }
            return ListView.builder(
              itemCount: state.bookmarks.length,
              itemBuilder: (context, i) {
                final b = state.bookmarks[i];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: b.color,
                    child: const Icon(Icons.bookmark, color: Colors.white),
                  ),
                  title: Text(b.name),
                  subtitle: Text("Surah ${b.surahId}, Ayah ${b.ayahId}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      cubit.removeExistingBookmark(b.id);
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SurahDetailsScreen(
                          surahId: b.surahId,
                          scrollToAyah: b.ayahId,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
