import 'package:flutter/material.dart';
import '../../domain/entities/profile.dart';

class ProfileHeader extends StatelessWidget {
  final Profile profile;

  const ProfileHeader({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
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
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(profile.avatarUrl),
            onBackgroundImageError: (exception, stackTrace) {
              // Handle image loading error
            },
            child: profile.avatarUrl.isEmpty
                ? Text(
                    profile.fullName.split(' ').map((e) => e[0]).join(''),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )
                : null,
          ),
          const SizedBox(height: 16),
          Text(
            profile.fullName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          _buildContactInfo('${profile.phone} (моб.)'),
          const SizedBox(height: 4),
          _buildContactInfo(
            '${profile.workPhone}, ${profile.workExtension} (раб.)',
          ),
          const SizedBox(height: 4),
          _buildContactInfo(profile.email),
        ],
      ),
    );
  }

  Widget _buildContactInfo(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
      textAlign: TextAlign.center,
    );
  }
}
