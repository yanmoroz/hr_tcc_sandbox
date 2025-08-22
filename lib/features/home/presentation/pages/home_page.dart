import 'package:flutter/material.dart';
import '../../../../shared/widgets/user_top_bar.dart';
import '../../../quick_links/presentation/widgets/quick_links_widget.dart';
import '../../../surveys/presentation/widgets/surveys_widget.dart';
import '../../../resale/presentation/widgets/resale_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: false,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            UserTopBar(),
            SizedBox(height: 8),
            QuickLinksWidget(),
            SizedBox(height: 24),
            SurveysWidget(),
            SizedBox(height: 24),
            ResaleWidget(),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
