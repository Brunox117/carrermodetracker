import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

Future<String> saveImageInLocalStorage(XFile image, String directory) async {
  final Directory appDir = await getApplicationDocumentsDirectory();
  final Directory targetDir = Directory('${appDir.path}/$directory');
  if (!await targetDir.exists()) {
    await targetDir.create(recursive: true);
  }
  String fileName = path.basename(image.path);
  File permanentFile = File('${appDir.path}/$directory/$fileName');
  final bytes = await File(image.path).readAsBytes();
  await permanentFile.writeAsBytes(bytes);
  return permanentFile.path;
}
