import 'package:flutter/material.dart';
import '../../domain/entities/news.dart';

class NewsCard extends StatelessWidget {
  final NewsItem item;
  final VoidCallback? onTap;

  const NewsCard({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (item.imageAsset != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  item.imageAsset!,
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                ),
              )
            else
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.article_outlined, color: Colors.grey),
              ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _formatDate(item.publishedAt),
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime dt) {
    final now = DateTime.now();
    if (dt.year == now.year && dt.month == now.month && dt.day == now.day) {
      return 'Сегодня в ${_two(dt.hour)}:${_two(dt.minute)}';
    }
    final yesterday = now.subtract(const Duration(days: 1));
    if (dt.year == yesterday.year &&
        dt.month == yesterday.month &&
        dt.day == yesterday.day) {
      return 'Вчера в ${_two(dt.hour)}:${_two(dt.minute)}';
    }
    return '${_two(dt.day)}.${_two(dt.month)}.${dt.year} в ${_two(dt.hour)}:${_two(dt.minute)}';
  }

  String _two(int v) => v.toString().padLeft(2, '0');
}
