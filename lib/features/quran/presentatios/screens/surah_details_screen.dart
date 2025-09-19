// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:nasaem_aliman/features/quran/domain/entities/bookmark.dart';
// import 'package:nasaem_aliman/features/quran/domain/entities/surah.dart';
// import 'package:nasaem_aliman/features/quran/presentatios/cubit/quran_cubit.dart';
// import 'package:nasaem_aliman/features/quran/presentatios/cubit/quran_state.dart';
// import 'package:nasaem_aliman/features/quran/presentatios/widgets/add_bookmark_dialog.dart';

// class SurahDetailsScreen extends StatefulWidget {
//   final Surah? surah;
//   final int? surahId; // NEW: allows navigation from bookmarks
//   final int? scrollToAyah;

//   const SurahDetailsScreen({
//     super.key,
//     this.surah,
//     this.surahId,
//     this.scrollToAyah,
//   }) : assert(
//          surah != null || surahId != null,
//          "Either surah or surahId must be provided",
//        );

//   @override
//   State<SurahDetailsScreen> createState() => _SurahDetailsScreenState();
// }

// class _SurahDetailsScreenState extends State<SurahDetailsScreen> {
//   final ScrollController _controller = ScrollController();

//   @override
//   void initState() {
//     super.initState();

//     // If surah is not passed, fetch it
//     if (widget.surah == null && widget.surahId != null) {
//       context.read<QuranCubit>().fetchSurah(widget.surahId!);
//     } else {
//       // already have surah, scroll after build
//       if (widget.scrollToAyah != null) {
//         WidgetsBinding.instance.addPostFrameCallback(
//           (_) => _scrollToAyah(widget.scrollToAyah!),
//         );
//       }
//     }
//   }

//   void _scrollToAyah(int ayahId) {
//     final surah = widget.surah;
//     if (surah == null) return;

//     final index = surah.ayahs.indexWhere((a) => a.id == ayahId);
//     if (index != -1) {
//       _controller.animateTo(
//         index * 80.0, // row height approx
//         duration: const Duration(milliseconds: 600),
//         curve: Curves.easeInOut,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<QuranCubit, QuranState>(
//       builder: (context, state) {
//         Surah? surah = widget.surah;

//         if (surah == null) {
//           if (state is SurahLoaded) {
//             surah = state.surah;
//             // trigger scroll after surah is loaded
//             if (widget.scrollToAyah != null) {
//               WidgetsBinding.instance.addPostFrameCallback(
//                 (_) => _scrollToAyah(widget.scrollToAyah!),
//               );
//             }
//           } else if (state is QuranLoading) {
//             return const Scaffold(
//               body: Center(child: CircularProgressIndicator()),
//             );
//           } else if (state is QuranError) {
//             return Scaffold(
//               body: Center(child: Text("Error: ${state.message}")),
//             );
//           } else {
//             return const Scaffold(body: Center(child: Text("Loading...")));
//           }
//         }

//         // At this point surah is guaranteed not null
//         return Scaffold(
//           appBar: AppBar(
//             title: Text(surah.name),
//             actions: [
//               IconButton(
//                 icon: const Icon(Icons.bookmark_add),
//                 tooltip: "Add Bookmark",
//                 onPressed: () async {
//                   final cubit = context.read<QuranCubit>();
//                   final selected = await showDialog<Bookmark>(
//                     context: context,
//                     builder: (_) => AddBookmarkDialog(surah: surah!),
//                   );
//                   if (selected != null) {
//                     cubit.addNewBookmark(selected);
//                   }
//                 },
//               ),
//             ],
//           ),
//           body: BlocBuilder<QuranCubit, QuranState>(
//             builder: (context, state) {
//               List<Bookmark> bookmarks = [];
//               if (state is BookmarksLoaded) {
//                 bookmarks = state.bookmarks;
//               }

//               return ListView.builder(
//                 controller: _controller,
//                 itemCount: surah!.ayahs.length,
//                 itemBuilder: (context, i) {
//                   final ayah = surah!.ayahs[i];
//                   final matching = bookmarks
//                       .where(
//                         (b) => b.surahId == surah!.id && b.ayahId == ayah.id,
//                       )
//                       .toList();

//                   final Color? highlightColor = matching.isNotEmpty
//                       ? matching.first.color
//                       : null;

