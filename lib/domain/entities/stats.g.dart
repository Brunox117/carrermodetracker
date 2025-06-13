// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetStatsCollection on Isar {
  IsarCollection<Stats> get stats => this.collection();
}

const StatsSchema = CollectionSchema(
  name: r'Stats',
  id: 6085053765032852394,
  properties: {
    r'assists': PropertySchema(
      id: 0,
      name: r'assists',
      type: IsarType.long,
    ),
    r'avgScore': PropertySchema(
      id: 1,
      name: r'avgScore',
      type: IsarType.double,
    ),
    r'cleanSheets': PropertySchema(
      id: 2,
      name: r'cleanSheets',
      type: IsarType.long,
    ),
    r'goals': PropertySchema(
      id: 3,
      name: r'goals',
      type: IsarType.long,
    ),
    r'playedMatches': PropertySchema(
      id: 4,
      name: r'playedMatches',
      type: IsarType.long,
    ),
    r'redCards': PropertySchema(
      id: 5,
      name: r'redCards',
      type: IsarType.long,
    ),
    r'yellowCards': PropertySchema(
      id: 6,
      name: r'yellowCards',
      type: IsarType.long,
    )
  },
  estimateSize: _statsEstimateSize,
  serialize: _statsSerialize,
  deserialize: _statsDeserialize,
  deserializeProp: _statsDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'season': LinkSchema(
      id: -740389962013262408,
      name: r'season',
      target: r'Season',
      single: true,
    ),
    r'tournament': LinkSchema(
      id: 8826148552003064821,
      name: r'tournament',
      target: r'Tournament',
      single: true,
    ),
    r'player': LinkSchema(
      id: 9114221807394261567,
      name: r'player',
      target: r'Player',
      single: true,
    ),
    r'team': LinkSchema(
      id: 8108567235750698218,
      name: r'team',
      target: r'Team',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _statsGetId,
  getLinks: _statsGetLinks,
  attach: _statsAttach,
  version: '3.1.0+1',
);

int _statsEstimateSize(
  Stats object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _statsSerialize(
  Stats object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.assists);
  writer.writeDouble(offsets[1], object.avgScore);
  writer.writeLong(offsets[2], object.cleanSheets);
  writer.writeLong(offsets[3], object.goals);
  writer.writeLong(offsets[4], object.playedMatches);
  writer.writeLong(offsets[5], object.redCards);
  writer.writeLong(offsets[6], object.yellowCards);
}

Stats _statsDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Stats(
    assists: reader.readLong(offsets[0]),
    avgScore: reader.readDouble(offsets[1]),
    cleanSheets: reader.readLong(offsets[2]),
    goals: reader.readLong(offsets[3]),
    playedMatches: reader.readLong(offsets[4]),
    redCards: reader.readLong(offsets[5]),
    yellowCards: reader.readLong(offsets[6]),
  );
  object.id = id;
  return object;
}

