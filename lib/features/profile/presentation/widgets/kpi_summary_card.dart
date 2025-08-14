import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/profile.dart';
import '../../../../app/router/app_router.dart';

class KpiSummaryCard extends StatelessWidget {
  final Profile profile;

  const KpiSummaryCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'КПЭ',
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
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: InkWell(
            onTap: () => context.push(AppRouter.profileKpi),
            borderRadius: BorderRadius.circular(16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '2 квартал 2025 года',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ),
                Text(
                  '${profile.kpiProgress.toInt()}%',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    value: profile.kpiProgress / 100,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      profile.kpiProgress >= 100
                          ? Colors.green
                          : profile.kpiProgress >= 80
                          ? Colors.blue
                          : profile.kpiProgress >= 60
                          ? Colors.orange
                          : Colors.red,
                    ),
                    strokeWidth: 3,
                  ),
                ),
                const SizedBox(width: 12),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey[400],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
