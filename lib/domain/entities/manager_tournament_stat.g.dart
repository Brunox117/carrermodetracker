// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manager_tournament_stat.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetManagerTournamentStatCollection on Isar {
  IsarCollection<ManagerTournamentStat> get managerTournamentStats =>
      this.collection();
}

const ManagerTournamentStatSchema = CollectionSchema(
  name: r'ManagerTournamentStat',
  id: 4115115724142051557,
  properties: {
    r'finalPosition': PropertySchema(
      id: 0,
      name: r'finalPosition',
      type: IsarType.string,
    ),
    r'isWinner': PropertySchema(
      id: 1,
      name: r'isWinner',
      type: IsarType.bool,
    )
  },
  estimateSize: _managerTournamentStatEstimateSize,
  serialize: _managerTournamentStatSerialize,
  deserialize: _managerTournamentStatDeserialize,
  deserializeProp: _managerTournamentStatDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'manager': LinkSchema(
      id: -5441884431134089464,
      name: r'manager',
      target: r'Manager',
      single: true,
    ),
    r'season': LinkSchema(
      id: 8471346658323089902,
      name: r'season',
      target: r'Season',
      single: true,
    ),
    r'tournament': LinkSchema(
      id: -5035686776054494242,
      name: r'tournament',
      target: r'Tournament',
      single: true,
    ),
    r'team': LinkSchema(
      id: -48857465036230804,
      name: r'team',
      target: r'Team',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _managerTournamentStatGetId,
  getLinks: _managerTournamentStatGetLinks,
  attach: _managerTournamentStatAttach,
  version: '3.1.0+1',
);

int _managerTournamentStatEstimateSize(
  ManagerTournamentStat object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.finalPosition.length * 3;
  return bytesCount;
}

void _managerTournamentStatSerialize(
  ManagerTournamentStat object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.finalPosition);
  writer.writeBool(offsets[1], object.isWinner);
}

ManagerTournamentStat _managerTournamentStatDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ManagerTournamentStat(
    finalPosition: reader.readString(offsets[0]),
    isWinner: reader.readBool(offsets[1]),
  );
  object.id = id;
  return object;
}

P _managerTournamentStatDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _managerTournamentStatGetId(ManagerTournamentStat object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _managerTournamentStatGetLinks(
    ManagerTournamentStat object) {
  return [object.manager, object.season, object.tournament, object.team];
}

void _managerTournamentStatAttach(
    IsarCollection<dynamic> col, Id id, ManagerTournamentStat object) {
  object.id = id;
  object.manager.attach(col, col.isar.collection<Manager>(), r'manager', id);
  object.season.attach(col, col.isar.collection<Season>(), r'season', id);
  object.tournament
      .attach(col, col.isar.collection<Tournament>(), r'tournament', id);
  object.team.attach(col, col.isar.collection<Team>(), r'team', id);
}

extension ManagerTournamentStatQueryWhereSort
    on QueryBuilder<ManagerTournamentStat, ManagerTournamentStat, QWhere> {
  QueryBuilder<ManagerTournamentStat, ManagerTournamentStat, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ManagerTournamentStatQueryWhere on QueryBuilder<ManagerTournamentStat,
    ManagerTournamentStat, QWhereClause> {
  QueryBuilder<ManagerTournamentStat, ManagerTournamentStat, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ManagerTournamentStat, ManagerTournamentStat, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<ManagerTournamentStat, ManagerTournamentStat, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ManagerTournamentStat, ManagerTournamentStat, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ManagerTournamentStat, ManagerTournamentStat, QAfterWhereClause>
      idBetween(
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

extension ManagerTournamentStatQueryFilter on QueryBuilder<
    ManagerTournamentStat, ManagerTournamentStat, QFilterCondition> {
  QueryBuilder<ManagerTournamentStat, ManagerTournamentStat,
      QAfterFilterCondition> finalPositionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'finalPosition',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ManagerTournamentStat, ManagerTournamentStat,
      QAfterFilterCondition> finalPositionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'finalPosition',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ManagerTournamentStat, ManagerTournamentStat,
      QAfterFilterCondition> finalPositionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'finalPosition',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ManagerTournamentStat, ManagerTournamentStat,
      QAfterFilterCondition> finalPositionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'finalPosition',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ManagerTournamentStat, ManagerTournamentStat,
      QAfterFilterCondition> finalPositionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'finalPosition',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ManagerTournamentStat, ManagerTournamentStat,
      QAfterFilterCondition> finalPositionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'finalPosition',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ManagerTournamentStat, ManagerTournamentStat,
          QAfterFilterCondition>
      finalPositionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'finalPosition',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ManagerTournamentStat, ManagerTournamentStat,
          QAfterFilterCondition>
      finalPositionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'finalPosition',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ManagerTournamentStat, ManagerTournamentStat,
      QAfterFilterCondition> finalPositionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'finalPosition',
        value: '',
      ));
    });
  }

  QueryBuilder<ManagerTournamentStat, ManagerTournamentStat,
      QAfterFilterCondition> finalPositionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'finalPosition',
        value: '',
      ));
    });
  }

  QueryBuilder<ManagerTournamentStat, ManagerTournamentStat,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ManagerTournamentStat, ManagerTournamentStat,
      QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<ManagerTournamentStat, ManagerTournamentStat,
      QAfterFilterCondition> idLessThan(
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

  QueryBuilder<ManagerTournamentStat, ManagerTournamentStat,
      QAfterFilterCondition> idBetween(
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

  QueryBuilder<ManagerTournamentStat, ManagerTournamentStat,
      QAfterFilterCondition> isWinnerEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isWinner',
        value: value,
      ));
    });
  }
}

