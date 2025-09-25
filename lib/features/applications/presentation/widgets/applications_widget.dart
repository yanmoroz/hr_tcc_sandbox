import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_router.dart';
import '../blocs/applications_widget_cubit.dart';

class ApplicationsWidget extends StatefulWidget {
  const ApplicationsWidget({super.key});

  @override
  State<ApplicationsWidget> createState() => _ApplicationsWidgetState();
}

class _ApplicationsWidgetState extends State<ApplicationsWidget> {
  @override
  void initState() {
    super.initState();
    context.read<ApplicationsWidgetCubit>().load();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplicationsWidgetCubit, ApplicationsWidgetState>(
      builder: (context, state) {
        if (state.items.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Заявки',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    for (int i = 0; i < state.items.length; i++) ...[
                      if (i != 0)
                        const Divider(
                          height: 1,
                          thickness: 1,
                          color: Color(0xFFE9EBEF),
                        ),
                      _ApplicationRow(item: state.items[i]),
                    ],
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: Color(0xFFE9EBEF),
                    ),
                    SizedBox(
                      height: 52,
                      child: InkWell(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                        onTap: () => context.push(AppRouter.createApplication),
                        child: const Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.add, color: Color(0xFF12369F)),
                              SizedBox(width: 8),
                              Text(
                                'Создать заявку',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF12369F),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ApplicationRow extends StatelessWidget {
  final ApplicationsWidgetItem item;

  const _ApplicationRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push('/applications/${item.applicationId}'),
      child: SizedBox(
        height: 56,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Icon(item.icon, size: 20, color: Colors.black87),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  item.title,
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: Colors.black38),
            ],
          ),
        ),
      ),
    );
  }
}
