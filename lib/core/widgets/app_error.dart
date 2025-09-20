import 'package:flutter/material.dart';

class AppError extends StatelessWidget {
  final String message;
  const AppError({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("❌ $message}"));
  }

  // Widget buildError(Object? err) => Center(
  //   child: Column(
  //     mainAxisSize: MainAxisSize.min,
  //     children: [
  //       Text(
  //         'تعذّر تحميل البيانات.\n$err',
  //         textAlign: TextAlign.center,
  //         style: const TextStyle(color: Colors.red),
  //       ),
  //       const SizedBox(height: 12),
  //       ElevatedButton.icon(
  //         onPressed: () {
  //           setState(() {
  //             pagesFuture = QuranLogic.groupAyahsByPage(
  //               widget.filteredAyahs,
  //               widget.surahNumber,
  //             );
  //           });
  //         },
  //         icon: const Icon(Icons.refresh),
  //         label: const Text('إعادة المحاولة'),
  //       ),
  //     ],
  //   ),
  // );
}
