import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/widgets/app_bottom_navigation_bar.dart';

class MainPage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainPage({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(
          index,
          // If tapping the already selected tab, pop to its initial location
          initialLocation: index == navigationShell.currentIndex,
        ),
        items: const [
          AppBottomNavigationBarItem(
            icon: Icons.home_outlined,
            selectedIcon: Icons.home,
            label: 'Главная',
          ),
          AppBottomNavigationBarItem(
            icon: Icons.search_outlined,
            selectedIcon: Icons.search,
            label: 'Мои заявки',
          ),
          AppBottomNavigationBarItem(
            icon: Icons.contacts_outlined,
            selectedIcon: Icons.contacts,
            label: 'Адресная книга',
          ),
          AppBottomNavigationBarItem(
            icon: Icons.more_horiz,
            selectedIcon: Icons.more_horiz,
            label: 'Ещё',
          ),
        ],
      ),
    );
  }
}
