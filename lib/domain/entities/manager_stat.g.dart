// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manager_stat.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetManagerstatCollection on Isar {
  IsarCollection<Managerstat> get managerstats => this.collection();
}

const ManagerstatSchema = CollectionSchema(
  name: r'Managerstat',
  id: -8409009093126073157,
  properties: {
    r'draws': PropertySchema(
      id: 0,
      name: r'draws',
      type: IsarType.long,
    ),
    r'goals': PropertySchema(
      id: 1,
      name: r'goals',
      type: IsarType.long,
    ),
    r'goalsConceded': PropertySchema(
      id: 2,
      name: r'goalsConceded',
      type: IsarType.long,
    ),
    r'goalsScored': PropertySchema(
      id: 3,
      name: r'goalsScored',
      type: IsarType.long,
    ),
    r'loses': PropertySchema(
      id: 4,
      name: r'loses',
      type: IsarType.long,
    ),
    r'playedMatches': PropertySchema(
      id: 5,
      name: r'playedMatches',
      type: IsarType.long,
    ),
    r'wins': PropertySchema(
      id: 6,
      name: r'wins',
      type: IsarType.long,
    )
  },
  estimateSize: _managerstatEstimateSize,
  serialize: _managerstatSerialize,
  deserialize: _managerstatDeserialize,
  deserializeProp: _managerstatDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'manager': LinkSchema(
      id: 775780426981115782,
      name: r'manager',
      target: r'Manager',
      single: true,
    ),
    r'season': LinkSchema(
      id: 1368376145580267811,
      name: r'season',
      target: r'Season',
      single: true,
    ),
    r'team': LinkSchema(
      id: 5001154445466935197,
      name: r'team',
      target: r'Team',
      single: true,
    ),
    r'tournaments': LinkSchema(
      id: -455222470147635911,
      name: r'tournaments',
      target: r'ManagerTournamentStat',
      single: false,
    )
  },
  embeddedSchemas: {},
  getId: _managerstatGetId,
  getLinks: _managerstatGetLinks,
  attach: _managerstatAttach,
  version: '3.1.0+1',
);

int _managerstatEstimateSize(
  Managerstat object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _managerstatSerialize(
  Managerstat object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.draws);
  writer.writeLong(offsets[1], object.goals);
  writer.writeLong(offsets[2], object.goalsConceded);
  writer.writeLong(offsets[3], object.goalsScored);
  writer.writeLong(offsets[4], object.loses);
  writer.writeLong(offsets[5], object.playedMatches);
  writer.writeLong(offsets[6], object.wins);
}

Managerstat _managerstatDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Managerstat(
    draws: reader.readLong(offsets[0]),
    goals: reader.readLong(offsets[1]),
    goalsConceded: reader.readLong(offsets[2]),
    goalsScored: reader.readLong(offsets[3]),
    loses: reader.readLong(offsets[4]),
    playedMatches: reader.readLong(offsets[5]),
    wins: reader.readLong(offsets[6]),
  );
  object.id = id;
  return object;
}

P _managerstatDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
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

