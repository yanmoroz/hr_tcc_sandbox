import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/entities/contact.dart';

enum ContactType { phone, email }

class ContactCard extends StatelessWidget {
  final Contact contact;

  const ContactCard({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar
            _buildAvatar(),
            const SizedBox(width: 12),
            // Contact details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text(
                    contact.fullName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Roles and departments
                  _buildTags(),
                  const SizedBox(height: 8),
                  // Contact information
                  _buildContactInfo(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    if (contact.avatarUrl.isNotEmpty) {
      return CircleAvatar(
        radius: 24,
        backgroundImage: NetworkImage(contact.avatarUrl),
        onBackgroundImageError: (_, __) {},
        backgroundColor: const Color(0xFF12369F),
        child: contact.avatarUrl.isEmpty ? _buildInitials() : null,
      );
    } else {
      return CircleAvatar(
        radius: 24,
        backgroundColor: const Color(0xFF12369F),
        child: _buildInitials(),
      );
    }
  }

  Widget _buildInitials() {
    return Text(
      contact.initials,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontSize: 16,
      ),
    );
  }

  Widget _buildTags() {
    final allTags = [...contact.roles, ...contact.departments];
    if (allTags.isEmpty) return const SizedBox.shrink();

    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: allTags.map((tag) => _buildTag(tag)).toList(),
    );
  }

  Widget _buildTag(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        tag,
        style: TextStyle(
          fontSize: 12,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildContactItem(contact.mobilePhone, 'моб.', ContactType.phone),
        const SizedBox(height: 4),
        _buildContactItem(contact.workPhone, 'раб.', ContactType.phone),
        const SizedBox(height: 4),
        _buildContactItem(contact.email, '', ContactType.email),
      ],
    );
  }

  Widget _buildContactItem(
    String value,
    String suffix,
    ContactType contactType,
  ) {
    final displayText = suffix.isNotEmpty ? '$value ($suffix)' : value;

    return InkWell(
      onTap: () => _launchContact(value, contactType),
      child: Text(
        displayText,
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFF12369F),
          decoration: TextDecoration.underline,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Future<void> _launchContact(String value, ContactType contactType) async {
    String url;

    switch (contactType) {
      case ContactType.phone:
        url = 'tel:$value';
        break;
      case ContactType.email:
        url = 'mailto:$value';
        break;
    }

    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
