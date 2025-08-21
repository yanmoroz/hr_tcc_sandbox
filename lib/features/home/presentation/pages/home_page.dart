import 'package:flutter/material.dart';
import '../../../../shared/widgets/user_top_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          UserTopBar(),
          Expanded(child: Center(child: Text('Главная'))),
        ],
      ),
    );
  }
}