//                   return Container(
//                     color: highlightColor?.withValues(alpha: 0.2),
//                     child: ListTile(
//                       title: Text(
//                         ayah.textAr,
//                         textAlign: TextAlign.right,
//                         style: const TextStyle(fontSize: 22),
//                       ),
//                       subtitle: Text(ayah.textEn),
//                       trailing: matching.isNotEmpty
//                           ? Tooltip(
//                               message: matching.first.name,
//                               child: Icon(
//                                 Icons.bookmark,
//                                 color: matching.first.color,
//                               ),
//                             )
//                           : null,
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasaem_aliman/features/quran/domain/entities/bookmark.dart';
import 'package:nasaem_aliman/features/quran/domain/entities/surah.dart';
import 'package:nasaem_aliman/features/quran/presentatios/cubit/quran_cubit.dart';
import 'package:nasaem_aliman/features/quran/presentatios/cubit/quran_state.dart';
import 'package:nasaem_aliman/features/quran/presentatios/widgets/add_bookmark_dialog.dart';

class SurahDetailsScreen extends StatefulWidget {
  final Surah? surah;
  final int? surahId;
  final int? scrollToAyah;

  const SurahDetailsScreen({
    super.key,
    this.surah,
    this.surahId,
    this.scrollToAyah,
  }) : assert(
         surah != null || surahId != null,
         "Either surah or surahId must be provided",
       );

  @override
  State<SurahDetailsScreen> createState() => _SurahDetailsScreenState();
}

class _SurahDetailsScreenState extends State<SurahDetailsScreen> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    if (widget.surah == null && widget.surahId != null) {
      context.read<QuranCubit>().fetchSurah(widget.surahId!);
    } else if (widget.scrollToAyah != null) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _scrollToAyah(widget.scrollToAyah!),
      );
    }
  }

  void _scrollToAyah(int ayahNumber) {
    final surah = widget.surah;
    if (surah == null) return;

    final index = surah.ayahs.indexWhere((a) => a.number == ayahNumber);
    if (index != -1) {
      _controller.animateTo(
        index * 80.0,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranCubit, QuranState>(
      builder: (context, state) {
        Surah? surah = widget.surah;

        if (surah == null) {
          if (state is SurahLoaded) {
            surah = state.surah;
            if (widget.scrollToAyah != null) {
              WidgetsBinding.instance.addPostFrameCallback(
                (_) => _scrollToAyah(widget.scrollToAyah!),
              );
            }
          } else if (state is QuranLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state is QuranError) {
            return Scaffold(
              body: Center(child: Text("Error: ${state.message}")),
            );
          } else {
            return const Scaffold(body: Center(child: Text("Loading...")));
          }
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(surah.name),
            actions: [
              IconButton(
                icon: const Icon(Icons.bookmark_add),
                tooltip: "Add Bookmark",
                onPressed: () async {
                  // final cubit = context.read<QuranCubit>();
                  final selected = await showDialog<Bookmark>(
                    context: context,
                    builder: (_) => AddBookmarkDialog(surah: surah!),
                  );
                  if (selected != null) {
                    // cubit.addNewBookmark(selected);
                  }
                },
              ),
            ],
          ),
          body: BlocBuilder<QuranCubit, QuranState>(
            builder: (context, state) {
              List<Bookmark> bookmarks = [];
              if (state is BookmarksLoaded) {
                // bookmarks = state.bookmarks;
              }

              return ListView.builder(
                controller: _controller,
                itemCount: surah!.ayahs.length,
                itemBuilder: (context, i) {
                  final ayah = surah!.ayahs[i];
                  final matching = bookmarks.where(
                    (b) => b.surahId == surah!.id && b.ayahId == ayah.number,
                  );

                  // final Color? highlightColor = matching.isNotEmpty
                  //     ? matching.first.color
                  //     : null;
                  final Color? highlightColor = matching.isNotEmpty
                      ? Color(matching.first.color) // convert int -> Color
                      : null;
                  return Container(
                    color: highlightColor?.withValues(alpha: 0.2),
                    child: ListTile(
                      title: Text(
                        ayah.text,
                        textAlign: TextAlign.right,
                        style: const TextStyle(fontSize: 22),
                      ),
                      subtitle: Text(ayah.text),
                      trailing: matching.isNotEmpty
                          ? Tooltip(
                              message: matching.first.name,
                              child: Icon(
                                Icons.bookmark,
                                color: highlightColor,
                              ),
                            )
                          : null,
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
