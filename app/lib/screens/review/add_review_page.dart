import 'package:flutter/material.dart';

import '../../services/review_service.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_spacing.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/app_button.dart';

class AddReviewPage extends StatefulWidget {
  const AddReviewPage({super.key});

  @override
  State<AddReviewPage> createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  final ReviewService _reviewService = ReviewService();
  final TextEditingController _commentController = TextEditingController();

  String? _placeId;
  double _rating = 4;
  bool _loading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments;

    if (args is String) {
      _placeId = args;
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _sendReview() async {
    if (_placeId == null) return;

    final comment = _commentController.text.trim();

    if (comment.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Digite um comentário.')),
      );
      return;
    }

    setState(() {
      _loading = true;
    });

    try {
      await _reviewService.createReview(
        placeId: _placeId!,
        rating: _rating,
        comment: comment,
      );

      if (!mounted) return;

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao enviar avaliação: $e')),
      );
    } finally {
      if (!mounted) return;

      setState(() {
        _loading = false;
      });
    }
  }

  Widget _buildStar(int index) {
    final selected = index <= _rating;

    return IconButton(
      onPressed: () {
        setState(() {
          _rating = index.toDouble();
        });
      },
      icon: Icon(
        selected ? Icons.star : Icons.star_border,
        color: AppColors.accent,
        size: 36,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar avaliação'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Sua nota', style: AppTextStyles.subtitle),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: List.generate(
                5,
                (index) => _buildStar(index + 1),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            TextField(
              controller: _commentController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Comentário',
                alignLabelWithHint: true,
              ),
            ),
            const Spacer(),
            AppButton(
              text: _loading ? 'Enviando...' : 'Enviar avaliação',
              icon: Icons.send_outlined,
              onPressed: _loading
                  ? null
                  : () {
                      _sendReview();
                    },
            ),
          ],
        ),
      ),
    );
  }
}