extension ManagerTournamentStatQueryObject on QueryBuilder<
    ManagerTournamentStat, ManagerTournamentStat, QFilterCondition> {}

extension ManagerTournamentStatQueryLinks on QueryBuilder<ManagerTournamentStat,
    ManagerTournamentStat, QFilterCondition> {
  QueryBuilder<ManagerTournamentStat, ManagerTournamentStat,
      QAfterFilterCondition> manager(FilterQuery<Manager> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'manager');
    });
  }

  QueryBuilder<ManagerTournamentStat, ManagerTournamentStat,
      QAfterFilterCondition> managerIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'manager', 0, true, 0, true);
    });
  }

  QueryBuilder<ManagerTournamentStat, ManagerTournamentStat,
      QAfterFilterCondition> season(FilterQuery<Season> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'season');
    });
  }

  QueryBuilder<ManagerTournamentStat, ManagerTournamentStat,
      QAfterFilterCondition> seasonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'season', 0, true, 0, true);
    });
  }

  QueryBuilder<ManagerTournamentStat, ManagerTournamentStat,
      QAfterFilterCondition> tournament(FilterQuery<Tournament> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'tournament');
    });
  }

  QueryBuilder<ManagerTournamentStat, ManagerTournamentStat,
      QAfterFilterCondition> tournamentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'tournament', 0, true, 0, true);
    });
  }

  QueryBuilder<ManagerTournamentStat, ManagerTournamentStat,
      QAfterFilterCondition> team(FilterQuery<Team> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'team');
    });
  }

  QueryBuilder<ManagerTournamentStat, ManagerTournamentStat,
      QAfterFilterCondition> teamIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'team', 0, true, 0, true);
    });
  }
}

extension ManagerTournamentStatQuerySortBy
    on QueryBuilder<ManagerTournamentStat, ManagerTournamentStat, QSortBy> {
  QueryBuilder<ManagerTournamentStat, ManagerTournamentStat, QAfterSortBy>
      sortByFinalPosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finalPosition', Sort.asc);
    });
  }

  QueryBuilder<ManagerTournamentStat, ManagerTournamentStat, QAfterSortBy>
      sortByFinalPositionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finalPosition', Sort.desc);
    });
  }

  QueryBuilder<ManagerTournamentStat, ManagerTournamentStat, QAfterSortBy>
      sortByIsWinner() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isWinner', Sort.asc);
    });
  }

  QueryBuilder<ManagerTournamentStat, ManagerTournamentStat, QAfterSortBy>
      sortByIsWinnerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isWinner', Sort.desc);
    });
  }
}

extension ManagerTournamentStatQuerySortThenBy
    on QueryBuilder<ManagerTournamentStat, ManagerTournamentStat, QSortThenBy> {
  QueryBuilder<ManagerTournamentStat, ManagerTournamentStat, QAfterSortBy>
      thenByFinalPosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finalPosition', Sort.asc);
    });
  }

  QueryBuilder<ManagerTournamentStat, ManagerTournamentStat, QAfterSortBy>
      thenByFinalPositionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finalPosition', Sort.desc);
    });
  }

  QueryBuilder<ManagerTournamentStat, ManagerTournamentStat, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ManagerTournamentStat, ManagerTournamentStat, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ManagerTournamentStat, ManagerTournamentStat, QAfterSortBy>
      thenByIsWinner() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isWinner', Sort.asc);
    });
  }

  QueryBuilder<ManagerTournamentStat, ManagerTournamentStat, QAfterSortBy>
      thenByIsWinnerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isWinner', Sort.desc);
    });
  }
}

extension ManagerTournamentStatQueryWhereDistinct
    on QueryBuilder<ManagerTournamentStat, ManagerTournamentStat, QDistinct> {
  QueryBuilder<ManagerTournamentStat, ManagerTournamentStat, QDistinct>
      distinctByFinalPosition({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'finalPosition',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ManagerTournamentStat, ManagerTournamentStat, QDistinct>
      distinctByIsWinner() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isWinner');
    });
  }
}

extension ManagerTournamentStatQueryProperty on QueryBuilder<
    ManagerTournamentStat, ManagerTournamentStat, QQueryProperty> {
  QueryBuilder<ManagerTournamentStat, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ManagerTournamentStat, String, QQueryOperations>
      finalPositionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'finalPosition');
    });
  }

  QueryBuilder<ManagerTournamentStat, bool, QQueryOperations>
      isWinnerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isWinner');
    });
  }
}
