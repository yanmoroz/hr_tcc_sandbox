import 'package:flutter/material.dart';
// File picking is handled by shared FileAttachmentField
import '../../domain/entities/survey_question.dart';
// Local file attachment entity no longer used here
// Removed legacy AppButton usage in favor of shared FileAttachmentField
import '../../../../shared/widgets/radio_group.dart';
import '../../../../shared/widgets/file_attachment_field.dart';

class SurveyQuestionWidget extends StatefulWidget {
  final SurveyQuestion question;
  final int questionNumber;
  final String? answer;
  final ValueChanged<Map<String, dynamic>> onAnswerChanged;

  const SurveyQuestionWidget({
    super.key,
    required this.question,
    required this.questionNumber,
    this.answer,
    required this.onAnswerChanged,
  });

  @override
  State<SurveyQuestionWidget> createState() => _SurveyQuestionWidgetState();
}

class _SurveyQuestionWidgetState extends State<SurveyQuestionWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question title
          Text(
            '${widget.questionNumber}. ${widget.question.title}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          if (widget.question.description != null &&
              widget.question.description!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              widget.question.description!,
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
    return switch (widget.question) {
      TextQuestion() => _buildTextInput(widget.question as TextQuestion),
      MultilineQuestion() => _buildMultilineInput(
        widget.question as MultilineQuestion,
      ),
      SingleSelectQuestion() => _buildSingleSelectInput(
        widget.question as SingleSelectQuestion,
      ),
      FileAttachmentQuestion() => _buildFileAttachmentInput(
        widget.question as FileAttachmentQuestion,
      ),
      _ => _buildTextInput(
        TextQuestion(
          id: widget.question.id,
          title: widget.question.title,
          description: widget.question.description,
          isRequired: widget.question.isRequired,
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
        initialValue: widget.answer,
        onChanged: (value) => widget.onAnswerChanged({'answer': value}),
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
        initialValue: widget.answer,
        onChanged: (value) => widget.onAnswerChanged({'answer': value}),
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
    return RadioGroup<String>(
      label: '',
      value: widget.answer,
      options: question.options
          .map(
            (option) => RadioOption<String>(
              label: option.text,
              value: option.value ?? option.id,
            ),
          )
          .toList(),
      onChanged: (value) {
        widget.onAnswerChanged({'answer': value});
      },
      padding: EdgeInsets.zero,
    );
  }

  Widget _buildFileAttachmentInput(FileAttachmentQuestion question) {
    return FileAttachmentField(
      label: '',
      allowedExtensions: question.allowedExtensions,
      maxFileSizeInMB: question.maxFileSizeInMB,
      onChanged: (file) {
        if (file == null) {
          widget.onAnswerChanged({'answer': ''});
        } else {
          widget.onAnswerChanged({
            'answer': file.fileName,
            'fileResponse': {
              'id': widget.question.id,
              'fileName': file.fileName,
              'filePath': file.filePath,
              'fileSizeInBytes': file.fileSizeInBytes,
              'fileExtension': file.fileExtension,
            },
          });
        }
      },
    );
  }

  // Legacy file pick/preview logic has been replaced by shared FileAttachmentField
}
