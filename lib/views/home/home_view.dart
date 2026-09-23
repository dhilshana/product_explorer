import 'package:flutter/material.dart';
import 'package:product_explorer/core/theme/app_theme.dart';
import 'package:product_explorer/data/models/product_model.dart';
import 'package:product_explorer/main.dart';
import 'package:product_explorer/viewmodels/product_viewmodel.dart';
import 'package:product_explorer/widgets/product_card.dart';
import 'package:product_explorer/widgets/state_views.dart';
import 'package:provider/provider.dart';

import '../product_details/product_details_view.dart';
import 'search_view.dart';

class HomeView extends StatefulWidget {
  final Function(ProductModel)? onFavoriteToggle;
  final bool Function(int)? isFavorite;

  const HomeView({
    super.key,
    this.onFavoriteToggle,
    this.isFavorite,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final productVm = context.read<ProductViewModel>();
      if (productVm.state == ProductViewState.initial) {
        productVm.loadInitialData();
      }
    });
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'all':
        return Icons.grid_view_rounded;
      case 'devices':
        return Icons.devices_rounded;
      case 'fashion':
        return Icons.checkroom_rounded;
      case 'home':
        return Icons.home_rounded;
      case 'beauty':
        return Icons.spa_rounded;
      case 'vehicle':
        return Icons.directions_car;
      case 'sports': 
        return Icons.sports;
      default:
        return Icons.category_rounded;
    }
  }


  @override
  Widget build(BuildContext context) {
    final productVm = context.watch<ProductViewModel>();

    return Scaffold(
      backgroundColor: appColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Top Search Bar + Notification Bell
            Padding(
              padding: EdgeInsets.all(AppSpacing.mainPadding),
              child: InkWell(
                borderRadius: BorderRadius.circular(AppRadius.large),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchView(
                        onFavoriteToggle: widget.onFavoriteToggle,
                        isFavorite: widget.isFavorite,
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 46,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: appColors.surfaceColor,
                    borderRadius: BorderRadius.circular(AppRadius.large),
                    border: Border.all(
                      color: appColors.borderColor.withValues(alpha: 0.6),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: appColors.hintColor, size: 20),
                      SizedBox(width: AppSpacing.spacingS),
                      Text(
                        'Search products...',
                        style: AppFonts.searchText(color: appColors.hintColor),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Content Body with States
            Expanded(
              child: Builder(
                builder: (context) {
                  if (productVm.state == ProductViewState.loading && productVm.filteredProducts.isEmpty) {
                    return const LoadingSkeletonView();
                  }

                  if (productVm.state == ProductViewState.error && productVm.filteredProducts.isEmpty) {
                    return ErrorStateView(
                      message: productVm.errorMessage ?? 'Failed to load products. Please check your internet connection and try again.',
                      onRetry: () => productVm.fetchProducts(),
                    );
                  }

                  if (productVm.state == ProductViewState.empty && productVm.filteredProducts.isEmpty) {
                    return EmptyStateView(
                      onAction: () => productVm.fetchProducts(),
                    );
                  }

                  return RefreshIndicator(
                    color: appColors.primaryColor,
                    onRefresh: () => productVm.fetchProducts(),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: AppSpacing.mainPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          // Categories Section
                          Text(
                            'Categories',
                            style: AppFonts.sectionHeading(color: appColors.textColor),
                          ),
                          SizedBox(height: AppSpacing.spacingS),
                          SizedBox(
                            height: 80,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: productVm.categories.take(8).length,
                              separatorBuilder: (_, _) => SizedBox(width: AppSpacing.spacingM),
                              itemBuilder: (context, index) {
                                final category = productVm.categories[index];
                                final isSelected = productVm.selectedCategory.toLowerCase() == category.toLowerCase();

                                return GestureDetector(
                                  onTap: () => productVm.selectCategory(category),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 52,
                                        height: 52,
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? appColors.primaryColor
                                              : appColors.chipBg,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: isSelected
                                                ? appColors.primaryColor
                                                : appColors.borderColor.withValues(alpha: 0.5),
                                          ),
                                        ),
                                        child: Icon(
                                          _getCategoryIcon(category),
                                          size: 24,
                                          color: isSelected
                                              ? Colors.white
                                              : appColors.textColor,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        category,
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: isSelected
                                              ? FontWeight.w600
                                              : FontWeight.w400,
                                          color: isSelected
                                              ? appColors.primaryColor
                                              : appColors.textSecondaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),

                          // const SizedBox(height: 16),

                          // Popular Products Section Header
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Popular Products',
                                style: AppFonts.sectionHeading(color: appColors.textColor),
                              ),
                              TextButton(
                                onPressed: () {
                                  productVm.selectCategory('All');
                                },
                                child: Text(
                                  'See all',
                                  style: AppFonts.button(color: appColors.primaryColor),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: AppSpacing.spacingS),

                          // Product Grid
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: productVm.filteredProducts.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.72,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                            ),
                            itemBuilder: (context, index) {
                              final product = productVm.filteredProducts[index];
                              final isFav = widget.isFavorite?.call(product.id) ?? false;

                              return ProductCard(
                                product: product,
                                isFavorite: isFav,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetailsView(
                                        product: product,
                                        onFavoriteToggle: widget.onFavoriteToggle,
                                        isFavorite: widget.isFavorite,
                                      ),
                                    ),
                                  );
                                },
                                onFavoriteToggle: () {
                                  widget.onFavoriteToggle?.call(product);
                                },
                              );
                            },
                          ),
                          SizedBox(height: AppSpacing.spacingL),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
