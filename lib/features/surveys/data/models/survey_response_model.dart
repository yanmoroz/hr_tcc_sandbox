import '../../domain/entities/file_attachment.dart';

class SurveyResponseModel {
  final String questionId;
  final String answer;
  final FileAttachment? fileResponse;

  const SurveyResponseModel({
    required this.questionId,
    required this.answer,
    this.fileResponse,
  });

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'answer': answer,
      if (fileResponse != null)
        'fileResponse': _fileResponseToJson(fileResponse!),
    };
  }

  factory SurveyResponseModel.fromJson(Map<String, dynamic> json) {
    return SurveyResponseModel(
      questionId: json['questionId'] as String,
      answer: json['answer'] as String,
      fileResponse: json['fileResponse'] != null
          ? _fileResponseFromJson(json['fileResponse'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> _fileResponseToJson(FileAttachment fileResponse) {
    return {
      'questionId': fileResponse.id,
      'fileName': fileResponse.fileName,
      'filePath': fileResponse.filePath,
      'fileSizeInBytes': fileResponse.fileSizeInBytes,
      'fileExtension': fileResponse.fileExtension,
    };
  }

  static FileAttachment _fileResponseFromJson(Map<String, dynamic> json) {
    return FileAttachment(
      id: json['questionId'] as String,
      fileName: json['fileName'] as String,
      filePath: json['filePath'] as String,
      fileSizeInBytes: json['fileSizeInBytes'] as int,
      fileExtension: json['fileExtension'] as String,
    );
  }
}
