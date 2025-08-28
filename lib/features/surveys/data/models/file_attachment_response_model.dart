class FileAttachmentResponseModel {
  final String questionId;
  final String fileName;
  final String filePath;
  final int fileSizeInBytes;
  final String fileExtension;

  const FileAttachmentResponseModel({
    required this.questionId,
    required this.fileName,
    required this.filePath,
    required this.fileSizeInBytes,
    required this.fileExtension,
  });

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'fileName': fileName,
      'filePath': filePath,
      'fileSizeInBytes': fileSizeInBytes,
      'fileExtension': fileExtension,
    };
  }

  factory FileAttachmentResponseModel.fromJson(Map<String, dynamic> json) {
    return FileAttachmentResponseModel(
      questionId: json['questionId'] as String,
      fileName: json['fileName'] as String,
      filePath: json['filePath'] as String,
      fileSizeInBytes: json['fileSizeInBytes'] as int,
      fileExtension: json['fileExtension'] as String,
    );
  }
}
