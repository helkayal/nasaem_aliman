// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:nasaem_aliman/core/di/di.dart';
// import 'package:nasaem_aliman/features/quran/presentatios/cubit/quran_cubit.dart';
// import 'package:nasaem_aliman/features/quran/presentatios/cubit/quran_state.dart';
// import 'package:nasaem_aliman/features/quran/presentatios/widgets/surah_list.dart';

// class SurahTab extends StatelessWidget {
//   const SurahTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => sl<QuranCubit>()..fetchSurahs(),
//       child: BlocBuilder<QuranCubit, QuranState>(
//         builder: (context, state) {
//           if (state is QuranLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is SurahsLoaded) {
//             return SurahsList(surahsList: state.surahs);
//           }
//           return const SizedBox.shrink();
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasaem_aliman/core/di/di.dart';
import 'package:nasaem_aliman/features/quran/presentatios/cubit/quran_cubit.dart';
import 'package:nasaem_aliman/features/quran/presentatios/cubit/quran_state.dart';
import 'package:nasaem_aliman/features/quran/presentatios/widgets/surah_list.dart';

class SurahTab extends StatelessWidget {
  const SurahTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<QuranCubit>()..fetchAllSurahs(),
      child: BlocBuilder<QuranCubit, QuranState>(
        builder: (context, state) {
          if (state is SurahListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SurahListLoaded) {
            return SurahsList(surahsList: state.surahs);
          } else if (state is QuranError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
