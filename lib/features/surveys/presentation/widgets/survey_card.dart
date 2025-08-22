import 'package:flutter/material.dart';
import '../../domain/entities/survey.dart';
import '../../../auth/presentation/widgets/app_button.dart';

class SurveyCard extends StatelessWidget {
  final Survey survey;
  final VoidCallback? onTakeSurvey;

  const SurveyCard({super.key, required this.survey, this.onTakeSurvey});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Survey image
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[200],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      survey.imageUrl,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey[300],
                          ),
                          child: const Icon(
                            Icons.image,
                            color: Colors.grey,
                            size: 24,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Survey content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Timestamp
                      Text(
                        survey.timestamp,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Title
                      Text(
                        survey.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      // Description
                      Text(
                        survey.description,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Bottom row with status, count, and action button
            Row(
              children: [
                const SizedBox(width: 72),
                // Status tag
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: survey.status == SurveyStatus.completed
                        ? Colors.grey[200]
                        : const Color(0xFFF5E6D3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    survey.status == SurveyStatus.completed
                        ? 'Пройден'
                        : 'Не пройден',
                    style: TextStyle(
                      fontSize: 12,
                      color: survey.status == SurveyStatus.completed
                          ? Colors.black87
                          : Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Spacer(),
                // Completion count
                Text(
                  'Прошли: ${survey.completionCount}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            // Action button (only for not completed surveys)
            if (survey.status == SurveyStatus.notCompleted &&
                onTakeSurvey != null) ...[
              const SizedBox(height: 12),
              AppButton(
                text: 'Пройти опрос',
                backgroundColor: const Color(0xFF12369F),
                textColor: Colors.white,
                borderRadius: 8,
                onPressed: onTakeSurvey,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
