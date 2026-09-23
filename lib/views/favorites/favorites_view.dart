import 'package:flutter/material.dart';
import 'package:product_explorer/core/theme/app_theme.dart';
import 'package:product_explorer/main.dart';
import 'package:product_explorer/viewmodels/favorites_viewmodel.dart';
import 'package:product_explorer/views/product_details/product_details_view.dart';
import 'package:product_explorer/widgets/product_card.dart';
import 'package:product_explorer/widgets/state_views.dart';
import 'package:provider/provider.dart';

class FavoritesView extends StatelessWidget {
  final VoidCallback? onBrowseProducts;

  const FavoritesView({
    super.key,
    this.onBrowseProducts,
  });

  @override
  Widget build(BuildContext context) {
    final favVm = context.watch<FavoritesViewModel>();
    final favorites = favVm.favorites;

    return Scaffold(
      backgroundColor: appColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: appColors.backgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Favorites',
          style: AppFonts.largeHeading(color: appColors.textColor),
        ),
        actions: [
          if (favorites.isNotEmpty)
            IconButton(
              icon: Icon(
                Icons.delete_outline_rounded,
                color: appColors.textColor,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    backgroundColor: appColors.backgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.large),
                    ),
                    title: Text(
                      'Clear Favorites?',
                      style: AppFonts.largeHeading(color: appColors.textColor),
                    ),
                    content: Text(
                      'Are you sure you want to remove all saved products?',
                      style: AppFonts.body(color: appColors.textSecondaryColor),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: Text(
                          'Cancel',
                          style: AppFonts.button(color: appColors.textSecondaryColor),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                          favVm.clearAll();
                        },
                        child: Text(
                          'Clear All',
                          style: AppFonts.button(color: appColors.redColor),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          const SizedBox(width: 8),
        ],
      ),
      body: favorites.isEmpty
          ? EmptyStateView(
              title: 'No favorites yet',
              message: 'Browse products and tap the heart icon to save your favorites.',
              buttonLabel: 'Browse Products',
              onAction: onBrowseProducts,
            )
          : GridView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.mainPadding,
                vertical: 12,
              ),
              itemCount: favorites.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.72,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                final product = favorites[index];

                return ProductCard(
                  product: product,
                  isFavorite: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsView(
                          product: product,
                          isFavorite: favVm.isFavorite,
                          onFavoriteToggle: favVm.toggleFavorite,
                        ),
                      ),
                    );
                  },
                  onFavoriteToggle: () {
                    favVm.toggleFavorite(product);
                  },
                );
              },
            ),
    );
  }
}
