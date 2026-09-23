import 'package:flutter/material.dart';
import 'package:product_explorer/core/theme/app_theme.dart';
import 'package:product_explorer/main.dart';
import 'package:product_explorer/widgets/custom_button.dart';

class SplashView extends StatelessWidget {
  final VoidCallback onGetStarted;

  const SplashView({
    super.key,
    required this.onGetStarted,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.mainPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: appColors.primaryColor,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: appColors.primaryColor.withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.shopping_bag_rounded,
                  size: 48,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Product Explorer',
                style: AppFonts.appTitle(color: appColors.textColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'Discover great products\nat your fingertips',
                style: AppFonts.button(color: appColors.textSecondaryColor),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              CustomButton(
                label: 'Get Started',
                onTap: onGetStarted,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
