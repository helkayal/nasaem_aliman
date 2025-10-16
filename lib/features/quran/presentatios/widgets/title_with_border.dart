import 'package:flutter/material.dart';

class TitleWithBorder extends StatelessWidget {
  final String title;
  const TitleWithBorder({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/title_border.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(title, style: Theme.of(context).textTheme.titleMedium),
      ),
    );
  }
}
