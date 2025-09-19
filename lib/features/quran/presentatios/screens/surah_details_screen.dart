// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:nasaem_aliman/features/quran/domain/entities/bookmark.dart';
// import 'package:nasaem_aliman/features/quran/domain/entities/surah.dart';
// import 'package:nasaem_aliman/features/quran/presentatios/cubit/quran_cubit.dart';
// import 'package:nasaem_aliman/features/quran/presentatios/cubit/quran_state.dart';
// import 'package:nasaem_aliman/features/quran/presentatios/widgets/add_bookmark_dialog.dart';

// class SurahDetailsScreen extends StatefulWidget {
//   final Surah? surah;
//   final int? surahId;
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

//     if (widget.surah == null && widget.surahId != null) {
//       context.read<QuranCubit>().fetchSurah(widget.surahId!);
//     } else if (widget.scrollToAyah != null) {
//       WidgetsBinding.instance.addPostFrameCallback(
//         (_) => _scrollToAyah(widget.scrollToAyah!),
//       );
//     }
//   }

//   void _scrollToAyah(int ayahNumber) {
//     final surah = widget.surah;
//     if (surah == null) return;

//     final index = surah.ayahs.indexWhere((a) => a.number == ayahNumber);
//     if (index != -1) {
//       _controller.animateTo(
//         index * 80.0,
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
//             if (widget.scrollToAyah != null) {
//               WidgetsBinding.instance.addPostFrameCallback(
//                 (_) => _scrollToAyah(widget.scrollToAyah!),
//               );
//             }
//           } else if (state is SurahLoading) {
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

//         return Scaffold(
//           appBar: AppBar(
//             title: Text(surah.name),
//             actions: [
//               IconButton(
//                 icon: const Icon(Icons.bookmark_add),
//                 tooltip: "Add Bookmark",
//                 onPressed: () async {
//                   // final cubit = context.read<QuranCubit>();
//                   final selected = await showDialog<Bookmark>(
//                     context: context,
//                     builder: (_) => AddBookmarkDialog(surah: surah!),
//                   );
//                   if (selected != null) {
//                     // cubit.addNewBookmark(selected);
//                   }
//                 },
//               ),
//             ],
//           ),
//           body: BlocBuilder<QuranCubit, QuranState>(
//             builder: (context, state) {
//               List<Bookmark> bookmarks = [];
//               if (state is BookmarksLoaded) {
//                 // bookmarks = state.bookmarks;
//               }

//               return ListView.builder(
//                 controller: _controller,
//                 itemCount: surah!.ayahs.length,
//                 itemBuilder: (context, i) {
//                   final ayah = surah!.ayahs[i];
//                   final matching = bookmarks.where(
//                     (b) => b.surahId == surah!.id && b.ayahId == ayah.number,
//                   );

//                   // final Color? highlightColor = matching.isNotEmpty
//                   //     ? matching.first.color
//                   //     : null;
//                   final Color? highlightColor = matching.isNotEmpty
//                       ? Color(matching.first.color) // convert int -> Color
//                       : null;
//                   return Container(
//                     color: highlightColor?.withValues(alpha: 0.2),
//                     child: ListTile(
//                       title: Text(
//                         ayah.text,
//                         textAlign: TextAlign.right,
//                         style: const TextStyle(fontSize: 22),
//                       ),
//                       subtitle: Text(ayah.text),
//                       trailing: matching.isNotEmpty
//                           ? Tooltip(
//                               message: matching.first.name,
//                               child: Icon(
//                                 Icons.bookmark,
//                                 color: highlightColor,
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

import '../../../../core/widgets/app_error.dart';
import '../../../../core/widgets/app_loading.dart';
import '../../domain/entities/surah.dart';
import '../cubit/surah_details_cubit.dart';
import '../cubit/surah_details_state.dart';

class SurahDetailsScreen extends StatefulWidget {
  final int surahId;
  final int? scrollToAyah;

  const SurahDetailsScreen({
    super.key,
    required this.surahId,
    this.scrollToAyah,
  });

  @override
  State<SurahDetailsScreen> createState() => _SurahDetailsScreenState();
}

class _SurahDetailsScreenState extends State<SurahDetailsScreen> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<SurahDetailsCubit>().fetchSurah(widget.surahId);
  }

  void _scrollToAyah(int ayahNumber, Surah surah) {
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
    return BlocBuilder<SurahDetailsCubit, SurahDetailsState>(
      builder: (context, state) {
        if (state is SurahDetailsLoading) {
          return AppLoading();
        } else if (state is SurahDetailsError) {
          return AppError(message: "Error: ${state.message}");
        } else if (state is SurahDetailsLoaded) {
          final surah = state.surah;

          if (widget.scrollToAyah != null) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) => _scrollToAyah(widget.scrollToAyah!, surah),
            );
          }

          return Scaffold(
            appBar: AppBar(title: Text(surah.name)),
            body: ListView.builder(
              controller: _controller,
              itemCount: surah.ayahs.length,
              itemBuilder: (context, i) {
                final ayah = surah.ayahs[i];
                return ListTile(
                  title: Text(
                    ayah.text,
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontSize: 22),
                  ),
                  subtitle: Text(ayah.text),
                );
              },
            ),
          );
        }

        return AppLoading();
      },
    );
  }
}
