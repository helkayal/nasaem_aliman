import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/app_error.dart';
import '../../../../core/widgets/app_loading.dart';
import '../cubit/surah_details_cubit.dart';
import '../cubit/surah_details_state.dart';
import '../widgets/surah_text.dart';

class SurahDetailsScreen extends StatefulWidget {
  final int surahId;
  final int? startAyah;
  final int? endAyah;
  final String? juzName;

  const SurahDetailsScreen({
    super.key,
    required this.surahId,
    this.startAyah,
    this.endAyah,
    this.juzName,
  });

  @override
  State<SurahDetailsScreen> createState() => _SurahDetailsScreenState();
}

class _SurahDetailsScreenState extends State<SurahDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SurahDetailsCubit>().fetchSurah(widget.surahId);
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

          final filteredAyahs =
              (widget.startAyah != null && widget.endAyah != null)
              ? surah.ayahs
                    .where(
                      (a) =>
                          a.number >= widget.startAyah! &&
                          a.number <= widget.endAyah!,
                    )
                    .toList()
              : surah.ayahs;

          return Scaffold(
            appBar: AppBar(
              title: Text(
                widget.juzName != null
                    ? "${widget.juzName} - ${surah.name}"
                    : surah.name,
              ),
            ),
            body: SurahText(
              filteredAyahs: filteredAyahs,
              surahNumber: surah.id,
              surahName: surah.name,
            ),
          );
        }

        return AppLoading();
      },
    );
  }
}
