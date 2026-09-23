import 'package:flutter/material.dart';
import 'package:product_explorer/core/theme/app_theme.dart';
import 'package:product_explorer/data/models/product_model.dart';
import 'package:product_explorer/main.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;

  const ProductCard({
    super.key,
    required this.product,
    required this.isFavorite,
    required this.onTap,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.large),
      child: Container(
        decoration: BoxDecoration(
          color: appColors.cardColor,
          borderRadius: BorderRadius.circular(AppRadius.large),
          border: Border.all(
            color: appColors.borderColor.withValues(alpha: 0.5),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: AppRadius.medium,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: EdgeInsets.all(AppSpacing.paddingSmall),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with Favorite Button on Top Right
            Stack(
              children: [
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: appColors.chipBg,
                    borderRadius: BorderRadius.circular(AppRadius.medium),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.medium),
                    child: Image.network(
                      product.thumbnail,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          color: appColors.hintColor,
                          size: 32,
                        ),
                      ),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                appColors.primaryColor,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: Material(
                    color: Colors.white.withValues(alpha: 0.9),
                    shape: const CircleBorder(),
                    elevation: 1,
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: onFavoriteToggle,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          size: 18,
                          color: isFavorite ? appColors.redColor : appColors.textSecondaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSpacing.spacingS),
            // Title
            Text(
              product.title,
              style: AppFonts.productName(color: appColors.textColor),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: AppSpacing.spacingXS),
            // Price
            Text(
              product.formattedDiscountedPrice,
              style: AppFonts.price(color: appColors.textColor),
            ),
            SizedBox(height: AppSpacing.spacingXS),
            // Rating and Review Count
            Row(
              children: [
                Icon(
                  Icons.star_rounded,
                  size: 14,
                  color: appColors.ratingGold,
                ),
                const SizedBox(width: 3),
                Text(
                  '${product.rating.toStringAsFixed(1)} (${product.stock})',
                  style: AppFonts.productRating(color: appColors.textSecondaryColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
