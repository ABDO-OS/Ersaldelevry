import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../core/constants/app_strings.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;
  final bool showSeeAll;

  const SectionHeader({
    super.key,
    required this.title,
    this.onSeeAll,
    this.showSeeAll = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          if (showSeeAll && onSeeAll != null)
            TextButton(
              onPressed: onSeeAll,
              style: TextButton.styleFrom(
                foregroundColor: AppTheme.primaryGreen,
              ),
              child: const Text(AppStrings.seeAll),
            ),
        ],
      ),
    );
  }
}
