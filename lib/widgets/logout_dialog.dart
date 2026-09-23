import 'package:flutter/material.dart';
import 'package:product_explorer/core/theme/app_theme.dart';
import 'package:product_explorer/main.dart';
import 'package:product_explorer/widgets/custom_button.dart';

class LogoutDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const LogoutDialog({
    super.key,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.large),
      ),
      backgroundColor: appColors.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: appColors.primaryColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.info_outline_rounded,
                size: 32,
                color: appColors.primaryColor,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'Are you sure you want to\nlog out?',
              style: AppFonts.largeHeading(color: appColors.textColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'You will need to log in again\nto access your account.',
              style: AppFonts.body(color: appColors.textSecondaryColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            CustomButton(
              label: 'Log Out',
              onTap: () {
                Navigator.pop(context);
                onConfirm();
              },
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: appColors.borderColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.medium),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: AppFonts.button(color: appColors.textColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
