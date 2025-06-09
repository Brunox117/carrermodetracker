// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'season.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSeasonCollection on Isar {
  IsarCollection<Season> get seasons => this.collection();
}

const SeasonSchema = CollectionSchema(
  name: r'Season',
  id: 7798637676833157862,
  properties: {
    r'season': PropertySchema(
      id: 0,
      name: r'season',
      type: IsarType.string,
    )
  },
  estimateSize: _seasonEstimateSize,
  serialize: _seasonSerialize,
  deserialize: _seasonDeserialize,
  deserializeProp: _seasonDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'stats': LinkSchema(
      id: 8470696474758764134,
      name: r'stats',
      target: r'Stats',
      single: false,
      linkName: r'season',
    ),
    r'managerStats': LinkSchema(
      id: 4154512830160100978,
      name: r'managerStats',
      target: r'Managerstat',
      single: false,
      linkName: r'season',
    ),
    r'managerTournamentStats': LinkSchema(
      id: -9193073718390741509,
      name: r'managerTournamentStats',
      target: r'ManagerTournamentStat',
      single: false,
      linkName: r'season',
    )
  },
  embeddedSchemas: {},
  getId: _seasonGetId,
  getLinks: _seasonGetLinks,
  attach: _seasonAttach,
  version: '3.1.0+1',
);

int _seasonEstimateSize(
  Season object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.season.length * 3;
  return bytesCount;
}

void _seasonSerialize(
  Season object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.season);
}

Season _seasonDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Season(
    season: reader.readString(offsets[0]),
  );
  object.id = id;
  return object;
}

P _seasonDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _seasonGetId(Season object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _seasonGetLinks(Season object) {
  return [object.stats, object.managerStats, object.managerTournamentStats];
}

void _seasonAttach(IsarCollection<dynamic> col, Id id, Season object) {
  object.id = id;
  object.stats.attach(col, col.isar.collection<Stats>(), r'stats', id);
  object.managerStats
      .attach(col, col.isar.collection<Managerstat>(), r'managerStats', id);
  object.managerTournamentStats.attach(
      col,
      col.isar.collection<ManagerTournamentStat>(),
      r'managerTournamentStats',
      id);
}

extension SeasonQueryWhereSort on QueryBuilder<Season, Season, QWhere> {
  QueryBuilder<Season, Season, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SeasonQueryWhere on QueryBuilder<Season, Season, QWhereClause> {
  QueryBuilder<Season, Season, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Season, Season, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Season, Season, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Season, Season, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Season, Season, QAfterWhereClause> idBetween(
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

extension SeasonQueryFilter on QueryBuilder<Season, Season, QFilterCondition> {
  QueryBuilder<Season, Season, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Season, Season, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Season, Season, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Season, Season, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Season, Season, QAfterFilterCondition> seasonEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'season',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Season, Season, QAfterFilterCondition> seasonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'season',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Season, Season, QAfterFilterCondition> seasonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'season',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Season, Season, QAfterFilterCondition> seasonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'season',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Season, Season, QAfterFilterCondition> seasonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'season',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Season, Season, QAfterFilterCondition> seasonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'season',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Season, Season, QAfterFilterCondition> seasonContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'season',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Season, Season, QAfterFilterCondition> seasonMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'season',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Season, Season, QAfterFilterCondition> seasonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'season',
        value: '',
      ));
    });
  }

  QueryBuilder<Season, Season, QAfterFilterCondition> seasonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'season',
        value: '',
      ));
    });
  }
}

extension SeasonQueryObject on QueryBuilder<Season, Season, QFilterCondition> {}

