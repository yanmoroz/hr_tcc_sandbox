class FileAttachment {
  final String id;
  final String fileName;
  final String filePath;
  final int fileSizeInBytes;
  final String fileExtension;

  const FileAttachment({
    required this.id,
    required this.fileName,
    required this.filePath,
    required this.fileSizeInBytes,
    required this.fileExtension,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FileAttachment &&
        other.id == id &&
        other.fileName == fileName &&
        other.filePath == filePath &&
        other.fileSizeInBytes == fileSizeInBytes &&
        other.fileExtension == fileExtension;
  }

  @override
  int get hashCode {
    return Object.hash(id, fileName, filePath, fileSizeInBytes, fileExtension);
  }

  @override
  String toString() {
    return 'FileAttachment(id: $id, fileName: $fileName, filePath: $filePath, fileSizeInBytes: $fileSizeInBytes, fileExtension: $fileExtension)';
  }
}
