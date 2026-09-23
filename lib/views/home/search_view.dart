import 'package:flutter/material.dart';
import 'package:product_explorer/core/theme/app_theme.dart';
import 'package:product_explorer/data/models/product_model.dart';
import 'package:product_explorer/main.dart';
import 'package:product_explorer/viewmodels/product_viewmodel.dart';
import 'package:product_explorer/views/product_details/product_details_view.dart';
import 'package:product_explorer/widgets/state_views.dart';
import 'package:provider/provider.dart';

class SearchView extends StatefulWidget {
  final Function(ProductModel)? onFavoriteToggle;
  final bool Function(int)? isFavorite;

  const SearchView({
    super.key,
    this.onFavoriteToggle,
    this.isFavorite,
  });

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final productVm = context.read<ProductViewModel>();
    _searchController.text = productVm.searchQuery;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    context.read<ProductViewModel>().search(query);
  }

  @override
  Widget build(BuildContext context) {
    final productVm = context.watch<ProductViewModel>();

    return Scaffold(
      backgroundColor: appColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: appColors.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: appColors.textColor),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: Container(
          height: 44,
          decoration: BoxDecoration(
            color: appColors.surfaceColor,
            borderRadius: BorderRadius.circular(AppRadius.large),
            border: Border.all(
              color: appColors.borderColor.withValues(alpha: 0.6),
            ),
          ),
          child: TextField(
            controller: _searchController,
            autofocus: true,
            style: AppFonts.body(color: appColors.textColor),
            onChanged: _onSearchChanged,
            decoration: InputDecoration(
              isDense: true,
              hintText: 'Search products...',
              hintStyle: AppFonts.searchText(color: appColors.hintColor),
              prefixIcon: Icon(Icons.search, color: appColors.hintColor, size: 20),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(Icons.close, color: appColors.hintColor, size: 18),
                      onPressed: () {
                        _searchController.clear();
                        productVm.clearSearch();
                      },
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ),
      body: Builder(
        builder: (context) {
          if (productVm.isSearching) {
            return const LoadingSkeletonView();
          }

          if (productVm.searchError != null) {
            return ErrorStateView(
              message: productVm.searchError!,
              onRetry: () => productVm.search(_searchController.text),
            );
          }

          if (productVm.searchQuery.isNotEmpty && productVm.searchResults.isEmpty) {
            return EmptyStateView(
              title: 'No products found',
              message: 'Try a different search term or browse all products.',
              buttonLabel: 'Browse Products',
              onAction: () {
                Navigator.maybePop(context);
              },
            );
          }

          if (productVm.searchQuery.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search_rounded,
                    size: 64,
                    color: appColors.hintColor.withValues(alpha: 0.5),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Search for phones, laptops, watches...',
                    style: AppFonts.body(color: appColors.textSecondaryColor),
                  ),
                ],
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(AppSpacing.mainPadding),
                child: Text(
                  'Search Results (${productVm.searchResults.length})',
                  style: AppFonts.sectionHeading(color: appColors.textColor),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.mainPadding),
                  itemCount: productVm.searchResults.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final product = productVm.searchResults[index];
                    final isFav = widget.isFavorite?.call(product.id) ?? false;

                    return InkWell(
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
                      borderRadius: BorderRadius.circular(AppRadius.large),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: appColors.cardColor,
                          borderRadius: BorderRadius.circular(AppRadius.large),
                          border: Border.all(
                            color: appColors.borderColor.withValues(alpha: 0.5),
                          ),
                        ),
                        child: Row(
                          children: [
                            // Product Image
                            Container(
                              width: 72,
                              height: 72,
                              decoration: BoxDecoration(
                                color: appColors.chipBg,
                                borderRadius: BorderRadius.circular(AppRadius.medium),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(AppRadius.medium),
                                child: Image.network(
                                  product.thumbnail,
                                  fit: BoxFit.contain,
                                  errorBuilder: (_, _, _) => Icon(
                                    Icons.image_not_supported_outlined,
                                    color: appColors.hintColor,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),

                            // Product Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.title,
                                    style: AppFonts.productName(color: appColors.textColor),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    product.formattedDiscountedPrice,
                                    style: AppFonts.price(color: appColors.textColor),
                                  ),
                                  const SizedBox(height: 4),
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
                                        style: AppFonts.productRating(
                                          color: appColors.textSecondaryColor,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: appColors.chipBg,
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          product.category,
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: appColors.textSecondaryColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // Heart Favorite Button
                            IconButton(
                              icon: Icon(
                                isFav ? Icons.favorite : Icons.favorite_border,
                                color: isFav ? appColors.redColor : appColors.hintColor,
                              ),
                              onPressed: () {
                                widget.onFavoriteToggle?.call(product);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
