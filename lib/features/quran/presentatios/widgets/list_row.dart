import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListRow extends StatelessWidget {
  final String text;
  final String rowNumber;
  final String rowTrailer;
  const ListRow({
    super.key,
    required this.text,
    required this.rowNumber,
    required this.rowTrailer,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        spacing: 20,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Text(
              rowTrailer,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/images/number_bg.png'),
                fit: BoxFit.cover,
              ),
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 14.h),
              child: Text(
                rowNumber,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
