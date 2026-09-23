import 'package:flutter/material.dart';
import 'package:product_explorer/core/theme/app_theme.dart';
import 'package:product_explorer/main.dart';
import 'package:product_explorer/widgets/custom_button.dart';

class ErrorStateView extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onRetry;

  const ErrorStateView({
    super.key,
    this.title = 'Something went wrong',
    this.message = 'Failed to load products. Please check your internet connection and try again.',
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.mainPadding * 1.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: appColors.redColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.warning_amber_rounded,
                size: 44,
                color: appColors.redColor,
              ),
            ),
            SizedBox(height: AppSpacing.spacingL),
            Text(
              title,
              style: AppFonts.largeHeading(color: appColors.textColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppSpacing.spacingS),
            Text(
              message,
              style: AppFonts.body(color: appColors.textSecondaryColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppSpacing.spacingL),
            SizedBox(
              width: 140,
              child: CustomButton(
                label: 'Retry',
                onTap: onRetry,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmptyStateView extends StatelessWidget {
  final String title;
  final String message;
  final String buttonLabel;
  final VoidCallback? onAction;

  const EmptyStateView({
    super.key,
    this.title = 'No products found',
    this.message = 'Try a different search term or browse all products.',
    this.buttonLabel = 'Browse Products',
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.mainPadding * 1.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: appColors.primaryColor.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.inventory_2_outlined,
                size: 48,
                color: appColors.primaryColor,
              ),
            ),
            SizedBox(height: AppSpacing.spacingL),
            Text(
              title,
              style: AppFonts.largeHeading(color: appColors.textColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppSpacing.spacingS),
            Text(
              message,
              style: AppFonts.body(color: appColors.textSecondaryColor),
              textAlign: TextAlign.center,
            ),
            if (onAction != null) ...[
              SizedBox(height: AppSpacing.spacingL),
              SizedBox(
                width: 170,
                child: CustomButton(
                  label: buttonLabel,
                  onTap: onAction!,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class LoadingSkeletonView extends StatelessWidget {
  const LoadingSkeletonView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(appColors.primaryColor),
          ),
          const SizedBox(height: 16),
          Text(
            'Loading...',
            style: AppFonts.button(color: appColors.textSecondaryColor),
          ),
        ],
      ),
    );
  }
}
