import 'package:flutter/material.dart';

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

  static final List<Widget> _tabs = <Widget>[
    HomePage(),
    RequestsPage(),
    AddressBookPage(),
    MorePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            label: 'Мои заявки',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts_outlined),
            label: 'Адресная книга',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'Ещё'),
        ],
      ),
    );
  }
}
