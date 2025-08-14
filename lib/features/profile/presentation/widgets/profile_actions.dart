import 'package:flutter/material.dart';
import '../../domain/entities/profile.dart';

class ProfileActions extends StatelessWidget {
  final Profile profile;

  const ProfileActions({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Действия',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          _buildActionButton(
            context,
            icon: Icons.edit,
            title: 'Редактировать профиль',
            subtitle: 'Изменить личную информацию',
            onTap: () {
              // TODO: Navigate to edit profile page
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Редактирование профиля')),
              );
            },
          ),
          const SizedBox(height: 12),
          _buildActionButton(
            context,
            icon: Icons.photo_camera,
            title: 'Изменить фото',
            subtitle: 'Обновить аватар профиля',
            onTap: () {
              // TODO: Implement photo picker
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Выбор фото')));
            },
          ),
          const SizedBox(height: 12),
          _buildActionButton(
            context,
            icon: Icons.assessment,
            title: 'Мои КПЭ',
            subtitle: 'Просмотр показателей эффективности',
            onTap: () {
              // TODO: Navigate to KPI page
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Переход к КПЭ')));
            },
          ),
          const SizedBox(height: 12),
          _buildActionButton(
            context,
            icon: Icons.settings,
            title: 'Настройки',
            subtitle: 'Настройки приложения',
            onTap: () {
              // TODO: Navigate to settings page
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Настройки')));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[200]!),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: Colors.blue[600], size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}
