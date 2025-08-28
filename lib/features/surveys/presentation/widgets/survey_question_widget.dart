import 'package:flutter/material.dart';
import '../../domain/entities/survey_question.dart';

class SurveyQuestionWidget extends StatelessWidget {
  final SurveyQuestion question;
  final String? answer;
  final ValueChanged<String> onAnswerChanged;

  const SurveyQuestionWidget({
    super.key,
    required this.question,
    this.answer,
    required this.onAnswerChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question title
          Text(
            question.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          if (question.description != null &&
              question.description!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              question.description!,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
                height: 1.4,
              ),
            ),
          ],
          const SizedBox(height: 12),
          // Answer input based on question type
          _buildAnswerInput(),
        ],
      ),
    );
  }

  Widget _buildAnswerInput() {
    return switch (question) {
      TextQuestion() => _buildTextInput(question as TextQuestion),
      MultilineQuestion() => _buildMultilineInput(
        question as MultilineQuestion,
      ),
      SingleSelectQuestion() => _buildSingleSelectInput(
        question as SingleSelectQuestion,
      ),
      _ => _buildTextInput(
        TextQuestion(
          id: question.id,
          title: question.title,
          description: question.description,
          isRequired: question.isRequired,
        ),
      ),
    };
  }

  Widget _buildTextInput(TextQuestion question) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        initialValue: answer,
        onChanged: onAnswerChanged,
        maxLines: 1,
        decoration: InputDecoration(
          hintText: question.placeholder ?? 'Ваш ответ',
          hintStyle: const TextStyle(color: Colors.grey),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
        style: const TextStyle(fontSize: 14, color: Colors.black87),
      ),
    );
  }

  Widget _buildMultilineInput(MultilineQuestion question) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        initialValue: answer,
        onChanged: onAnswerChanged,
        maxLines: 4,
        decoration: InputDecoration(
          hintText: question.placeholder ?? 'Ваш ответ',
          hintStyle: const TextStyle(color: Colors.grey),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
        style: const TextStyle(fontSize: 14, color: Colors.black87),
      ),
    );
  }

  Widget _buildSingleSelectInput(SingleSelectQuestion question) {
    return Column(
      children: question.options.map((option) => _buildOption(option)).toList(),
    );
  }

  Widget _buildOption(QuestionOption option) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: RadioListTile<String>(
        title: Text(
          option.text,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
        value: option.value ?? option.id,
        groupValue: answer,
        onChanged: (value) {
          if (value != null) {
            onAnswerChanged(value);
          }
        },
        contentPadding: EdgeInsets.zero,
        controlAffinity: ListTileControlAffinity.trailing,
      ),
    );
  }
}
