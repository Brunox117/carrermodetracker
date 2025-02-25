import 'package:isar/isar.dart';

part 'team.g.dart';

@collection
class Team {
  Id id = Isar.autoIncrement;
  String name;

  String acronimos;

  String logoURL;

  Team({
    required this.name,
    required this.acronimos,
    required this.logoURL,
  });
}
