import 'package:flutter/material.dart';
import '../../../domain/entities/application.dart';

class ViolationDetailSection extends StatelessWidget {
  final Application application;

  const ViolationDetailSection({super.key, required this.application});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _DetailRow(label: 'Конфиденциальная заявка', value: 'Да'),
        SizedBox(height: 24),
        _DetailRow(label: 'Тема нарушения', value: 'Тема нарушения'),
        SizedBox(height: 24),
        _DetailRow(label: 'Описание нарушения', value: 'Описание нарушения'),
        SizedBox(height: 24),
        _FilesSection(),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ],
    );
  }
}

class _FilesSection extends StatelessWidget {
  const _FilesSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Файлы',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: const [
            _FileCard(extension: 'PDF', name: 'Name doc', sizeMb: 4),
            _FileCard(extension: 'DOCX', name: 'Name doc', sizeMb: 4),
            _FileCard(extension: 'EXE', name: 'Name doc', sizeMb: 4),
            _ImageThumb(name: 'IMG_12343223...'),
            _ImageThumb(name: 'IMG_12343323...'),
            _ImageThumb(name: 'IMG_12343423...'),
          ],
        ),
      ],
    );
  }
}

class _FileCard extends StatelessWidget {
  final String extension;
  final String name;
  final int sizeMb;

  const _FileCard({
    required this.extension,
    required this.name,
    required this.sizeMb,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
              color: const Color(0xFFF2F2F5),
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                extension,
                style: const TextStyle(
                  color: Color(0xFF12369F),
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFE7EDFF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '$sizeMb МБ',
              style: const TextStyle(
                color: Color(0xFF12369F),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}

class _ImageThumb extends StatelessWidget {
  final String name;

  const _ImageThumb({required this.name});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F7F9),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
