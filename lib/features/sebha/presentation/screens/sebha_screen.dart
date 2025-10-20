import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/di/di.dart' as di;
import '../cubit/sebha_cubit.dart';
import '../cubit/sebha_state.dart';
import '../widgets/saved_azkar_horizontal_list.dart';
import '../widgets/zikr_dialog.dart';
import '../widgets/sebha_widget.dart';

class SebhaScreen extends StatelessWidget {
  const SebhaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<SebaaCubit>()..loadSavedAzkar(),
      child: const _SebhaScreenContent(),
    );
  }
}

class _SebhaScreenContent extends StatefulWidget {
  const _SebhaScreenContent();

  @override
  State<_SebhaScreenContent> createState() => _SebhaScreenContentState();
}

class _SebhaScreenContentState extends State<_SebhaScreenContent>
    with
        AutomaticKeepAliveClientMixin<_SebhaScreenContent>,
        WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> _showAddZikrDialog() async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => ZikrDialog.add(),
    );

    if (result != null && mounted) {
      context.read<SebaaCubit>().addZikr(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // for AutomaticKeepAliveClientMixin

    return Scaffold(
      appBar: CustomAppBar(
        title: "السبحه",
        actions: [
          IconButton(
            onPressed: _showAddZikrDialog,
            icon: const Icon(Icons.add),
            tooltip: "إضافة ذكر",
          ),
          BlocBuilder<SebaaCubit, SebhaState>(
            builder: (context, state) {
              final hasCurrentZikr =
                  state is SebhaLoaded && state.currentZikr != null;

              return IconButton(
                onPressed: hasCurrentZikr
                    ? () => context.read<SebaaCubit>().resetCounter()
                    : null,
                icon: Icon(
                  Icons.refresh,
                  color: hasCurrentZikr
                      ? null
                      : Theme.of(context).colorScheme.outline,
                ),
                tooltip: "إعادة التصفير",
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Saved azkar horizontal list
          const SavedAzkarHorizontalList(),

          SizedBox(height: 4.h),

          // Sebha widget
          const Expanded(child: SebhaWidget()),
        ],
      ),
    );
  }
}
