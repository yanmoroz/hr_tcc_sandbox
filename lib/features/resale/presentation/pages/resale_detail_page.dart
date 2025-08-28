import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/resale_item.dart';
import '../blocs/resale_bloc.dart';
import '../blocs/resale_event.dart';
import '../blocs/resale_state.dart';
import '../../../auth/presentation/widgets/app_button.dart';
import '../../../../shared/widgets/app_top_bar.dart';

class ResaleDetailPage extends StatefulWidget {
  final String itemId;
  const ResaleDetailPage({super.key, required this.itemId});

  @override
  State<ResaleDetailPage> createState() => _ResaleDetailPageState();
}

class _ResaleDetailPageState extends State<ResaleDetailPage> {
  late ResaleBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.instance<ResaleBloc>();
    _bloc.add(ResaleRequested());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(title: 'Ресейл'),
      body: BlocBuilder<ResaleBloc, ResaleState>(
        bloc: _bloc,
        builder: (context, state) {
          final item = state.allItems.firstWhere(
            (e) => e.id == widget.itemId,
            orElse: () => ResaleItem(
              id: '',
              title: '',
              category: '',
              priceRub: 0,
              ownerName: '',
              updatedAt: DateTime(2000),
              location: '',
              description: '',
              imageUrls: [],
              status: ResaleItemStatus.forSale,
            ),
          );

          if (item.id.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Image.network(
                          item.imageUrls.isNotEmpty
                              ? item.imageUrls.first
                              : 'https://picsum.photos/800/450',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        item.status == ResaleItemStatus.forSale
                                        ? Colors.green[400]
                                        : Colors.orange[400],
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    item.status == ResaleItemStatus.forSale
                                        ? 'В продаже'
                                        : 'Забронировано',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                Text(_formatDate(item.updatedAt)),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              _formatPrice(item.priceRub),
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              item.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildDocTile('Автотека Ауди 380.pdf'),
                            const SizedBox(height: 12),
                            _buildInfoRow('Тип', item.category),
                            _buildInfoRow('Ответственный', item.ownerName),
                            _buildInfoRow('Расположение', item.location),
                            const SizedBox(height: 12),
                            const Text(
                              'Описание',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(item.description),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: AppButton(
                    text: item.status == ResaleItemStatus.booked
                        ? 'Снять бронь'
                        : 'Забронировать',
                    onPressed: () =>
                        _bloc.add(ResaleToggleBooking(widget.itemId)),
                    backgroundColor: const Color(0xFF12369F),
                    textColor: Colors.white,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDocTile(String name) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.description_outlined),
          const SizedBox(width: 8),
          Expanded(child: Text(name)),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: Colors.grey[600])),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  String _formatPrice(int priceRub) {
    final buffer = StringBuffer();
    final str = priceRub.toString();
    for (int i = 0; i < str.length; i++) {
      buffer.write(str[str.length - 1 - i]);
      if ((i + 1) % 3 == 0 && i != str.length - 1) buffer.write(' ');
    }
    final reversed = buffer.toString().split('').reversed.join();
    return '$reversed ₽';
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }
}
