// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTeamCollection on Isar {
  IsarCollection<Team> get teams => this.collection();
}

const TeamSchema = CollectionSchema(
  name: r'Team',
  id: -3518492973250071660,
  properties: {
    r'acronimos': PropertySchema(
      id: 0,
      name: r'acronimos',
      type: IsarType.string,
    ),
    r'logoURL': PropertySchema(
      id: 1,
      name: r'logoURL',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 2,
      name: r'name',
      type: IsarType.string,
    )
  },
  estimateSize: _teamEstimateSize,
  serialize: _teamSerialize,
  deserialize: _teamDeserialize,
  deserializeProp: _teamDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {
    r'players': LinkSchema(
      id: 5142083483174173681,
      name: r'players',
      target: r'Player',
      single: false,
      linkName: r'team',
    ),
    r'managerStat': LinkSchema(
      id: -3348137809560674195,
      name: r'managerStat',
      target: r'Managerstat',
      single: false,
      linkName: r'team',
    )
  },
  embeddedSchemas: {},
  getId: _teamGetId,
  getLinks: _teamGetLinks,
  attach: _teamAttach,
  version: '3.1.0+1',
);

int _teamEstimateSize(
  Team object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.acronimos.length * 3;
  bytesCount += 3 + object.logoURL.length * 3;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _teamSerialize(
  Team object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.acronimos);
  writer.writeString(offsets[1], object.logoURL);
  writer.writeString(offsets[2], object.name);
}

Team _teamDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Team(
    acronimos: reader.readString(offsets[0]),
    logoURL: reader.readStringOrNull(offsets[1]) ?? '',
    name: reader.readString(offsets[2]),
  );
  object.id = id;
  return object;
}

P _teamDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 2:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _teamGetId(Team object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _teamGetLinks(Team object) {
  return [object.players, object.managerStat];
}

void _teamAttach(IsarCollection<dynamic> col, Id id, Team object) {
  object.id = id;
  object.players.attach(col, col.isar.collection<Player>(), r'players', id);
  object.managerStat
      .attach(col, col.isar.collection<Managerstat>(), r'managerStat', id);
}

extension TeamQueryWhereSort on QueryBuilder<Team, Team, QWhere> {
  QueryBuilder<Team, Team, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TeamQueryWhere on QueryBuilder<Team, Team, QWhereClause> {
  QueryBuilder<Team, Team, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Team, Team, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Team, Team, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Team, Team, QAfterWhereClause> idBetween(
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

extension TeamQueryFilter on QueryBuilder<Team, Team, QFilterCondition> {
  QueryBuilder<Team, Team, QAfterFilterCondition> acronimosEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'acronimos',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> acronimosGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'acronimos',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> acronimosLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'acronimos',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> acronimosBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'acronimos',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> acronimosStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'acronimos',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> acronimosEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'acronimos',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> acronimosContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'acronimos',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> acronimosMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'acronimos',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> acronimosIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'acronimos',
        value: '',
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> acronimosIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'acronimos',
        value: '',
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Team, Team, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Team, Team, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Team, Team, QAfterFilterCondition> logoURLEqualTo(
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

  QueryBuilder<Team, Team, QAfterFilterCondition> logoURLGreaterThan(
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

  QueryBuilder<Team, Team, QAfterFilterCondition> logoURLLessThan(
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

  QueryBuilder<Team, Team, QAfterFilterCondition> logoURLBetween(
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

  QueryBuilder<Team, Team, QAfterFilterCondition> logoURLStartsWith(
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

  QueryBuilder<Team, Team, QAfterFilterCondition> logoURLEndsWith(
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

  QueryBuilder<Team, Team, QAfterFilterCondition> logoURLContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'logoURL',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> logoURLMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'logoURL',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> logoURLIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'logoURL',
        value: '',
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> logoURLIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'logoURL',
        value: '',
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<Team, Team, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<Team, Team, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<Team, Team, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<Team, Team, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<Team, Team, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<Team, Team, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }
}

extension TeamQueryObject on QueryBuilder<Team, Team, QFilterCondition> {}

extension TeamQueryLinks on QueryBuilder<Team, Team, QFilterCondition> {
  QueryBuilder<Team, Team, QAfterFilterCondition> players(
      FilterQuery<Player> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'players');
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> playersLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'players', length, true, length, true);
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> playersIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'players', 0, true, 0, true);
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> playersIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'players', 0, false, 999999, true);
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> playersLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'players', 0, true, length, include);
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> playersLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'players', length, include, 999999, true);
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> playersLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'players', lower, includeLower, upper, includeUpper);
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> managerStat(
      FilterQuery<Managerstat> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'managerStat');
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> managerStatLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'managerStat', length, true, length, true);
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> managerStatIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'managerStat', 0, true, 0, true);
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> managerStatIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'managerStat', 0, false, 999999, true);
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> managerStatLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'managerStat', 0, true, length, include);
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> managerStatLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'managerStat', length, include, 999999, true);
    });
  }

  QueryBuilder<Team, Team, QAfterFilterCondition> managerStatLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'managerStat', lower, includeLower, upper, includeUpper);
    });
  }
}

extension TeamQuerySortBy on QueryBuilder<Team, Team, QSortBy> {
  QueryBuilder<Team, Team, QAfterSortBy> sortByAcronimos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'acronimos', Sort.asc);
    });
  }

  QueryBuilder<Team, Team, QAfterSortBy> sortByAcronimosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'acronimos', Sort.desc);
    });
  }

  QueryBuilder<Team, Team, QAfterSortBy> sortByLogoURL() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logoURL', Sort.asc);
    });
  }

  QueryBuilder<Team, Team, QAfterSortBy> sortByLogoURLDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logoURL', Sort.desc);
    });
  }

  QueryBuilder<Team, Team, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Team, Team, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension TeamQuerySortThenBy on QueryBuilder<Team, Team, QSortThenBy> {
  QueryBuilder<Team, Team, QAfterSortBy> thenByAcronimos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'acronimos', Sort.asc);
    });
  }

  QueryBuilder<Team, Team, QAfterSortBy> thenByAcronimosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'acronimos', Sort.desc);
    });
  }

  QueryBuilder<Team, Team, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Team, Team, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Team, Team, QAfterSortBy> thenByLogoURL() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logoURL', Sort.asc);
    });
  }

  QueryBuilder<Team, Team, QAfterSortBy> thenByLogoURLDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logoURL', Sort.desc);
    });
  }

  QueryBuilder<Team, Team, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Team, Team, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension TeamQueryWhereDistinct on QueryBuilder<Team, Team, QDistinct> {
  QueryBuilder<Team, Team, QDistinct> distinctByAcronimos(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'acronimos', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Team, Team, QDistinct> distinctByLogoURL(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'logoURL', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Team, Team, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }
}

extension TeamQueryProperty on QueryBuilder<Team, Team, QQueryProperty> {
  QueryBuilder<Team, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Team, String, QQueryOperations> acronimosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'acronimos');
    });
  }

  QueryBuilder<Team, String, QQueryOperations> logoURLProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'logoURL');
    });
  }

  QueryBuilder<Team, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }
}
