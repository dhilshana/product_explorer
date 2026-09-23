import 'package:flutter/material.dart';
import 'package:product_explorer/main.dart';
import 'package:product_explorer/viewmodels/favorites_viewmodel.dart';
import 'package:product_explorer/views/favorites/favorites_view.dart';
import 'package:product_explorer/views/home/home_view.dart';
import 'package:product_explorer/views/profile/profile_view.dart';
import 'package:provider/provider.dart';

class MainNavView extends StatefulWidget {
  const MainNavView({super.key});

  @override
  State<MainNavView> createState() => _MainNavViewState();
}

class _MainNavViewState extends State<MainNavView> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FavoritesViewModel>().init();
    });
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final favVm = context.watch<FavoritesViewModel>();

    final screens = [
      HomeView(
        onFavoriteToggle: favVm.toggleFavorite,
        isFavorite: favVm.isFavorite,
      ),
      FavoritesView(
        onBrowseProducts: () => _onTabTapped(0),
      ),
      ProfileView(
        onNavigateToFavorites: () => _onTabTapped(1),
      ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: appColors.backgroundColor,
          border: Border(
            top: BorderSide(
              color: appColors.borderColor.withValues(alpha: 0.5),
              width: 1,
            ),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          backgroundColor: appColors.backgroundColor,
          selectedItemColor: appColors.primaryColor,
          unselectedItemColor: appColors.hintColor,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.storefront_outlined),
              activeIcon: Icon(Icons.storefront_rounded),
              label: 'Products',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline_rounded),
              activeIcon: Icon(Icons.favorite_rounded),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded),
              activeIcon: Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
