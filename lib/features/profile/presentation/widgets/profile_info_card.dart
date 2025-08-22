import 'package:flutter/material.dart';
import '../../domain/entities/profile.dart';

class ProfileInfoCard extends StatelessWidget {
  final Profile profile;

  const ProfileInfoCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Информация',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            icon: Icons.email,
            label: 'Email',
            value: profile.email,
          ),
          const SizedBox(height: 12),
          _buildInfoRow(
            icon: Icons.phone,
            label: 'Телефон',
            value: profile.phone,
          ),
          const SizedBox(height: 12),
          _buildInfoRow(
            icon: Icons.badge,
            label: 'ID сотрудника',
            value: profile.employeeId,
          ),
          const SizedBox(height: 12),
          _buildInfoRow(
            icon: Icons.calendar_today,
            label: 'Дата приема',
            value: _formatDate(profile.hireDate),
          ),
          const SizedBox(height: 12),
          _buildInfoRow(
            icon: Icons.circle,
            label: 'Статус',
            value: _getStatusText(profile.status),
            valueColor: _getStatusColor(profile.status),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 12, color: Colors.grey[500]),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: valueColor ?? Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }

  String _getStatusText(ProfileStatus status) {
    switch (status) {
      case ProfileStatus.active:
        return 'Активен';
      case ProfileStatus.inactive:
        return 'Неактивен';
      case ProfileStatus.terminated:
        return 'Уволен';
    }
  }

  Color _getStatusColor(ProfileStatus status) {
    switch (status) {
      case ProfileStatus.active:
        return Colors.green;
      case ProfileStatus.inactive:
        return Colors.orange;
      case ProfileStatus.terminated:
        return Colors.red;
    }
  }
}
