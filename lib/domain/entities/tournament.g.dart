// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tournament.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTournamentCollection on Isar {
  IsarCollection<Tournament> get tournaments => this.collection();
}

const TournamentSchema = CollectionSchema(
  name: r'Tournament',
  id: 3840673688892599922,
  properties: {
    r'logoURL': PropertySchema(
      id: 0,
      name: r'logoURL',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 1,
      name: r'name',
      type: IsarType.string,
    )
  },
  estimateSize: _tournamentEstimateSize,
  serialize: _tournamentSerialize,
  deserialize: _tournamentDeserialize,
  deserializeProp: _tournamentDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'stats': LinkSchema(
      id: 8089993869696001844,
      name: r'stats',
      target: r'Stats',
      single: false,
      linkName: r'tournament',
    )
  },
  embeddedSchemas: {},
  getId: _tournamentGetId,
  getLinks: _tournamentGetLinks,
  attach: _tournamentAttach,
  version: '3.1.0+1',
);

int _tournamentEstimateSize(
  Tournament object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.logoURL.length * 3;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _tournamentSerialize(
  Tournament object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.logoURL);
  writer.writeString(offsets[1], object.name);
}

Tournament _tournamentDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Tournament(
    logoURL: reader.readStringOrNull(offsets[0]) ?? '',
    name: reader.readString(offsets[1]),
  );
  object.id = id;
  return object;
}

P _tournamentDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _tournamentGetId(Tournament object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _tournamentGetLinks(Tournament object) {
  return [object.stats];
}

void _tournamentAttach(IsarCollection<dynamic> col, Id id, Tournament object) {
  object.id = id;
  object.stats.attach(col, col.isar.collection<Stats>(), r'stats', id);
}

extension TournamentQueryWhereSort
    on QueryBuilder<Tournament, Tournament, QWhere> {
  QueryBuilder<Tournament, Tournament, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TournamentQueryWhere
    on QueryBuilder<Tournament, Tournament, QWhereClause> {
  QueryBuilder<Tournament, Tournament, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Tournament, Tournament, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Tournament, Tournament, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Tournament, Tournament, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Tournament, Tournament, QAfterWhereClause> idBetween(
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

extension TournamentQueryFilter
    on QueryBuilder<Tournament, Tournament, QFilterCondition> {
  QueryBuilder<Tournament, Tournament, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Tournament, Tournament, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Tournament, Tournament, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Tournament, Tournament, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Tournament, Tournament, QAfterFilterCondition> logoURLEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'logoURL',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tournament, Tournament, QAfterFilterCondition>
      logoURLGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'logoURL',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tournament, Tournament, QAfterFilterCondition> logoURLLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'logoURL',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tournament, Tournament, QAfterFilterCondition> logoURLBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'logoURL',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tournament, Tournament, QAfterFilterCondition> logoURLStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'logoURL',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tournament, Tournament, QAfterFilterCondition> logoURLEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'logoURL',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tournament, Tournament, QAfterFilterCondition> logoURLContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'logoURL',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tournament, Tournament, QAfterFilterCondition> logoURLMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'logoURL',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tournament, Tournament, QAfterFilterCondition> logoURLIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'logoURL',
        value: '',
      ));
    });
  }

  QueryBuilder<Tournament, Tournament, QAfterFilterCondition>
      logoURLIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'logoURL',
        value: '',
      ));
    });
  }

  QueryBuilder<Tournament, Tournament, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tournament, Tournament, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tournament, Tournament, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tournament, Tournament, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tournament, Tournament, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tournament, Tournament, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tournament, Tournament, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tournament, Tournament, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tournament, Tournament, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Tournament, Tournament, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }
}

extension TournamentQueryObject
    on QueryBuilder<Tournament, Tournament, QFilterCondition> {}

extension TournamentQueryLinks
    on QueryBuilder<Tournament, Tournament, QFilterCondition> {
  QueryBuilder<Tournament, Tournament, QAfterFilterCondition> stats(
      FilterQuery<Stats> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'stats');
    });
  }

  QueryBuilder<Tournament, Tournament, QAfterFilterCondition>
      statsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'stats', length, true, length, true);
    });
  }

  QueryBuilder<Tournament, Tournament, QAfterFilterCondition> statsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'stats', 0, true, 0, true);
    });
  }

  QueryBuilder<Tournament, Tournament, QAfterFilterCondition>
      statsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'stats', 0, false, 999999, true);
    });
  }

  QueryBuilder<Tournament, Tournament, QAfterFilterCondition>
      statsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'stats', 0, true, length, include);
    });
  }

  QueryBuilder<Tournament, Tournament, QAfterFilterCondition>
      statsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'stats', length, include, 999999, true);
    });
  }

  QueryBuilder<Tournament, Tournament, QAfterFilterCondition>
      statsLengthBetween(
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
}

extension TournamentQuerySortBy
    on QueryBuilder<Tournament, Tournament, QSortBy> {
  QueryBuilder<Tournament, Tournament, QAfterSortBy> sortByLogoURL() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logoURL', Sort.asc);
    });
  }

  QueryBuilder<Tournament, Tournament, QAfterSortBy> sortByLogoURLDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logoURL', Sort.desc);
    });
  }

  QueryBuilder<Tournament, Tournament, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Tournament, Tournament, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension TournamentQuerySortThenBy
    on QueryBuilder<Tournament, Tournament, QSortThenBy> {
  QueryBuilder<Tournament, Tournament, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Tournament, Tournament, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Tournament, Tournament, QAfterSortBy> thenByLogoURL() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logoURL', Sort.asc);
    });
  }

  QueryBuilder<Tournament, Tournament, QAfterSortBy> thenByLogoURLDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logoURL', Sort.desc);
    });
  }

  QueryBuilder<Tournament, Tournament, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Tournament, Tournament, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension TournamentQueryWhereDistinct
    on QueryBuilder<Tournament, Tournament, QDistinct> {
  QueryBuilder<Tournament, Tournament, QDistinct> distinctByLogoURL(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'logoURL', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Tournament, Tournament, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }
}

extension TournamentQueryProperty
    on QueryBuilder<Tournament, Tournament, QQueryProperty> {
  QueryBuilder<Tournament, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Tournament, String, QQueryOperations> logoURLProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'logoURL');
    });
  }

  QueryBuilder<Tournament, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }
}
