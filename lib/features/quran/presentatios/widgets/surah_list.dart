import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/di/di.dart';
import '../../domain/entities/surah.dart';
import '../cubit/ayahs_cubit.dart';
import '../cubit/surah_details_cubit.dart';
import '../screens/surah_details_screen.dart';
import 'list_row.dart';

class SurahsList extends StatelessWidget {
  final List<SurahEntity> surahsList;
  const SurahsList({super.key, required this.surahsList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: surahsList.length,
      itemBuilder: (context, i) {
        final SurahEntity surah = surahsList[i];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (_) => sl<SurahDetailsCubit>()),
                    BlocProvider(create: (_) => sl<AyahsCubit>()),
                  ],
                  child: SurahDetailsScreen(surahId: surah.id),
                ),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppConstants.defaultPadding * 2.w,
              vertical: AppConstants.defaultPadding * .5.h,
            ),
            child: ListRow(
              text: surah.name,
              rowNumber: surah.id.toString(),
              rowTrailer: '( ${surah.versesCount} )',
              fontScale: "medium",
            ),
          ),
        );
      },
    );
  }
}
