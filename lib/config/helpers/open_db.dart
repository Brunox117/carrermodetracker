import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

Future<Isar> openDB(CollectionSchema collectionSchema) async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([collectionSchema], directory: dir.path);
    }
    return Future.value(Isar.getInstance());
  }