P _statsDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _statsGetId(Stats object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _statsGetLinks(Stats object) {
  return [object.season, object.tournament, object.player, object.team];
}

void _statsAttach(IsarCollection<dynamic> col, Id id, Stats object) {
  object.id = id;
  object.season.attach(col, col.isar.collection<Season>(), r'season', id);
  object.tournament
      .attach(col, col.isar.collection<Tournament>(), r'tournament', id);
  object.player.attach(col, col.isar.collection<Player>(), r'player', id);
  object.team.attach(col, col.isar.collection<Team>(), r'team', id);
}

extension StatsQueryWhereSort on QueryBuilder<Stats, Stats, QWhere> {
  QueryBuilder<Stats, Stats, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension StatsQueryWhere on QueryBuilder<Stats, Stats, QWhereClause> {
  QueryBuilder<Stats, Stats, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Stats, Stats, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Stats, Stats, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Stats, Stats, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Stats, Stats, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension StatsQueryFilter on QueryBuilder<Stats, Stats, QFilterCondition> {
  QueryBuilder<Stats, Stats, QAfterFilterCondition> assistsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'assists',
        value: value,
      ));
    });
  }

  QueryBuilder<Stats, Stats, QAfterFilterCondition> assistsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'assists',
        value: value,
      ));
    });
  }

  QueryBuilder<Stats, Stats, QAfterFilterCondition> assistsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'assists',
        value: value,
      ));
    });
  }

  QueryBuilder<Stats, Stats, QAfterFilterCondition> assistsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'assists',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Stats, Stats, QAfterFilterCondition> avgScoreEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avgScore',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Stats, Stats, QAfterFilterCondition> avgScoreGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'avgScore',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Stats, Stats, QAfterFilterCondition> avgScoreLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'avgScore',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Stats, Stats, QAfterFilterCondition> avgScoreBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'avgScore',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Stats, Stats, QAfterFilterCondition> cleanSheetsEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cleanSheets',
        value: value,
      ));
    });
  }

  QueryBuilder<Stats, Stats, QAfterFilterCondition> cleanSheetsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cleanSheets',
        value: value,
      ));
    });
  }

  QueryBuilder<Stats, Stats, QAfterFilterCondition> cleanSheetsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cleanSheets',
        value: value,
      ));
    });
  }

  QueryBuilder<Stats, Stats, QAfterFilterCondition> cleanSheetsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cleanSheets',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Stats, Stats, QAfterFilterCondition> goalsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'goals',
        value: value,
      ));
    });
  }

  QueryBuilder<Stats, Stats, QAfterFilterCondition> goalsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'goals',
        value: value,
      ));
    });
  }

  QueryBuilder<Stats, Stats, QAfterFilterCondition> goalsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'goals',
        value: value,
      ));
    });
  }

  QueryBuilder<Stats, Stats, QAfterFilterCondition> goalsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'goals',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Stats, Stats, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Stats, Stats, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Stats, Stats, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Stats, Stats, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Stats, Stats, QAfterFilterCondition> playedMatchesEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'playedMatches',
        value: value,
      ));
    });
  }

  QueryBuilder<Stats, Stats, QAfterFilterCondition> playedMatchesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'playedMatches',
        value: value,
      ));
    });
  }

  QueryBuilder<Stats, Stats, QAfterFilterCondition> playedMatchesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'playedMatches',
        value: value,
      ));
    });
  }

  QueryBuilder<Stats, Stats, QAfterFilterCondition> playedMatchesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'playedMatches',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Stats, Stats, QAfterFilterCondition> redCardsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'redCards',
        value: value,
      ));
    });
  }

  QueryBuilder<Stats, Stats, QAfterFilterCondition> redCardsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'redCards',
        value: value,
      ));
    });
  }

  QueryBuilder<Stats, Stats, QAfterFilterCondition> redCardsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'redCards',
        value: value,
      ));
    });
  }

  QueryBuilder<Stats, Stats, QAfterFilterCondition> redCardsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'redCards',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Stats, Stats, QAfterFilterCondition> yellowCardsEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'yellowCards',
        value: value,
      ));
    });
  }

  QueryBuilder<Stats, Stats, QAfterFilterCondition> yellowCardsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'yellowCards',
        value: value,
      ));
    });
  }

  QueryBuilder<Stats, Stats, QAfterFilterCondition> yellowCardsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'yellowCards',
        value: value,
      ));
    });
  }

  QueryBuilder<Stats, Stats, QAfterFilterCondition> yellowCardsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'yellowCards',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension StatsQueryObject on QueryBuilder<Stats, Stats, QFilterCondition> {}

extension StatsQueryLinks on QueryBuilder<Stats, Stats, QFilterCondition> {
  QueryBuilder<Stats, Stats, QAfterFilterCondition> season(
      FilterQuery<Season> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'season');
    });
  }

  QueryBuilder<Stats, Stats, QAfterFilterCondition> seasonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'season', 0, true, 0, true);
    });
  }

  QueryBuilder<Stats, Stats, QAfterFilterCondition> tournament(
      FilterQuery<Tournament> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'tournament');
    });
  }

  QueryBuilder<Stats, Stats, QAfterFilterCondition> tournamentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'tournament', 0, true, 0, true);
    });
  }

  QueryBuilder<Stats, Stats, QAfterFilterCondition> player(
      FilterQuery<Player> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'player');
    });
  }

  QueryBuilder<Stats, Stats, QAfterFilterCondition> playerIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'player', 0, true, 0, true);
    });
  }

  QueryBuilder<Stats, Stats, QAfterFilterCondition> team(FilterQuery<Team> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'team');
    });
  }

  QueryBuilder<Stats, Stats, QAfterFilterCondition> teamIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'team', 0, true, 0, true);
    });
  }
}

extension StatsQuerySortBy on QueryBuilder<Stats, Stats, QSortBy> {
  QueryBuilder<Stats, Stats, QAfterSortBy> sortByAssists() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assists', Sort.asc);
    });
  }

  QueryBuilder<Stats, Stats, QAfterSortBy> sortByAssistsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assists', Sort.desc);
    });
  }

  QueryBuilder<Stats, Stats, QAfterSortBy> sortByAvgScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avgScore', Sort.asc);
    });
  }

  QueryBuilder<Stats, Stats, QAfterSortBy> sortByAvgScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avgScore', Sort.desc);
    });
  }

  QueryBuilder<Stats, Stats, QAfterSortBy> sortByCleanSheets() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cleanSheets', Sort.asc);
    });
  }

  QueryBuilder<Stats, Stats, QAfterSortBy> sortByCleanSheetsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cleanSheets', Sort.desc);
    });
  }

  QueryBuilder<Stats, Stats, QAfterSortBy> sortByGoals() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goals', Sort.asc);
    });
  }

  QueryBuilder<Stats, Stats, QAfterSortBy> sortByGoalsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goals', Sort.desc);
    });
  }

  QueryBuilder<Stats, Stats, QAfterSortBy> sortByPlayedMatches() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playedMatches', Sort.asc);
    });
  }

  QueryBuilder<Stats, Stats, QAfterSortBy> sortByPlayedMatchesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playedMatches', Sort.desc);
    });
  }

  QueryBuilder<Stats, Stats, QAfterSortBy> sortByRedCards() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'redCards', Sort.asc);
    });
  }

  QueryBuilder<Stats, Stats, QAfterSortBy> sortByRedCardsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'redCards', Sort.desc);
    });
  }

  QueryBuilder<Stats, Stats, QAfterSortBy> sortByYellowCards() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'yellowCards', Sort.asc);
    });
  }

  QueryBuilder<Stats, Stats, QAfterSortBy> sortByYellowCardsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'yellowCards', Sort.desc);
    });
  }
}

