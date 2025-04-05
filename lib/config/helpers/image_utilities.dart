import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

Future<String> saveImageInLocalStorage(XFile image, String directory, String imageName) async {
  Directory targetDir;

  if (kDebugMode) {
    // En modo de desarrollo, guarda en un directorio local en la computadora
    const String localPath = '/Users/brunojimenezmancilla/Documents/Progra/Proyectos/carrermodetrackerdevelopmentimages'; // Reemplaza con la ruta deseada en tu computadora
    targetDir = Directory('$localPath/$directory');
  } else {
    // En modo de producción, guarda en el directorio de documentos de la aplicación
    final Directory appDir = await getApplicationDocumentsDirectory();
    targetDir = Directory('${appDir.path}/$directory');
  }

  if (!await targetDir.exists()) {
    await targetDir.create(recursive: true);
  }

  String fileExtension = path.extension(image.path);
  File permanentFile = File('${targetDir.path}/$imageName$fileExtension');
  final bytes = await File(image.path).readAsBytes();
  await permanentFile.writeAsBytes(bytes);
  return permanentFile.path;
}

Future<bool> deleteImage(String imageUrl) async {
  try {
    final file = File(imageUrl);
    if (await file.exists()) {
      await file.delete();
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}