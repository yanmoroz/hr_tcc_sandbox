import 'package:flutter/material.dart';
import '../../domain/entities/profile.dart';

class IncomeCard extends StatelessWidget {
  final Profile profile;

  const IncomeCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Доход',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(20),
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
            children: [
              _buildIncomeRow(
                'Общий доход',
                _formatCurrency(profile.totalIncome),
              ),
              const SizedBox(height: 12),
              _buildIncomeRow(
                'Заработная плата',
                _formatCurrency(profile.salary),
              ),
              const SizedBox(height: 12),
              _buildIncomeRow('Премия', _formatCurrency(profile.bonus)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIncomeRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  String _formatCurrency(double amount) {
    // Format as Russian currency with space as thousands separator
    final formatter = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    final formatted = amount.toInt().toString().replaceAllMapped(
      formatter,
      (Match match) => '${match[1]} ',
    );
    return '$formatted ₽';
  }
}
