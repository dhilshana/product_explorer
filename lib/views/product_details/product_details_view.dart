import 'package:flutter/material.dart';
import 'package:product_explorer/core/theme/app_theme.dart';
import 'package:product_explorer/data/models/product_model.dart';
import 'package:product_explorer/main.dart';
import 'package:product_explorer/widgets/custom_button.dart';

class ProductDetailsView extends StatefulWidget {
  final ProductModel product;
  final Function(ProductModel)? onFavoriteToggle;
  final bool Function(int)? isFavorite;

  const ProductDetailsView({
    super.key,
    required this.product,
    this.onFavoriteToggle,
    this.isFavorite,
  });

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  final PageController _pageController = PageController();
  int _activeImageIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    final images = p.images.isNotEmpty ? p.images : [p.thumbnail];
    final isFav = widget.isFavorite?.call(p.id) ?? false;

    return Scaffold(
      backgroundColor: appColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: appColors.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: appColors.textColor),
          onPressed: () => Navigator.maybePop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: isFav ? appColors.redColor : appColors.textColor,
            ),
            onPressed: () {
              widget.onFavoriteToggle?.call(p);
              setState(() {});
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.mainPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Carousel
            Container(
              height: 240,
              width: double.infinity,
              decoration: BoxDecoration(
                color: appColors.chipBg,
                borderRadius: BorderRadius.circular(AppRadius.large),
              ),
              child: PageView.builder(
                controller: _pageController,
                itemCount: images.length,
                onPageChanged: (index) {
                  setState(() {
                    _activeImageIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Image.network(
                      images[index],
                      fit: BoxFit.contain,
                      errorBuilder: (_, _, _) => Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          size: 48,
                          color: appColors.hintColor,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),

            // Carousel Dot Indicators
            if (images.length > 1)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  images.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: _activeImageIndex == index ? 16 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: _activeImageIndex == index
                          ? appColors.primaryColor
                          : appColors.borderColor,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 18),

            // Product Title
            Text(
              p.title,
              style: AppFonts.largeHeading(color: appColors.textColor),
            ),
            const SizedBox(height: 8),

            // Rating Row
            Row(
              children: [
                Icon(Icons.star_rounded, color: appColors.ratingGold, size: 18),
                const SizedBox(width: 4),
                Text(
                  '${p.rating.toStringAsFixed(1)} (${p.stock} reviews)',
                  style: AppFonts.button(color: appColors.textSecondaryColor),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Price Row with Discount Badge
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  p.formattedDiscountedPrice,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: appColors.textColor,
                  ),
                ),
                if (p.hasDiscount) ...[
                  const SizedBox(width: 10),
                  Text(
                    p.formattedPrice,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: appColors.textSecondaryColor,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: appColors.redColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${p.discountPercentage.toStringAsFixed(0)}% OFF',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: appColors.redColor,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 20),

            // Description Section
            Text(
              'Description',
              style: AppFonts.sectionHeading(color: appColors.textColor),
            ),
            const SizedBox(height: 8),
            Text(
              p.description,
              style: TextStyle(
                fontSize: 13,
                height: 1.5,
                color: appColors.textSecondaryColor,
              ),
            ),

            if (p.warrantyInformation != null || p.shippingInformation != null) ...[
              const SizedBox(height: 16),
              if (p.warrantyInformation != null)
                Row(
                  children: [
                    Icon(Icons.shield_outlined, size: 16, color: appColors.primaryColor),
                    const SizedBox(width: 8),
                    Text(
                      p.warrantyInformation!,
                      style: AppFonts.smallBody(color: appColors.textSecondaryColor),
                    ),
                  ],
                ),
              const SizedBox(height: 6),
              if (p.shippingInformation != null)
                Row(
                  children: [
                    Icon(Icons.local_shipping_outlined, size: 16, color: appColors.primaryColor),
                    const SizedBox(width: 8),
                    Text(
                      p.shippingInformation!,
                      style: AppFonts.smallBody(color: appColors.textSecondaryColor),
                    ),
                  ],
                ),
            ],

            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.mainPadding,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          color: appColors.backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: CustomButton(
            label: isFav ? 'Remove from Favorites' : 'Add to Favorites',
            icon: isFav ? Icons.favorite : Icons.favorite_border,
            backgroundColor: isFav ? appColors.redColor : appColors.primaryColor,
            onTap: () {
              widget.onFavoriteToggle?.call(p);
              setState(() {});
            },
          ),
        ),
      ),
    );
  }
}
