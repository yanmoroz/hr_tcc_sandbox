import 'package:flutter/material.dart';
import '../../domain/entities/resale_item.dart';

class ResaleCard extends StatelessWidget {
  final ResaleItem item;
  final VoidCallback? onToggleBooking;
  final VoidCallback? onOpen;

  const ResaleCard({
    super.key,
    required this.item,
    this.onToggleBooking,
    this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    item.imageUrls.isNotEmpty
                        ? item.imageUrls.first
                        : 'https://picsum.photos/200',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _formatPrice(item.priceRub),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.category,
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${item.ownerName}\n${_formatDate(item.updatedAt)}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(onTap: onOpen, child: const SizedBox.shrink()),
          Container(
            margin: const EdgeInsets.all(16),
            child: OutlinedButton.icon(
              onPressed: onToggleBooking,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: BorderSide(color: Colors.grey[400]!),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.lock_outline),
              label: Text(
                item.status == ResaleItemStatus.booked
                    ? 'Снять бронь'
                    : 'Забронировать',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
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
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inDays >= 1) {
      return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year} в ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    }
    return 'Вчера в ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