extension SeasonQueryLinks on QueryBuilder<Season, Season, QFilterCondition> {
  QueryBuilder<Season, Season, QAfterFilterCondition> stats(
      FilterQuery<Stats> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'stats');
    });
  }

  QueryBuilder<Season, Season, QAfterFilterCondition> statsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'stats', length, true, length, true);
    });
  }

  QueryBuilder<Season, Season, QAfterFilterCondition> statsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'stats', 0, true, 0, true);
    });
  }

  QueryBuilder<Season, Season, QAfterFilterCondition> statsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'stats', 0, false, 999999, true);
    });
  }

  QueryBuilder<Season, Season, QAfterFilterCondition> statsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'stats', 0, true, length, include);
    });
  }

  QueryBuilder<Season, Season, QAfterFilterCondition> statsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'stats', length, include, 999999, true);
    });
  }

  QueryBuilder<Season, Season, QAfterFilterCondition> statsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'stats', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<Season, Season, QAfterFilterCondition> managerStats(
      FilterQuery<Managerstat> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'managerStats');
    });
  }

  QueryBuilder<Season, Season, QAfterFilterCondition> managerStatsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'managerStats', length, true, length, true);
    });
  }

  QueryBuilder<Season, Season, QAfterFilterCondition> managerStatsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'managerStats', 0, true, 0, true);
    });
  }

  QueryBuilder<Season, Season, QAfterFilterCondition> managerStatsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'managerStats', 0, false, 999999, true);
    });
  }

  QueryBuilder<Season, Season, QAfterFilterCondition>
      managerStatsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'managerStats', 0, true, length, include);
    });
  }

  QueryBuilder<Season, Season, QAfterFilterCondition>
      managerStatsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'managerStats', length, include, 999999, true);
    });
  }

  QueryBuilder<Season, Season, QAfterFilterCondition> managerStatsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'managerStats', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<Season, Season, QAfterFilterCondition> managerTournamentStats(
      FilterQuery<ManagerTournamentStat> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'managerTournamentStats');
    });
  }

  QueryBuilder<Season, Season, QAfterFilterCondition>
      managerTournamentStatsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'managerTournamentStats', length, true, length, true);
    });
  }

  QueryBuilder<Season, Season, QAfterFilterCondition>
      managerTournamentStatsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'managerTournamentStats', 0, true, 0, true);
    });
  }

  QueryBuilder<Season, Season, QAfterFilterCondition>
      managerTournamentStatsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'managerTournamentStats', 0, false, 999999, true);
    });
  }

  QueryBuilder<Season, Season, QAfterFilterCondition>
      managerTournamentStatsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'managerTournamentStats', 0, true, length, include);
    });
  }

  QueryBuilder<Season, Season, QAfterFilterCondition>
      managerTournamentStatsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'managerTournamentStats', length, include, 999999, true);
    });
  }

  QueryBuilder<Season, Season, QAfterFilterCondition>
      managerTournamentStatsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'managerTournamentStats', lower, includeLower, upper, includeUpper);
    });
  }
}

extension SeasonQuerySortBy on QueryBuilder<Season, Season, QSortBy> {
  QueryBuilder<Season, Season, QAfterSortBy> sortBySeason() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'season', Sort.asc);
    });
  }

  QueryBuilder<Season, Season, QAfterSortBy> sortBySeasonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'season', Sort.desc);
    });
  }
}

extension SeasonQuerySortThenBy on QueryBuilder<Season, Season, QSortThenBy> {
  QueryBuilder<Season, Season, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Season, Season, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Season, Season, QAfterSortBy> thenBySeason() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'season', Sort.asc);
    });
  }

  QueryBuilder<Season, Season, QAfterSortBy> thenBySeasonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'season', Sort.desc);
    });
  }
}

extension SeasonQueryWhereDistinct on QueryBuilder<Season, Season, QDistinct> {
  QueryBuilder<Season, Season, QDistinct> distinctBySeason(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'season', caseSensitive: caseSensitive);
    });
  }
}

extension SeasonQueryProperty on QueryBuilder<Season, Season, QQueryProperty> {
  QueryBuilder<Season, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Season, String, QQueryOperations> seasonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'season');
    });
  }
}