Id _managerstatGetId(Managerstat object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _managerstatGetLinks(Managerstat object) {
  return [object.manager, object.season, object.team, object.tournaments];
}

void _managerstatAttach(
    IsarCollection<dynamic> col, Id id, Managerstat object) {
  object.id = id;
  object.manager.attach(col, col.isar.collection<Manager>(), r'manager', id);
  object.season.attach(col, col.isar.collection<Season>(), r'season', id);
  object.team.attach(col, col.isar.collection<Team>(), r'team', id);
  object.tournaments.attach(
      col, col.isar.collection<ManagerTournamentStat>(), r'tournaments', id);
}

extension ManagerstatQueryWhereSort
    on QueryBuilder<Managerstat, Managerstat, QWhere> {
  QueryBuilder<Managerstat, Managerstat, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ManagerstatQueryWhere
    on QueryBuilder<Managerstat, Managerstat, QWhereClause> {
  QueryBuilder<Managerstat, Managerstat, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<Managerstat, Managerstat, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterWhereClause> idBetween(
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

extension ManagerstatQueryFilter
    on QueryBuilder<Managerstat, Managerstat, QFilterCondition> {
  QueryBuilder<Managerstat, Managerstat, QAfterFilterCondition> drawsEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'draws',
        value: value,
      ));
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterFilterCondition>
      drawsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'draws',
        value: value,
      ));
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterFilterCondition> drawsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'draws',
        value: value,
      ));
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterFilterCondition> drawsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'draws',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterFilterCondition> goalsEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'goals',
        value: value,
      ));
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterFilterCondition>
      goalsGreaterThan(
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

  QueryBuilder<Managerstat, Managerstat, QAfterFilterCondition> goalsLessThan(
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

  QueryBuilder<Managerstat, Managerstat, QAfterFilterCondition> goalsBetween(
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

  QueryBuilder<Managerstat, Managerstat, QAfterFilterCondition>
      goalsConcededEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'goalsConceded',
        value: value,
      ));
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterFilterCondition>
      goalsConcededGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'goalsConceded',
        value: value,
      ));
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterFilterCondition>
      goalsConcededLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'goalsConceded',
        value: value,
      ));
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterFilterCondition>
      goalsConcededBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'goalsConceded',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterFilterCondition>
      goalsScoredEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'goalsScored',
        value: value,
      ));
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterFilterCondition>
      goalsScoredGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'goalsScored',
        value: value,
      ));
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterFilterCondition>
      goalsScoredLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'goalsScored',
        value: value,
      ));
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterFilterCondition>
      goalsScoredBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'goalsScored',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Managerstat, Managerstat, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Managerstat, Managerstat, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Managerstat, Managerstat, QAfterFilterCondition> losesEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'loses',
        value: value,
      ));
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterFilterCondition>
      losesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'loses',
        value: value,
      ));
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterFilterCondition> losesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'loses',
        value: value,
      ));
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterFilterCondition> losesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'loses',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterFilterCondition>
      playedMatchesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'playedMatches',
        value: value,
      ));
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterFilterCondition>
      playedMatchesGreaterThan(
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

  QueryBuilder<Managerstat, Managerstat, QAfterFilterCondition>
      playedMatchesLessThan(
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

  QueryBuilder<Managerstat, Managerstat, QAfterFilterCondition>
      playedMatchesBetween(
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

  QueryBuilder<Managerstat, Managerstat, QAfterFilterCondition> winsEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'wins',
        value: value,
      ));
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterFilterCondition> winsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'wins',
        value: value,
      ));
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterFilterCondition> winsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'wins',
        value: value,
      ));
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterFilterCondition> winsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'wins',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ManagerstatQueryObject
    on QueryBuilder<Managerstat, Managerstat, QFilterCondition> {}

extension ManagerstatQueryLinks
    on QueryBuilder<Managerstat, Managerstat, QFilterCondition> {
  QueryBuilder<Managerstat, Managerstat, QAfterFilterCondition> manager(
      FilterQuery<Manager> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'manager');
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterFilterCondition>
      managerIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'manager', 0, true, 0, true);
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterFilterCondition> season(
      FilterQuery<Season> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'season');
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterFilterCondition> seasonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'season', 0, true, 0, true);
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterFilterCondition> team(
      FilterQuery<Team> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'team');
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterFilterCondition> teamIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'team', 0, true, 0, true);
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterFilterCondition> tournaments(
      FilterQuery<ManagerTournamentStat> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'tournaments');
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterFilterCondition>
      tournamentsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'tournaments', length, true, length, true);
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterFilterCondition>
      tournamentsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'tournaments', 0, true, 0, true);
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterFilterCondition>
      tournamentsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'tournaments', 0, false, 999999, true);
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterFilterCondition>
      tournamentsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'tournaments', 0, true, length, include);
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterFilterCondition>
      tournamentsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'tournaments', length, include, 999999, true);
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterFilterCondition>
      tournamentsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'tournaments', lower, includeLower, upper, includeUpper);
    });
  }
}

