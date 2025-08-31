import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class AttachedFileInfo {
  final String fileName;
  final String filePath;
  final int fileSizeInBytes;
  final String fileExtension;

  const AttachedFileInfo({
    required this.fileName,
    required this.filePath,
    required this.fileSizeInBytes,
    required this.fileExtension,
  });
}

class FileAttachmentField extends StatefulWidget {
  final String label;
  final List<String> allowedExtensions;
  final int? maxFileSizeInMB;
  final ValueChanged<AttachedFileInfo?> onChanged;
  final EdgeInsetsGeometry padding;

  const FileAttachmentField({
    super.key,
    required this.label,
    required this.onChanged,
    this.allowedExtensions = const [],
    this.maxFileSizeInMB,
    this.padding = const EdgeInsets.fromLTRB(20, 12, 20, 0),
  });

  @override
  State<FileAttachmentField> createState() => _FileAttachmentFieldState();
}

class _FileAttachmentFieldState extends State<FileAttachmentField> {
  bool _isUploading = false;
  AttachedFileInfo? _file;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          if (_isUploading)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: const [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Загрузка файла...',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            )
          else if (_file != null)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    _getFileIcon(_file!.fileExtension),
                    color: Colors.blue,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _file!.fileName,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          _formatFileSize(_file!.fileSizeInBytes),
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
            )
          else
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.add, color: Colors.black),
                label: const Text(
                  'Добавить файл',
                  style: TextStyle(color: Colors.black),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey[300]!),
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _pickFile,
              ),
            ),
          if (widget.maxFileSizeInMB != null) ...[
            const SizedBox(height: 8),
            Text(
              'Максимальный размер загружаемого файла — ${widget.maxFileSizeInMB} МБ',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _pickFile() async {
    try {
      setState(() => _isUploading = true);
      final result = await FilePicker.platform.pickFiles(
        type: widget.allowedExtensions.isEmpty ? FileType.any : FileType.custom,
        allowedExtensions: widget.allowedExtensions,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        if (widget.maxFileSizeInMB != null) {
          final max = widget.maxFileSizeInMB! * 1024 * 1024;
          if (file.size > max) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Файл слишком большой. Максимальный размер: ${widget.maxFileSizeInMB} МБ',
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            }
            return;
          }
        }

        final info = AttachedFileInfo(
          fileName: file.name,
          filePath: file.path ?? '',
          fileSizeInBytes: file.size,
          fileExtension: file.extension ?? '',
        );
        setState(() => _file = info);
        widget.onChanged(info);
      }
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }

  void _removeFile() {
    setState(() => _file = null);
    widget.onChanged(null);
  }

  IconData _getFileIcon(String ext) {
    switch (ext.toLowerCase()) {
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
