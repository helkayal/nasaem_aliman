import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/app_error.dart';
import '../../../../core/widgets/app_loading.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../cubit/quran_pages_view_cubit.dart';
import '../cubit/quran_pages_view_state.dart';
import 'quran_page_widget.dart';

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
    return BlocBuilder<QuranPagesViewCubit, QuranPagesViewState>(
      builder: (context, state) {
        String surahTitle = widget.title ?? "";
        String juzTitle = "";

        if (state is QuranPagesViewLoaded) {
          // When from juz list: Show juz name first, then surah name
          surahTitle = state.currentSurahName;
          juzTitle = state.currentJuzName;
        }

        return Scaffold(
          appBar: CustomAppBar(title: '$juzTitle - $surahTitle'),
          body: BlocConsumer<QuranPagesViewCubit, QuranPagesViewState>(
            listener: (context, state) {
              if (state is QuranPagesViewNavigating) {
                // Show loading indicator during navigation
              } else if (state is QuranPagesViewLoaded &&
                  _isPageControllerReady) {
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
                    // PageView
                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: 604,
                        reverse: true,
                        onPageChanged: (index) {
                          context.read<QuranPagesViewCubit>().updateCurrentPage(
                            index + 1,
                          );
                        },
                        itemBuilder: (context, index) {
                          final pageNumber = index + 1;
                          final page = context
                              .read<QuranPagesViewCubit>()
                              .getPage(pageNumber);

                          if (page == null) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
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
      },
    );
  }
}
