import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../blocs/resale_bloc.dart';
import '../blocs/resale_event.dart';
import '../blocs/resale_state.dart';
import '../../domain/entities/resale_item.dart';
import '../../../../app/router/app_router.dart';

class ResaleWidget extends StatefulWidget {
  const ResaleWidget({super.key});

  @override
  State<ResaleWidget> createState() => _ResaleWidgetState();
}

class _ResaleWidgetState extends State<ResaleWidget> {
  @override
  void initState() {
    super.initState();
    context.read<ResaleBloc>().add(ResaleRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResaleBloc, ResaleState>(
      builder: (context, state) {
        if (state.allItems.isEmpty) return const SizedBox.shrink();
        final List<ResaleItem> items = state.allItems.take(2).toList();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Ресейл',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.push(AppRouter.resale),
                    child: const Text('Перейти в раздел'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 190,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return _ResaleTile(item: item);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ResaleTile extends StatelessWidget {
  final ResaleItem item;
  const _ResaleTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('${AppRouter.resaleDetail}/${item.id}'),
      child: SizedBox(
        width: 160,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      item.imageUrls.isNotEmpty
                          ? item.imageUrls.first
                          : 'https://picsum.photos/300',
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green[400],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'В продаже',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              item.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
