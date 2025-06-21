import 'dart:io';

File? checkIfFileExists(String url) {
  if (url.isNotEmpty) {
    final file = File(url);
    if (file.existsSync()) {
      return file;
    }
  }
  return null;
}
