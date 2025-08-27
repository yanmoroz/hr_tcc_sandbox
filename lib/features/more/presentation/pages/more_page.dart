import 'package:flutter/material.dart';
import '../../../../shared/widgets/user_top_bar.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const UserTopBar(),
          Expanded(
            child: SingleChildScrollView(
              child: const Center(child: Text('Ещё')),
            ),
          ),
        ],
      ),
    );
  }
}
