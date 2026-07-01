import 'package:flutter/material.dart';

import '../../models/review.dart';
import '../../routers/app_routes.dart';
import '../../services/review_service.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_spacing.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/loading_widget.dart';

class ReviewsPage extends StatefulWidget {
  const ReviewsPage({super.key});

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  final ReviewService _reviewService = ReviewService();

  String? _placeId;
  Future<List<Review>>? _reviewsFuture;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_reviewsFuture != null) return;

    final args = ModalRoute.of(context)?.settings.arguments;

    if (args is String) {
      _placeId = args;
      _reviewsFuture = _reviewService.getReviewsByPlace(args);
    }
  }

  Future<void> _openAddReview() async {
    if (_placeId == null) return;

    await Navigator.pushNamed(
      context,
      AppRoutes.addReview,
      arguments: _placeId,
    );

    setState(() {
      _reviewsFuture = _reviewService.getReviewsByPlace(_placeId!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Avaliações'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: _openAddReview,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: _reviewsFuture == null
          ? const Center(child: Text('Local não informado.'))
          : FutureBuilder<List<Review>>(
              future: _reviewsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingWidget(
                    message: 'Carregando avaliações...',
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Erro: ${snapshot.error}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                final reviews = snapshot.data ?? [];

                if (reviews.isEmpty) {
                  return const Center(
                    child: Text(
                      'Nenhuma avaliação encontrada.',
                      style: AppTextStyles.small,
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  itemCount: reviews.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: AppSpacing.md),
                  itemBuilder: (context, index) {
                    final review = reviews[index];

                    return Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review.userName,
                            style: AppTextStyles.body.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: AppColors.accent,
                                size: 18,
                              ),
                              const SizedBox(width: 4),
                              Text(review.rating.toStringAsFixed(1)),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(review.comment),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}