extension ManagerstatQuerySortBy
    on QueryBuilder<Managerstat, Managerstat, QSortBy> {
  QueryBuilder<Managerstat, Managerstat, QAfterSortBy> sortByDraws() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'draws', Sort.asc);
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterSortBy> sortByDrawsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'draws', Sort.desc);
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterSortBy> sortByGoals() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goals', Sort.asc);
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterSortBy> sortByGoalsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goals', Sort.desc);
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterSortBy> sortByGoalsConceded() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalsConceded', Sort.asc);
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterSortBy>
      sortByGoalsConcededDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalsConceded', Sort.desc);
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterSortBy> sortByGoalsScored() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalsScored', Sort.asc);
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterSortBy> sortByGoalsScoredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalsScored', Sort.desc);
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterSortBy> sortByLoses() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loses', Sort.asc);
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterSortBy> sortByLosesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loses', Sort.desc);
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterSortBy> sortByPlayedMatches() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playedMatches', Sort.asc);
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterSortBy>
      sortByPlayedMatchesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playedMatches', Sort.desc);
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterSortBy> sortByWins() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wins', Sort.asc);
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterSortBy> sortByWinsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wins', Sort.desc);
    });
  }
}

extension ManagerstatQuerySortThenBy
    on QueryBuilder<Managerstat, Managerstat, QSortThenBy> {
  QueryBuilder<Managerstat, Managerstat, QAfterSortBy> thenByDraws() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'draws', Sort.asc);
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterSortBy> thenByDrawsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'draws', Sort.desc);
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterSortBy> thenByGoals() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goals', Sort.asc);
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterSortBy> thenByGoalsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goals', Sort.desc);
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterSortBy> thenByGoalsConceded() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalsConceded', Sort.asc);
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterSortBy>
      thenByGoalsConcededDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalsConceded', Sort.desc);
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterSortBy> thenByGoalsScored() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalsScored', Sort.asc);
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterSortBy> thenByGoalsScoredDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'goalsScored', Sort.desc);
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterSortBy> thenByLoses() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loses', Sort.asc);
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterSortBy> thenByLosesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'loses', Sort.desc);
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterSortBy> thenByPlayedMatches() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playedMatches', Sort.asc);
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterSortBy>
      thenByPlayedMatchesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playedMatches', Sort.desc);
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterSortBy> thenByWins() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wins', Sort.asc);
    });
  }

  QueryBuilder<Managerstat, Managerstat, QAfterSortBy> thenByWinsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wins', Sort.desc);
    });
  }
}

extension ManagerstatQueryWhereDistinct
    on QueryBuilder<Managerstat, Managerstat, QDistinct> {
  QueryBuilder<Managerstat, Managerstat, QDistinct> distinctByDraws() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'draws');
    });
  }

  QueryBuilder<Managerstat, Managerstat, QDistinct> distinctByGoals() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'goals');
    });
  }

  QueryBuilder<Managerstat, Managerstat, QDistinct> distinctByGoalsConceded() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'goalsConceded');
    });
  }

  QueryBuilder<Managerstat, Managerstat, QDistinct> distinctByGoalsScored() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'goalsScored');
    });
  }

  QueryBuilder<Managerstat, Managerstat, QDistinct> distinctByLoses() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'loses');
    });
  }

  QueryBuilder<Managerstat, Managerstat, QDistinct> distinctByPlayedMatches() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'playedMatches');
    });
  }

  QueryBuilder<Managerstat, Managerstat, QDistinct> distinctByWins() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'wins');
    });
  }
}

extension ManagerstatQueryProperty
    on QueryBuilder<Managerstat, Managerstat, QQueryProperty> {
  QueryBuilder<Managerstat, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Managerstat, int, QQueryOperations> drawsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'draws');
    });
  }

  QueryBuilder<Managerstat, int, QQueryOperations> goalsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'goals');
    });
  }

  QueryBuilder<Managerstat, int, QQueryOperations> goalsConcededProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'goalsConceded');
    });
  }

  QueryBuilder<Managerstat, int, QQueryOperations> goalsScoredProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'goalsScored');
    });
  }

  QueryBuilder<Managerstat, int, QQueryOperations> losesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'loses');
    });
  }

  QueryBuilder<Managerstat, int, QQueryOperations> playedMatchesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'playedMatches');
    });
  }

  QueryBuilder<Managerstat, int, QQueryOperations> winsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'wins');
    });
  }
}
