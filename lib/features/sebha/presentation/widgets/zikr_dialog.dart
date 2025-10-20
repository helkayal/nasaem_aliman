import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ZikrDialog extends StatelessWidget {
  final String title;
  final String? initialText;
  final String submitButtonText;
  final String cancelButtonText;

  const ZikrDialog({
    super.key,
    required this.title,
    this.initialText,
    this.submitButtonText = 'حفظ',
    this.cancelButtonText = 'إلغاء',
  });

  /// Factory constructor for adding new zikr
  factory ZikrDialog.add() {
    return const ZikrDialog(title: 'إضافة ذكر جديد', submitButtonText: 'حفظ');
  }

  /// Factory constructor for editing existing zikr
  factory ZikrDialog.edit(String currentText) {
    return ZikrDialog(
      title: 'تعديل الذكر',
      initialText: currentText,
      submitButtonText: 'حفظ',
    );
  }

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController(text: initialText);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: Text(title, style: Theme.of(context).textTheme.titleMedium),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: textController,
            style: Theme.of(context).textTheme.titleMedium,
            cursorColor: Theme.of(context).colorScheme.onPrimary,
            cursorWidth: 2.0,
            cursorHeight: 20.0,
            decoration: InputDecoration(
              labelStyle: Theme.of(context).textTheme.titleMedium,
              labelText: 'نص الذكر',
              border: const OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.onPrimary,
                  width: 2.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(
                    context,
                  ).colorScheme.onPrimary.withValues(alpha: 0.5),
                  width: 1.0,
                ),
              ),
            ),
            maxLines: 3,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            cancelButtonText,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            final text = textController.text.trim();

            if (text.isNotEmpty) {
              Navigator.of(context).pop(text);
            }
          },
          child: Text(
            submitButtonText,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ],
    );
  }
}
