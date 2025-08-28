import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../../domain/entities/survey_question.dart';
import '../../domain/entities/file_attachment.dart';
import '../../../auth/presentation/widgets/app_button.dart';

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
  bool _isUploading = false;
  FileAttachment? _fileResponse;

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
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F6),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        children: question.options.asMap().entries.map((entry) {
          final index = entry.key;
          final option = entry.value;
          return Column(
            children: [
              _buildOption(option),
              if (index < question.options.length - 1)
                Container(
                  height: 1,
                  color: Colors.white,
                  margin: const EdgeInsets.only(right: 16),
                ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildOption(QuestionOption option) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.only(right: 8),
      child: RadioListTile<String>(
        title: Text(
          option.text,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
        value: option.value ?? option.id,
        groupValue: widget.answer,
        onChanged: (value) {
          if (value != null) {
            widget.onAnswerChanged({'answer': value});
          }
        },
        contentPadding: EdgeInsets.zero,
        controlAffinity: ListTileControlAffinity.trailing,
      ),
    );
  }

  Widget _buildFileAttachmentInput(FileAttachmentQuestion question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_isUploading) ...[
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Загрузка файла...',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
        ] else if (_fileResponse != null) ...[
          // File preview
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  _getFileIcon(_fileResponse!.fileExtension),
                  color: Colors.blue,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _fileResponse!.fileName,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        _formatFileSize(_fileResponse!.fileSizeInBytes),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.red),
                  onPressed: _removeFile,
                ),
              ],
            ),
          ),
        ] else ...[
          // Add file button
          AppButton(
            text: 'Добавить файл',
            onPressed: _pickFile,
            height: 40,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            borderColor: Colors.grey[300],
            borderRadius: 8,
            leading: const Icon(Icons.add, color: Colors.black, size: 20),
            padding: const EdgeInsets.symmetric(horizontal: 16),
          ),
        ],
        if (question.allowedExtensions.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            'Разрешенные форматы: ${question.allowedExtensions.join(', ').toUpperCase()}',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
        if (question.maxFileSizeInMB != null) ...[
          const SizedBox(height: 4),
          Text(
            'Максимальный размер: ${question.maxFileSizeInMB} МБ',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ],
    );
  }

  Future<void> _pickFile() async {
    try {
      setState(() {
        _isUploading = true;
      });

      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions:
            (widget.question as FileAttachmentQuestion).allowedExtensions,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        final maxSizeInBytes =
            (widget.question as FileAttachmentQuestion).maxFileSizeInMB! *
            1024 *
            1024;

        if (file.size > maxSizeInBytes) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Файл слишком большой. Максимальный размер: ${(widget.question as FileAttachmentQuestion).maxFileSizeInMB} МБ',
              ),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        final fileResponse = FileAttachment(
          id: widget.question.id,
          fileName: file.name,
          filePath: file.path ?? '',
          fileSizeInBytes: file.size,
          fileExtension: file.extension ?? '',
        );

        setState(() {
          _fileResponse = fileResponse;
        });

        // Notify parent about the file selection
        widget.onAnswerChanged({
          'answer': fileResponse.fileName,
          'fileResponse': {
            'id': fileResponse.id,
            'fileName': fileResponse.fileName,
            'filePath': fileResponse.filePath,
            'fileSizeInBytes': fileResponse.fileSizeInBytes,
            'fileExtension': fileResponse.fileExtension,
          },
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ошибка при выборе файла: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  void _removeFile() {
    setState(() {
      _fileResponse = null;
    });
    widget.onAnswerChanged({'answer': ''});
  }

  IconData _getFileIcon(String extension) {
    switch (extension.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'doc':
      case 'docx':
        return Icons.description;
      case 'jpg':
      case 'jpeg':
      case 'png':
        return Icons.image;
      default:
        return Icons.insert_drive_file;
    }
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes Б';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} КБ';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} МБ';
  }
}
