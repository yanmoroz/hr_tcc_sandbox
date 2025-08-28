import 'package:flutter/material.dart';
import '../../../shared/widgets/app_bottom_navigation_bar.dart';
import '../../../features/home/presentation/pages/home_page.dart';
import '../../../features/requests/presentation/pages/requests_page.dart';
import '../../../features/address_book/presentation/pages/address_book_page.dart';
import '../../../features/more/presentation/pages/more_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  late final List<Widget> _tabs = <Widget>[
    const HomePage(),
    RequestsPage(),
    AddressBookPage(),
    MorePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _tabs),
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
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
