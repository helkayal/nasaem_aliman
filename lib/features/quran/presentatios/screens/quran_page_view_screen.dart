import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/number_converter.dart';
import '../../../../core/widgets/app_error.dart';
import '../../../../core/widgets/app_loading.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../cubit/quran_pages_view_cubit.dart';
import '../cubit/quran_pages_view_state.dart';
import '../widgets/quran_page_widget.dart';

class QuranPageViewScreen extends StatefulWidget {
  final int? initialPage;
  final String? title;

  const QuranPageViewScreen({super.key, this.initialPage, this.title});

  @override
  State<QuranPageViewScreen> createState() => _QuranPageViewScreenState();
}

class _QuranPageViewScreenState extends State<QuranPageViewScreen> {
  late PageController _pageController;
  bool _isPageControllerReady = false;

  @override
  void initState() {
    super.initState();
    final initialPage = (widget.initialPage ?? 1) - 1; // Convert to 0-based
    _pageController = PageController(initialPage: initialPage);

    // Load pages and navigate to initial page if specified
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuranPagesViewCubit>().loadAllPages().then((_) {
        if (!mounted) return;
        if (widget.initialPage != null) {
          context.read<QuranPagesViewCubit>().goToPage(widget.initialPage!);
        }
        if (mounted) {
          setState(() {
            _isPageControllerReady = true;
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.title ?? "المصحف الشريف",
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _showPageJumpDialog,
          ),
        ],
      ),
      body: BlocConsumer<QuranPagesViewCubit, QuranPagesViewState>(
        listener: (context, state) {
          if (state is QuranPagesViewNavigating) {
            // Show loading indicator during navigation
          } else if (state is QuranPagesViewLoaded && _isPageControllerReady) {
            // Navigate PageController to new page if needed
            final targetPage = state.currentPage - 1; // Convert to 0-based
            if (_pageController.hasClients &&
                _pageController.page?.round() != targetPage) {
              _pageController.animateToPage(
                targetPage,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          }
        },
        builder: (context, state) {
          if (state is QuranPagesViewLoading) {
            return const AppLoading();
          } else if (state is QuranPagesViewError) {
            return AppError(message: state.message);
          } else if (state is QuranPagesViewLoaded) {
            return Column(
              children: [
                // Page indicator
                _buildPageIndicator(state.currentPage),
                // PageView
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: 604,
                    onPageChanged: (index) {
                      context.read<QuranPagesViewCubit>().updateCurrentPage(
                        index + 1,
                      );
                    },
                    itemBuilder: (context, index) {
                      final pageNumber = index + 1;
                      final page = context.read<QuranPagesViewCubit>().getPage(
                        pageNumber,
                      );

                      if (page == null) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      return QuranPageWidget(page: page);
                    },
                  ),
                ),
              ],
            );
          }

          return const AppLoading();
        },
      ),
    );
  }

  Widget _buildPageIndicator(int currentPage) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding.w,
        vertical: 8.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.lightBlue.withValues(alpha: .1),
        border: const Border(bottom: BorderSide(color: AppColors.lightGrey)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "صفحة ${NumberConverter.toArabicNumbers(currentPage.toString())}",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.blue,
            ),
          ),
          Text(
            "من ${NumberConverter.toArabicNumbers('604')}",
            style: TextStyle(fontSize: 14.sp, color: AppColors.darkGrey),
          ),
        ],
      ),
    );
  }

  void _showPageJumpDialog() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("الانتقال إلى صفحة"),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "رقم الصفحة (1-604)",
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("إلغاء"),
            ),
            TextButton(
              onPressed: () {
                final pageNumber = int.tryParse(controller.text);
                if (pageNumber != null &&
                    pageNumber >= 1 &&
                    pageNumber <= 604) {
                  context.read<QuranPagesViewCubit>().goToPage(pageNumber);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("يرجى إدخال رقم صفحة صحيح (1-604)"),
                    ),
                  );
                }
              },
              child: const Text("انتقال"),
            ),
          ],
        );
      },
    );
  }
}
