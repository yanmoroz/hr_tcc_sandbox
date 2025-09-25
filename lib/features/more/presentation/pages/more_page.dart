import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';

import '../../../../app/router/app_router.dart';
import '../../../../shared/widgets/user_top_bar.dart';
import '../blocs/more_bloc.dart' as more;
import '../blocs/more_event.dart' as more;
import '../blocs/more_state.dart' as more;
import '../../../quick_links/presentation/blocs/quick_links_bloc.dart';
import '../../../quick_links/presentation/blocs/quick_links_state.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<more.MoreBloc>(
      create: (context) =>
          GetIt.instance<more.MoreBloc>()..add(const more.MoreRequested()),
      child: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const UserTopBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          // Aggregate is requested once in provider's create
                          // Нарушения
                          _MoreTile(
                            title: 'Нарушения',
                            subtitle: '1 заявка',
                            onTap: () => _showComingSoon(context),
                          ),
                          const SizedBox(height: 12),
                          // Быстрые ссылки
                          BlocBuilder<QuickLinksBloc, QuickLinksState>(
                            builder: (context, state) {
                              final subtitle = state.links.isNotEmpty
                                  ? state.links
                                        .take(5)
                                        .map((e) => e.title)
                                        .join(', ')
                                  : null;
                              return _MoreTile(
                                title: 'Быстрые ссылки',
                                subtitle: subtitle,
                                onTap: () => context.push(AppRouter.quickLinks),
                              );
                            },
                          ),
                          const SizedBox(height: 12),
                          // Ресейл
                          BlocBuilder<more.MoreBloc, more.MoreState>(
                            buildWhen: (p, n) =>
                                p.resaleItemsTotal != n.resaleItemsTotal,
                            builder: (context, state) {
                              final count = state.resaleItemsTotal;
                              final subtitle = count > 0
                                  ? '${_formatNumber(count)} товаров'
                                  : null;
                              return _MoreTile(
                                title: 'Ресейл',
                                subtitle: subtitle,
                                onTap: () => context.push(AppRouter.resale),
                              );
                            },
                          ),
                          const SizedBox(height: 12),
                          // Опросы (с бейджем с количеством не пройденных)
                          BlocBuilder<more.MoreBloc, more.MoreState>(
                            buildWhen: (p, n) =>
                                p.surveysNotCompletedTotal !=
                                n.surveysNotCompletedTotal,
                            builder: (context, state) {
                              final notCompleted =
                                  state.surveysNotCompletedTotal;
                              return _MoreTile(
                                title: 'Опросы',
                                trailing: notCompleted > 0
                                    ? _Badge(
                                        text: '${notCompleted} не пройдены',
                                        color: const Color(0xFFFF9100),
                                      )
                                    : const Icon(Icons.chevron_right),
                                onTap: () => context.push(AppRouter.surveys),
                              );
                            },
                          ),
                          const SizedBox(height: 12),
                          // Новости
                          _MoreTile(
                            title: 'Новости',
                            trailing: const _Badge(
                              text: '1 новая',
                              color: Color(0xFF2BB673),
                            ),
                            onTap: () => _showComingSoon(context),
                          ),
                          const SizedBox(height: 12),
                          // Льготы и возможности
                          _MoreTile(
                            title: 'Льготы и возможности',
                            subtitle: '8',
                            onTap: () => _showComingSoon(context),
                          ),
                          const SizedBox(height: 12),
                          // Адресная книга
                          BlocBuilder<more.MoreBloc, more.MoreState>(
                            buildWhen: (p, n) =>
                                p.contactsTotal != n.contactsTotal,
                            builder: (context, state) {
                              final subtitle = state.contactsTotal > 0
                                  ? '${_formatNumber(state.contactsTotal)} сотрудников'
                                  : '0 сотрудников';
                              return _MoreTile(
                                title: 'Адресная книга',
                                subtitle: subtitle,
                                onTap: () =>
                                    context.push(AppRouter.addressBook),
                              );
                            },
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Private helpers & widgets ---

void _showComingSoon(BuildContext context) {
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(const SnackBar(content: Text('Раздел скоро появится')));
}

String _formatNumber(int value) {
  final buffer = StringBuffer();
  final str = value.toString();
  for (int i = 0; i < str.length; i++) {
    final reverseIndex = str.length - i;
    buffer.write(str[i]);
    if (reverseIndex > 1 && reverseIndex % 3 == 1) buffer.write(' ');
  }
  return buffer.toString();
}

class _MoreTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback onTap;

  const _MoreTile({
    required this.title,
    this.subtitle,
    this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        subtitle: subtitle != null
            ? Text(subtitle!, style: const TextStyle(color: Colors.grey))
            : null,
        trailing: trailing ?? const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String text;
  final Color color;
  const _Badge({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
