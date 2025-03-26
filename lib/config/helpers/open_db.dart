import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

Future<Isar> openDB(List<CollectionSchema> schemas) async {
  final dir = await getApplicationDocumentsDirectory();
  if (Isar.instanceNames.isEmpty) {
    return await Isar.open(schemas, directory: dir.path);
  }
  return Future.value(Isar.getInstance());
}
