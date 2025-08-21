import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/quick_link.dart';
import '../blocs/quick_links_bloc.dart';
import '../blocs/quick_links_event.dart';
import '../blocs/quick_links_state.dart';
import 'quick_link_icon_button.dart';
import '../../../../app/router/app_router.dart';

class QuickLinksWidget extends StatefulWidget {
  const QuickLinksWidget({super.key});

  @override
  State<QuickLinksWidget> createState() => _QuickLinksWidgetState();
}

class _QuickLinksWidgetState extends State<QuickLinksWidget> {
  @override
  void initState() {
    super.initState();
    context.read<QuickLinksBloc>().add(QuickLinksRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuickLinksBloc, QuickLinksState>(
      builder: (context, state) {
        if (state.links.isEmpty) return const SizedBox.shrink();
        final List<QuickLink> links = state.links.take(5).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Быстрые ссылки',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.push(AppRouter.quickLinks),
                    child: const Text('Перейти в раздел'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  for (final link in links)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: QuickLinkIconButton(
                        iconAsset: link.widgetIconAsset,
                        label: link.title,
                        background: Color(link.accentColor),
                        onTap: () {
                          context.read<QuickLinksBloc>().add(
                            QuickLinkOpened(link.url),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
