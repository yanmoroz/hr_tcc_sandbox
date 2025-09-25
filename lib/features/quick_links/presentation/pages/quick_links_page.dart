import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../blocs/quick_links_bloc.dart';
import '../blocs/quick_links_event.dart';
import '../blocs/quick_links_state.dart';
import '../../../../shared/widgets/app_top_bar.dart';

class QuickLinksPage extends StatefulWidget {
  const QuickLinksPage({super.key});

  @override
  State<QuickLinksPage> createState() => _QuickLinksPageState();
}

class _QuickLinksPageState extends State<QuickLinksPage> {
  @override
  void initState() {
    super.initState();
    context.read<QuickLinksBloc>().add(QuickLinksRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(title: 'Быстрые ссылки'),
      backgroundColor: const Color(0xFFF4F5F7),
      body: SafeArea(
        child: BlocBuilder<QuickLinksBloc, QuickLinksState>(
          builder: (context, state) {
            if (state.isLoading && state.links.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.links.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final link = state.links[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    title: Text(
                      link.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    subtitle: link.subtitle != null
                        ? Text(
                            link.subtitle!,
                            style: const TextStyle(color: Colors.grey),
                          )
                        : null,
                    trailing: SvgPicture.asset(link.pageIconAsset, width: 28),
                    onTap: () {
                      context.read<QuickLinksBloc>().add(
                        QuickLinkOpened(link.url),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
