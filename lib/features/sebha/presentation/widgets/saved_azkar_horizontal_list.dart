import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/number_converter.dart';
import '../cubit/sebha_cubit.dart';
import '../cubit/sebha_state.dart';
import 'saved_azkar_card.dart';
import 'zikr_dialog.dart';

class SavedAzkarHorizontalList extends StatefulWidget {
  const SavedAzkarHorizontalList({super.key});

  @override
  State<SavedAzkarHorizontalList> createState() =>
      _SavedAzkarHorizontalListState();
}

class _SavedAzkarHorizontalListState extends State<SavedAzkarHorizontalList> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 1);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _showEditDialog(String id, String currentText) async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => ZikrDialog.edit(currentText),
    );

    if (result != null && mounted) {
      context.read<SebaaCubit>().editZikr(id, result);
    }
  }

  Future<void> _showDeleteConfirmDialog(String id, String text) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'حذف الذكر',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        content: Text(
          'هل أنت متأكد من حذف هذا الذكر؟\n"${text.length > 50 ? '${text.substring(0, 50)}...' : text}"',
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              // backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('حذف'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      context.read<SebaaCubit>().removeZikr(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SebaaCubit, SebhaState>(
      builder: (context, state) {
        if (state is SebhaLoading) {
          return SizedBox(
            height: 150.h,
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        if (state is SebhaLoaded && state.savedAzkar.isNotEmpty) {
          // Update page controller when current index changes
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_pageController.hasClients &&
                _pageController.page?.round() != state.currentIndex) {
              _goToPage(state.currentIndex);
            }
          });

          return Column(
            children: [
              // Navigation arrows and page indicators
              state.savedAzkar.length > 1
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: state.currentIndex > 0
                                ? () => context
                                      .read<SebaaCubit>()
                                      .navigateToIndex(state.currentIndex - 1)
                                : null,
                            icon: Icon(
                              Icons.arrow_back_ios,
                              size: 20.sp,
                              color: state.currentIndex > 0
                                  ? Theme.of(context).colorScheme.onSurface
                                  : Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          Text(
                            '${(NumberConverter.intToArabic(state.currentIndex + 1))} / ${NumberConverter.intToArabic(state.savedAzkar.length)}',
                            // style: Theme.of(context).textTheme.titleSmall,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          IconButton(
                            onPressed:
                                state.currentIndex < state.savedAzkar.length - 1
                                ? () => context
                                      .read<SebaaCubit>()
                                      .navigateToIndex(state.currentIndex + 1)
                                : null,
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              size: 20.sp,
                              color:
                                  state.currentIndex <
                                      state.savedAzkar.length - 1
                                  ? Theme.of(context).colorScheme.onSurface
                                  : Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(height: 16.h),
              // Horizontal list of azkar cards
              SizedBox(
                height: 60.h,
                width: double.infinity,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    context.read<SebaaCubit>().navigateToIndex(index);
                  },
                  itemCount: state.savedAzkar.length,
                  itemBuilder: (context, index) {
                    final zikr = state.savedAzkar[index];
                    final isSelected = state.currentZikr?.id == zikr.id;

                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: SavedAzkarCard(
                        zikr: zikr,
                        isSelected: isSelected,
                        onEdit: () => _showEditDialog(zikr.id, zikr.text),
                        onDelete: () =>
                            _showDeleteConfirmDialog(zikr.id, zikr.text),
                        onTap: () =>
                            context.read<SebaaCubit>().selectZikr(zikr.id),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }

        if (state is SebhaError) {
          return SizedBox(
            height: 150.h,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 32.sp,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    state.message,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }

        // Empty state
        return SizedBox(
          height: 60.h,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 4.h),
                Text(
                  'لا توجد أذكار محفوظة',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'اضغط على + لإضافة ذكر جديد',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
