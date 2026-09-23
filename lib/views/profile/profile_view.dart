import 'package:flutter/material.dart';
import 'package:product_explorer/core/theme/app_theme.dart';
import 'package:product_explorer/main.dart';
import 'package:product_explorer/viewmodels/auth_viewmodel.dart';
import 'package:product_explorer/widgets/logout_dialog.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  final VoidCallback? onNavigateToFavorites;

  const ProfileView({
    super.key,
    this.onNavigateToFavorites,
  });

  @override
  Widget build(BuildContext context) {
    final authVm = context.watch<AuthViewModel>();

    final user = authVm.user;
    final displayName = user?.displayName?.isNotEmpty == true
        ? user!.displayName!
        : (user?.email?.split('@').first ?? 'Explorer');
    final email = user?.email?.isNotEmpty == true ? user!.email : 'user@example.com';

    return Scaffold(
      backgroundColor: appColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.mainPadding,
            vertical: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Header
              Row(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: appColors.primaryColor.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person_rounded,
                      size: 36,
                      color: appColors.primaryColor,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello,',
                          style: AppFonts.body(color: appColors.textSecondaryColor),
                        ),
                        Text(
                          displayName,
                          style: AppFonts.largeHeading(color: appColors.textColor),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          email?? 'user@gmail.com',
                          style: AppFonts.smallBody(color: appColors.textSecondaryColor),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              _buildMenuItem(
                context: context,
                icon: Icons.favorite_border_rounded,
                title: 'Favorites',
                onTap: onNavigateToFavorites ?? () {},
              ),
              _buildMenuItem(
                context: context,
                icon: Icons.help_outline_rounded,
                title: 'Help & Support',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('For support, visit support.productexplorer.com'),
                      backgroundColor: appColors.primaryColor,
                    ),
                  );
                },
              ),

              const SizedBox(height: 36),

              // Log Out Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: appColors.primaryColor.withValues(alpha: 0.5)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.medium),
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => LogoutDialog(
                        onConfirm: () {
                          authVm.logout();
                        },
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.logout_rounded,
                    color: appColors.primaryColor,
                    size: 20,
                  ),
                  label: Text(
                    'Log Out',
                    style: AppFonts.button(color: appColors.primaryColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    Widget? trailing,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: appColors.surfaceColor,
        borderRadius: BorderRadius.circular(AppRadius.medium),
        border: Border.all(
          color: appColors.borderColor.withValues(alpha: 0.5),
        ),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: appColors.primaryColor, size: 22),
        title: Text(
          title,
          style: AppFonts.button(color: appColors.textColor),
        ),
        trailing: trailing ??
            Icon(
              Icons.chevron_right_rounded,
              color: appColors.hintColor,
              size: 22,
            ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      ),
    );
  }
}
