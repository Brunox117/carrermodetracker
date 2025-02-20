import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Team {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String acronimos;

  @HiveField(2)
  final String logoURL;

  Team({
    required this.name,
    required this.acronimos,
    required this.logoURL,
  });
}