extension StatsQuerySortThenBy on QueryBuilder<Stats, Stats, QSortThenBy> {
  QueryBuilder<Stats, Stats, QAfterSortBy> thenByAssists() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assists', Sort.asc);
    });
  }

  QueryBuilder<Stats, Stats, QAfterSortBy> thenByAssistsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assists', Sort.desc);
    });
  }

  QueryBuilder<Stats, Stats, QAfterSortBy> thenByAvgScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avgScore', Sort.asc);
    });
  }

  QueryBuilder<Stats, Stats, QAfterSortBy> thenByAvgScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avgScore', Sort.desc);
    });
  }

  QueryBuilder<Stats, Stats, QAfterSortBy> thenByCleanSheets() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cleanSheets', Sort.asc);
    });
  }

  QueryBuilder<Stats, Stats, QAfterSortBy> thenByCleanSheetsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cleanSheets', Sort.desc);
    });
  }

  QueryBuilder<Stats, Stats, QAfterSortBy> thenByGoals() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goals', Sort.asc);
    });
  }

  QueryBuilder<Stats, Stats, QAfterSortBy> thenByGoalsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goals', Sort.desc);
    });
  }

  QueryBuilder<Stats, Stats, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Stats, Stats, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Stats, Stats, QAfterSortBy> thenByPlayedMatches() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playedMatches', Sort.asc);
    });
  }

  QueryBuilder<Stats, Stats, QAfterSortBy> thenByPlayedMatchesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playedMatches', Sort.desc);
    });
  }

  QueryBuilder<Stats, Stats, QAfterSortBy> thenByRedCards() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'redCards', Sort.asc);
    });
  }

  QueryBuilder<Stats, Stats, QAfterSortBy> thenByRedCardsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'redCards', Sort.desc);
    });
  }

  QueryBuilder<Stats, Stats, QAfterSortBy> thenByYellowCards() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'yellowCards', Sort.asc);
    });
  }

  QueryBuilder<Stats, Stats, QAfterSortBy> thenByYellowCardsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'yellowCards', Sort.desc);
    });
  }
}

extension StatsQueryWhereDistinct on QueryBuilder<Stats, Stats, QDistinct> {
  QueryBuilder<Stats, Stats, QDistinct> distinctByAssists() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'assists');
    });
  }

  QueryBuilder<Stats, Stats, QDistinct> distinctByAvgScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'avgScore');
    });
  }

  QueryBuilder<Stats, Stats, QDistinct> distinctByCleanSheets() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cleanSheets');
    });
  }

  QueryBuilder<Stats, Stats, QDistinct> distinctByGoals() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'goals');
    });
  }

  QueryBuilder<Stats, Stats, QDistinct> distinctByPlayedMatches() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'playedMatches');
    });
  }

  QueryBuilder<Stats, Stats, QDistinct> distinctByRedCards() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'redCards');
    });
  }

  QueryBuilder<Stats, Stats, QDistinct> distinctByYellowCards() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'yellowCards');
    });
  }
}

extension StatsQueryProperty on QueryBuilder<Stats, Stats, QQueryProperty> {
  QueryBuilder<Stats, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Stats, int, QQueryOperations> assistsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'assists');
    });
  }

  QueryBuilder<Stats, double, QQueryOperations> avgScoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'avgScore');
    });
  }

  QueryBuilder<Stats, int, QQueryOperations> cleanSheetsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cleanSheets');
    });
  }

  QueryBuilder<Stats, int, QQueryOperations> goalsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'goals');
    });
  }

  QueryBuilder<Stats, int, QQueryOperations> playedMatchesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'playedMatches');
    });
  }

  QueryBuilder<Stats, int, QQueryOperations> redCardsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'redCards');
    });
  }

  QueryBuilder<Stats, int, QQueryOperations> yellowCardsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'yellowCards');
    });
  }
}
