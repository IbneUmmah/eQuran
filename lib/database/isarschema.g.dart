// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isarschema.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetAyahCollection on Isar {
  IsarCollection<Ayah> get ayahs => this.collection();
}

const AyahSchema = CollectionSchema(
  name: r'Ayah',
  id: -4601816037318021044,
  properties: {
    r'ayahWords': PropertySchema(
      id: 0,
      name: r'ayahWords',
      type: IsarType.stringList,
    ),
    r'bookmarked': PropertySchema(
      id: 1,
      name: r'bookmarked',
      type: IsarType.bool,
    ),
    r'chapterNo': PropertySchema(
      id: 2,
      name: r'chapterNo',
      type: IsarType.byte,
    ),
    r'direction': PropertySchema(
      id: 3,
      name: r'direction',
      type: IsarType.string,
    ),
    r'hizbQuarter': PropertySchema(
      id: 4,
      name: r'hizbQuarter',
      type: IsarType.int,
    ),
    r'juz': PropertySchema(
      id: 5,
      name: r'juz',
      type: IsarType.byte,
    ),
    r'language': PropertySchema(
      id: 6,
      name: r'language',
      type: IsarType.string,
    ),
    r'lastRead': PropertySchema(
      id: 7,
      name: r'lastRead',
      type: IsarType.long,
    ),
    r'manzil': PropertySchema(
      id: 8,
      name: r'manzil',
      type: IsarType.byte,
    ),
    r'number': PropertySchema(
      id: 9,
      name: r'number',
      type: IsarType.int,
    ),
    r'numberInSurah': PropertySchema(
      id: 10,
      name: r'numberInSurah',
      type: IsarType.long,
    ),
    r'page': PropertySchema(
      id: 11,
      name: r'page',
      type: IsarType.int,
    ),
    r'ruku': PropertySchema(
      id: 12,
      name: r'ruku',
      type: IsarType.int,
    ),
    r'sajda': PropertySchema(
      id: 13,
      name: r'sajda',
      type: IsarType.string,
    ),
    r'text': PropertySchema(
      id: 14,
      name: r'text',
      type: IsarType.string,
    )
  },
  estimateSize: _ayahEstimateSize,
  serialize: _ayahSerialize,
  deserialize: _ayahDeserialize,
  deserializeProp: _ayahDeserializeProp,
  idName: r'id',
  indexes: {
    r'chapterNo_numberInSurah': IndexSchema(
      id: -1631766102263013596,
      name: r'chapterNo_numberInSurah',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'chapterNo',
          type: IndexType.value,
          caseSensitive: false,
        ),
        IndexPropertySchema(
          name: r'numberInSurah',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'ayahWords': IndexSchema(
      id: 304791918901734812,
      name: r'ayahWords',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'ayahWords',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _ayahGetId,
  getLinks: _ayahGetLinks,
  attach: _ayahAttach,
  version: '3.0.2',
);

int _ayahEstimateSize(
  Ayah object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.ayahWords.length * 3;
  {
    for (var i = 0; i < object.ayahWords.length; i++) {
      final value = object.ayahWords[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.direction.length * 3;
  bytesCount += 3 + object.language.length * 3;
  {
    final value = object.sajda;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.text.length * 3;
  return bytesCount;
}

void _ayahSerialize(
  Ayah object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeStringList(offsets[0], object.ayahWords);
  writer.writeBool(offsets[1], object.bookmarked);
  writer.writeByte(offsets[2], object.chapterNo);
  writer.writeString(offsets[3], object.direction);
  writer.writeInt(offsets[4], object.hizbQuarter);
  writer.writeByte(offsets[5], object.juz);
  writer.writeString(offsets[6], object.language);
  writer.writeLong(offsets[7], object.lastRead);
  writer.writeByte(offsets[8], object.manzil);
  writer.writeInt(offsets[9], object.number);
  writer.writeLong(offsets[10], object.numberInSurah);
  writer.writeInt(offsets[11], object.page);
  writer.writeInt(offsets[12], object.ruku);
  writer.writeString(offsets[13], object.sajda);
  writer.writeString(offsets[14], object.text);
}

Ayah _ayahDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Ayah(
    bookmarked: reader.readBoolOrNull(offsets[1]),
    chapterNo: reader.readByte(offsets[2]),
    direction: reader.readString(offsets[3]),
    hizbQuarter: reader.readInt(offsets[4]),
    id: id,
    juz: reader.readByte(offsets[5]),
    language: reader.readString(offsets[6]),
    lastRead: reader.readLongOrNull(offsets[7]),
    manzil: reader.readByte(offsets[8]),
    number: reader.readInt(offsets[9]),
    numberInSurah: reader.readLong(offsets[10]),
    page: reader.readInt(offsets[11]),
    ruku: reader.readInt(offsets[12]),
    sajda: reader.readStringOrNull(offsets[13]),
    text: reader.readString(offsets[14]),
  );
  return object;
}

P _ayahDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringList(offset) ?? []) as P;
    case 1:
      return (reader.readBoolOrNull(offset)) as P;
    case 2:
      return (reader.readByte(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readInt(offset)) as P;
    case 5:
      return (reader.readByte(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readLongOrNull(offset)) as P;
    case 8:
      return (reader.readByte(offset)) as P;
    case 9:
      return (reader.readInt(offset)) as P;
    case 10:
      return (reader.readLong(offset)) as P;
    case 11:
      return (reader.readInt(offset)) as P;
    case 12:
      return (reader.readInt(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _ayahGetId(Ayah object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _ayahGetLinks(Ayah object) {
  return [];
}

void _ayahAttach(IsarCollection<dynamic> col, Id id, Ayah object) {
  object.id = id;
}

extension AyahQueryWhereSort on QueryBuilder<Ayah, Ayah, QWhere> {
  QueryBuilder<Ayah, Ayah, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterWhere> anyChapterNoNumberInSurah() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'chapterNo_numberInSurah'),
      );
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterWhere> anyAyahWordsElement() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'ayahWords'),
      );
    });
  }
}

extension AyahQueryWhere on QueryBuilder<Ayah, Ayah, QWhereClause> {
  QueryBuilder<Ayah, Ayah, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Ayah, Ayah, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterWhereClause> idBetween(
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

  QueryBuilder<Ayah, Ayah, QAfterWhereClause> chapterNoEqualToAnyNumberInSurah(
      int chapterNo) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'chapterNo_numberInSurah',
        value: [chapterNo],
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterWhereClause>
      chapterNoNotEqualToAnyNumberInSurah(int chapterNo) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'chapterNo_numberInSurah',
              lower: [],
              upper: [chapterNo],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'chapterNo_numberInSurah',
              lower: [chapterNo],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'chapterNo_numberInSurah',
              lower: [chapterNo],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'chapterNo_numberInSurah',
              lower: [],
              upper: [chapterNo],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterWhereClause>
      chapterNoGreaterThanAnyNumberInSurah(
    int chapterNo, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'chapterNo_numberInSurah',
        lower: [chapterNo],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterWhereClause> chapterNoLessThanAnyNumberInSurah(
    int chapterNo, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'chapterNo_numberInSurah',
        lower: [],
        upper: [chapterNo],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterWhereClause> chapterNoBetweenAnyNumberInSurah(
    int lowerChapterNo,
    int upperChapterNo, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'chapterNo_numberInSurah',
        lower: [lowerChapterNo],
        includeLower: includeLower,
        upper: [upperChapterNo],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterWhereClause> chapterNoNumberInSurahEqualTo(
      int chapterNo, int numberInSurah) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'chapterNo_numberInSurah',
        value: [chapterNo, numberInSurah],
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterWhereClause>
      chapterNoEqualToNumberInSurahNotEqualTo(
          int chapterNo, int numberInSurah) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'chapterNo_numberInSurah',
              lower: [chapterNo],
              upper: [chapterNo, numberInSurah],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'chapterNo_numberInSurah',
              lower: [chapterNo, numberInSurah],
              includeLower: false,
              upper: [chapterNo],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'chapterNo_numberInSurah',
              lower: [chapterNo, numberInSurah],
              includeLower: false,
              upper: [chapterNo],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'chapterNo_numberInSurah',
              lower: [chapterNo],
              upper: [chapterNo, numberInSurah],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterWhereClause>
      chapterNoEqualToNumberInSurahGreaterThan(
    int chapterNo,
    int numberInSurah, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'chapterNo_numberInSurah',
        lower: [chapterNo, numberInSurah],
        includeLower: include,
        upper: [chapterNo],
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterWhereClause>
      chapterNoEqualToNumberInSurahLessThan(
    int chapterNo,
    int numberInSurah, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'chapterNo_numberInSurah',
        lower: [chapterNo],
        upper: [chapterNo, numberInSurah],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterWhereClause>
      chapterNoEqualToNumberInSurahBetween(
    int chapterNo,
    int lowerNumberInSurah,
    int upperNumberInSurah, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'chapterNo_numberInSurah',
        lower: [chapterNo, lowerNumberInSurah],
        includeLower: includeLower,
        upper: [chapterNo, upperNumberInSurah],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterWhereClause> ayahWordsElementEqualTo(
      String ayahWordsElement) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'ayahWords',
        value: [ayahWordsElement],
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterWhereClause> ayahWordsElementNotEqualTo(
      String ayahWordsElement) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ayahWords',
              lower: [],
              upper: [ayahWordsElement],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ayahWords',
              lower: [ayahWordsElement],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ayahWords',
              lower: [ayahWordsElement],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'ayahWords',
              lower: [],
              upper: [ayahWordsElement],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterWhereClause> ayahWordsElementGreaterThan(
    String ayahWordsElement, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'ayahWords',
        lower: [ayahWordsElement],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterWhereClause> ayahWordsElementLessThan(
    String ayahWordsElement, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'ayahWords',
        lower: [],
        upper: [ayahWordsElement],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterWhereClause> ayahWordsElementBetween(
    String lowerAyahWordsElement,
    String upperAyahWordsElement, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'ayahWords',
        lower: [lowerAyahWordsElement],
        includeLower: includeLower,
        upper: [upperAyahWordsElement],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterWhereClause> ayahWordsElementStartsWith(
      String AyahWordsElementPrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'ayahWords',
        lower: [AyahWordsElementPrefix],
        upper: ['$AyahWordsElementPrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterWhereClause> ayahWordsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'ayahWords',
        value: [''],
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterWhereClause> ayahWordsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'ayahWords',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'ayahWords',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'ayahWords',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'ayahWords',
              upper: [''],
            ));
      }
    });
  }
}

extension AyahQueryFilter on QueryBuilder<Ayah, Ayah, QFilterCondition> {
  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> ayahWordsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ayahWords',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> ayahWordsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ayahWords',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> ayahWordsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ayahWords',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> ayahWordsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ayahWords',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> ayahWordsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ayahWords',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> ayahWordsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ayahWords',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> ayahWordsElementContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ayahWords',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> ayahWordsElementMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ayahWords',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> ayahWordsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ayahWords',
        value: '',
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> ayahWordsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ayahWords',
        value: '',
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> ayahWordsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ayahWords',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> ayahWordsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ayahWords',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> ayahWordsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ayahWords',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> ayahWordsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ayahWords',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> ayahWordsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ayahWords',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> ayahWordsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ayahWords',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> bookmarkedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'bookmarked',
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> bookmarkedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'bookmarked',
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> bookmarkedEqualTo(
      bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bookmarked',
        value: value,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> chapterNoEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chapterNo',
        value: value,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> chapterNoGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'chapterNo',
        value: value,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> chapterNoLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'chapterNo',
        value: value,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> chapterNoBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'chapterNo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> directionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'direction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> directionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'direction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> directionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'direction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> directionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'direction',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> directionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'direction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> directionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'direction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> directionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'direction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> directionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'direction',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> directionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'direction',
        value: '',
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> directionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'direction',
        value: '',
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> hizbQuarterEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hizbQuarter',
        value: value,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> hizbQuarterGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hizbQuarter',
        value: value,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> hizbQuarterLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hizbQuarter',
        value: value,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> hizbQuarterBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hizbQuarter',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> juzEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'juz',
        value: value,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> juzGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'juz',
        value: value,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> juzLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'juz',
        value: value,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> juzBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'juz',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> languageEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'language',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> languageGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'language',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> languageLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'language',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> languageBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'language',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> languageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'language',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> languageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'language',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> languageContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'language',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> languageMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'language',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> languageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'language',
        value: '',
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> languageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'language',
        value: '',
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> lastReadIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastRead',
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> lastReadIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastRead',
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> lastReadEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastRead',
        value: value,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> lastReadGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastRead',
        value: value,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> lastReadLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastRead',
        value: value,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> lastReadBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastRead',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> manzilEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'manzil',
        value: value,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> manzilGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'manzil',
        value: value,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> manzilLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'manzil',
        value: value,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> manzilBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'manzil',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> numberEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'number',
        value: value,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> numberGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'number',
        value: value,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> numberLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'number',
        value: value,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> numberBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'number',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> numberInSurahEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'numberInSurah',
        value: value,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> numberInSurahGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'numberInSurah',
        value: value,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> numberInSurahLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'numberInSurah',
        value: value,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> numberInSurahBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'numberInSurah',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> pageEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'page',
        value: value,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> pageGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'page',
        value: value,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> pageLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'page',
        value: value,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> pageBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'page',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> rukuEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ruku',
        value: value,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> rukuGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ruku',
        value: value,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> rukuLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ruku',
        value: value,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> rukuBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ruku',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> sajdaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sajda',
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> sajdaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sajda',
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> sajdaEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sajda',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> sajdaGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sajda',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> sajdaLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sajda',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> sajdaBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sajda',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> sajdaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sajda',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> sajdaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sajda',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> sajdaContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sajda',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> sajdaMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sajda',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> sajdaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sajda',
        value: '',
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> sajdaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sajda',
        value: '',
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> textEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> textGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> textLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> textBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'text',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> textStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> textEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> textContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> textMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'text',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> textIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'text',
        value: '',
      ));
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterFilterCondition> textIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'text',
        value: '',
      ));
    });
  }
}

extension AyahQueryObject on QueryBuilder<Ayah, Ayah, QFilterCondition> {}

extension AyahQueryLinks on QueryBuilder<Ayah, Ayah, QFilterCondition> {}

extension AyahQuerySortBy on QueryBuilder<Ayah, Ayah, QSortBy> {
  QueryBuilder<Ayah, Ayah, QAfterSortBy> sortByBookmarked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookmarked', Sort.asc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> sortByBookmarkedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookmarked', Sort.desc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> sortByChapterNo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterNo', Sort.asc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> sortByChapterNoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterNo', Sort.desc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> sortByDirection() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'direction', Sort.asc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> sortByDirectionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'direction', Sort.desc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> sortByHizbQuarter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hizbQuarter', Sort.asc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> sortByHizbQuarterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hizbQuarter', Sort.desc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> sortByJuz() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'juz', Sort.asc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> sortByJuzDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'juz', Sort.desc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> sortByLanguage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'language', Sort.asc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> sortByLanguageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'language', Sort.desc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> sortByLastRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastRead', Sort.asc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> sortByLastReadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastRead', Sort.desc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> sortByManzil() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'manzil', Sort.asc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> sortByManzilDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'manzil', Sort.desc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> sortByNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'number', Sort.asc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> sortByNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'number', Sort.desc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> sortByNumberInSurah() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numberInSurah', Sort.asc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> sortByNumberInSurahDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numberInSurah', Sort.desc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> sortByPage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'page', Sort.asc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> sortByPageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'page', Sort.desc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> sortByRuku() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ruku', Sort.asc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> sortByRukuDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ruku', Sort.desc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> sortBySajda() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sajda', Sort.asc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> sortBySajdaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sajda', Sort.desc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> sortByText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.asc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> sortByTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.desc);
    });
  }
}

extension AyahQuerySortThenBy on QueryBuilder<Ayah, Ayah, QSortThenBy> {
  QueryBuilder<Ayah, Ayah, QAfterSortBy> thenByBookmarked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookmarked', Sort.asc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> thenByBookmarkedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookmarked', Sort.desc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> thenByChapterNo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterNo', Sort.asc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> thenByChapterNoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterNo', Sort.desc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> thenByDirection() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'direction', Sort.asc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> thenByDirectionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'direction', Sort.desc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> thenByHizbQuarter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hizbQuarter', Sort.asc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> thenByHizbQuarterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hizbQuarter', Sort.desc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> thenByJuz() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'juz', Sort.asc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> thenByJuzDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'juz', Sort.desc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> thenByLanguage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'language', Sort.asc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> thenByLanguageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'language', Sort.desc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> thenByLastRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastRead', Sort.asc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> thenByLastReadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastRead', Sort.desc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> thenByManzil() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'manzil', Sort.asc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> thenByManzilDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'manzil', Sort.desc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> thenByNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'number', Sort.asc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> thenByNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'number', Sort.desc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> thenByNumberInSurah() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numberInSurah', Sort.asc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> thenByNumberInSurahDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numberInSurah', Sort.desc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> thenByPage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'page', Sort.asc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> thenByPageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'page', Sort.desc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> thenByRuku() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ruku', Sort.asc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> thenByRukuDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ruku', Sort.desc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> thenBySajda() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sajda', Sort.asc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> thenBySajdaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sajda', Sort.desc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> thenByText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.asc);
    });
  }

  QueryBuilder<Ayah, Ayah, QAfterSortBy> thenByTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.desc);
    });
  }
}

extension AyahQueryWhereDistinct on QueryBuilder<Ayah, Ayah, QDistinct> {
  QueryBuilder<Ayah, Ayah, QDistinct> distinctByAyahWords() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ayahWords');
    });
  }

  QueryBuilder<Ayah, Ayah, QDistinct> distinctByBookmarked() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bookmarked');
    });
  }

  QueryBuilder<Ayah, Ayah, QDistinct> distinctByChapterNo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'chapterNo');
    });
  }

  QueryBuilder<Ayah, Ayah, QDistinct> distinctByDirection(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'direction', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ayah, Ayah, QDistinct> distinctByHizbQuarter() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hizbQuarter');
    });
  }

  QueryBuilder<Ayah, Ayah, QDistinct> distinctByJuz() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'juz');
    });
  }

  QueryBuilder<Ayah, Ayah, QDistinct> distinctByLanguage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'language', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ayah, Ayah, QDistinct> distinctByLastRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastRead');
    });
  }

  QueryBuilder<Ayah, Ayah, QDistinct> distinctByManzil() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'manzil');
    });
  }

  QueryBuilder<Ayah, Ayah, QDistinct> distinctByNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'number');
    });
  }

  QueryBuilder<Ayah, Ayah, QDistinct> distinctByNumberInSurah() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'numberInSurah');
    });
  }

  QueryBuilder<Ayah, Ayah, QDistinct> distinctByPage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'page');
    });
  }

  QueryBuilder<Ayah, Ayah, QDistinct> distinctByRuku() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ruku');
    });
  }

  QueryBuilder<Ayah, Ayah, QDistinct> distinctBySajda(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sajda', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Ayah, Ayah, QDistinct> distinctByText(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'text', caseSensitive: caseSensitive);
    });
  }
}

extension AyahQueryProperty on QueryBuilder<Ayah, Ayah, QQueryProperty> {
  QueryBuilder<Ayah, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Ayah, List<String>, QQueryOperations> ayahWordsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ayahWords');
    });
  }

  QueryBuilder<Ayah, bool?, QQueryOperations> bookmarkedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bookmarked');
    });
  }

  QueryBuilder<Ayah, int, QQueryOperations> chapterNoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'chapterNo');
    });
  }

  QueryBuilder<Ayah, String, QQueryOperations> directionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'direction');
    });
  }

  QueryBuilder<Ayah, int, QQueryOperations> hizbQuarterProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hizbQuarter');
    });
  }

  QueryBuilder<Ayah, int, QQueryOperations> juzProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'juz');
    });
  }

  QueryBuilder<Ayah, String, QQueryOperations> languageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'language');
    });
  }

  QueryBuilder<Ayah, int?, QQueryOperations> lastReadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastRead');
    });
  }

  QueryBuilder<Ayah, int, QQueryOperations> manzilProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'manzil');
    });
  }

  QueryBuilder<Ayah, int, QQueryOperations> numberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'number');
    });
  }

  QueryBuilder<Ayah, int, QQueryOperations> numberInSurahProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'numberInSurah');
    });
  }

  QueryBuilder<Ayah, int, QQueryOperations> pageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'page');
    });
  }

  QueryBuilder<Ayah, int, QQueryOperations> rukuProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ruku');
    });
  }

  QueryBuilder<Ayah, String?, QQueryOperations> sajdaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sajda');
    });
  }

  QueryBuilder<Ayah, String, QQueryOperations> textProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'text');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetSurahCollection on Isar {
  IsarCollection<Surah> get surahs => this.collection();
}

const SurahSchema = CollectionSchema(
  name: r'Surah',
  id: -5819800798527960797,
  properties: {
    r'bookmarked': PropertySchema(
      id: 0,
      name: r'bookmarked',
      type: IsarType.bool,
    ),
    r'currentDuration': PropertySchema(
      id: 1,
      name: r'currentDuration',
      type: IsarType.int,
    ),
    r'englishName': PropertySchema(
      id: 2,
      name: r'englishName',
      type: IsarType.string,
    ),
    r'englishNameTranslation': PropertySchema(
      id: 3,
      name: r'englishNameTranslation',
      type: IsarType.string,
    ),
    r'isReciting': PropertySchema(
      id: 4,
      name: r'isReciting',
      type: IsarType.bool,
    ),
    r'lastRead': PropertySchema(
      id: 5,
      name: r'lastRead',
      type: IsarType.long,
    ),
    r'lastRecited': PropertySchema(
      id: 6,
      name: r'lastRecited',
      type: IsarType.long,
    ),
    r'name': PropertySchema(
      id: 7,
      name: r'name',
      type: IsarType.string,
    ),
    r'number': PropertySchema(
      id: 8,
      name: r'number',
      type: IsarType.byte,
    ),
    r'numberOfAyahs': PropertySchema(
      id: 9,
      name: r'numberOfAyahs',
      type: IsarType.int,
    ),
    r'revelationType': PropertySchema(
      id: 10,
      name: r'revelationType',
      type: IsarType.string,
    ),
    r'totalDuration': PropertySchema(
      id: 11,
      name: r'totalDuration',
      type: IsarType.int,
    )
  },
  estimateSize: _surahEstimateSize,
  serialize: _surahSerialize,
  deserialize: _surahDeserialize,
  deserializeProp: _surahDeserializeProp,
  idName: r'id',
  indexes: {
    r'number': IndexSchema(
      id: 5012388430481709372,
      name: r'number',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'number',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _surahGetId,
  getLinks: _surahGetLinks,
  attach: _surahAttach,
  version: '3.0.2',
);

int _surahEstimateSize(
  Surah object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.englishName.length * 3;
  bytesCount += 3 + object.englishNameTranslation.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.revelationType.length * 3;
  return bytesCount;
}

void _surahSerialize(
  Surah object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.bookmarked);
  writer.writeInt(offsets[1], object.currentDuration);
  writer.writeString(offsets[2], object.englishName);
  writer.writeString(offsets[3], object.englishNameTranslation);
  writer.writeBool(offsets[4], object.isReciting);
  writer.writeLong(offsets[5], object.lastRead);
  writer.writeLong(offsets[6], object.lastRecited);
  writer.writeString(offsets[7], object.name);
  writer.writeByte(offsets[8], object.number);
  writer.writeInt(offsets[9], object.numberOfAyahs);
  writer.writeString(offsets[10], object.revelationType);
  writer.writeInt(offsets[11], object.totalDuration);
}

Surah _surahDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Surah(
    bookmarked: reader.readBoolOrNull(offsets[0]),
    currentDuration: reader.readIntOrNull(offsets[1]),
    englishName: reader.readString(offsets[2]),
    englishNameTranslation: reader.readString(offsets[3]),
    id: id,
    isReciting: reader.readBoolOrNull(offsets[4]),
    lastRead: reader.readLongOrNull(offsets[5]),
    lastRecited: reader.readLongOrNull(offsets[6]),
    name: reader.readString(offsets[7]),
    number: reader.readByte(offsets[8]),
    numberOfAyahs: reader.readInt(offsets[9]),
    revelationType: reader.readString(offsets[10]),
    totalDuration: reader.readIntOrNull(offsets[11]),
  );
  return object;
}

P _surahDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBoolOrNull(offset)) as P;
    case 1:
      return (reader.readIntOrNull(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readBoolOrNull(offset)) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    case 6:
      return (reader.readLongOrNull(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readByte(offset)) as P;
    case 9:
      return (reader.readInt(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readIntOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _surahGetId(Surah object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _surahGetLinks(Surah object) {
  return [];
}

void _surahAttach(IsarCollection<dynamic> col, Id id, Surah object) {
  object.id = id;
}

extension SurahQueryWhereSort on QueryBuilder<Surah, Surah, QWhere> {
  QueryBuilder<Surah, Surah, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Surah, Surah, QAfterWhere> anyNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'number'),
      );
    });
  }
}

extension SurahQueryWhere on QueryBuilder<Surah, Surah, QWhereClause> {
  QueryBuilder<Surah, Surah, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Surah, Surah, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Surah, Surah, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Surah, Surah, QAfterWhereClause> idBetween(
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

  QueryBuilder<Surah, Surah, QAfterWhereClause> numberEqualTo(int number) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'number',
        value: [number],
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterWhereClause> numberNotEqualTo(int number) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'number',
              lower: [],
              upper: [number],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'number',
              lower: [number],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'number',
              lower: [number],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'number',
              lower: [],
              upper: [number],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Surah, Surah, QAfterWhereClause> numberGreaterThan(
    int number, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'number',
        lower: [number],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterWhereClause> numberLessThan(
    int number, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'number',
        lower: [],
        upper: [number],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterWhereClause> numberBetween(
    int lowerNumber,
    int upperNumber, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'number',
        lower: [lowerNumber],
        includeLower: includeLower,
        upper: [upperNumber],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SurahQueryFilter on QueryBuilder<Surah, Surah, QFilterCondition> {
  QueryBuilder<Surah, Surah, QAfterFilterCondition> bookmarkedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'bookmarked',
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> bookmarkedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'bookmarked',
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> bookmarkedEqualTo(
      bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bookmarked',
        value: value,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> currentDurationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'currentDuration',
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> currentDurationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'currentDuration',
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> currentDurationEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentDuration',
        value: value,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> currentDurationGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentDuration',
        value: value,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> currentDurationLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentDuration',
        value: value,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> currentDurationBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentDuration',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> englishNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'englishName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> englishNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'englishName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> englishNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'englishName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> englishNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'englishName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> englishNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'englishName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> englishNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'englishName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> englishNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'englishName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> englishNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'englishName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> englishNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'englishName',
        value: '',
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> englishNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'englishName',
        value: '',
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition>
      englishNameTranslationEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'englishNameTranslation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition>
      englishNameTranslationGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'englishNameTranslation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition>
      englishNameTranslationLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'englishNameTranslation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition>
      englishNameTranslationBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'englishNameTranslation',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition>
      englishNameTranslationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'englishNameTranslation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition>
      englishNameTranslationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'englishNameTranslation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition>
      englishNameTranslationContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'englishNameTranslation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition>
      englishNameTranslationMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'englishNameTranslation',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition>
      englishNameTranslationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'englishNameTranslation',
        value: '',
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition>
      englishNameTranslationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'englishNameTranslation',
        value: '',
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Surah, Surah, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Surah, Surah, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Surah, Surah, QAfterFilterCondition> isRecitingIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'isReciting',
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> isRecitingIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'isReciting',
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> isRecitingEqualTo(
      bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isReciting',
        value: value,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> lastReadIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastRead',
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> lastReadIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastRead',
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> lastReadEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastRead',
        value: value,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> lastReadGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastRead',
        value: value,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> lastReadLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastRead',
        value: value,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> lastReadBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastRead',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> lastRecitedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastRecited',
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> lastRecitedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastRecited',
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> lastRecitedEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastRecited',
        value: value,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> lastRecitedGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastRecited',
        value: value,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> lastRecitedLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastRecited',
        value: value,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> lastRecitedBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastRecited',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<Surah, Surah, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<Surah, Surah, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<Surah, Surah, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<Surah, Surah, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<Surah, Surah, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<Surah, Surah, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> numberEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'number',
        value: value,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> numberGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'number',
        value: value,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> numberLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'number',
        value: value,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> numberBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'number',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> numberOfAyahsEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'numberOfAyahs',
        value: value,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> numberOfAyahsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'numberOfAyahs',
        value: value,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> numberOfAyahsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'numberOfAyahs',
        value: value,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> numberOfAyahsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'numberOfAyahs',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> revelationTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'revelationType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> revelationTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'revelationType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> revelationTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'revelationType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> revelationTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'revelationType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> revelationTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'revelationType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> revelationTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'revelationType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> revelationTypeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'revelationType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> revelationTypeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'revelationType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> revelationTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'revelationType',
        value: '',
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> revelationTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'revelationType',
        value: '',
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> totalDurationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'totalDuration',
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> totalDurationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'totalDuration',
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> totalDurationEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalDuration',
        value: value,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> totalDurationGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalDuration',
        value: value,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> totalDurationLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalDuration',
        value: value,
      ));
    });
  }

  QueryBuilder<Surah, Surah, QAfterFilterCondition> totalDurationBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalDuration',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SurahQueryObject on QueryBuilder<Surah, Surah, QFilterCondition> {}

extension SurahQueryLinks on QueryBuilder<Surah, Surah, QFilterCondition> {}

extension SurahQuerySortBy on QueryBuilder<Surah, Surah, QSortBy> {
  QueryBuilder<Surah, Surah, QAfterSortBy> sortByBookmarked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookmarked', Sort.asc);
    });
  }

  QueryBuilder<Surah, Surah, QAfterSortBy> sortByBookmarkedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookmarked', Sort.desc);
    });
  }

  QueryBuilder<Surah, Surah, QAfterSortBy> sortByCurrentDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentDuration', Sort.asc);
    });
  }

  QueryBuilder<Surah, Surah, QAfterSortBy> sortByCurrentDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentDuration', Sort.desc);
    });
  }

  QueryBuilder<Surah, Surah, QAfterSortBy> sortByEnglishName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'englishName', Sort.asc);
    });
  }

  QueryBuilder<Surah, Surah, QAfterSortBy> sortByEnglishNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'englishName', Sort.desc);
    });
  }

  QueryBuilder<Surah, Surah, QAfterSortBy> sortByEnglishNameTranslation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'englishNameTranslation', Sort.asc);
    });
  }

  QueryBuilder<Surah, Surah, QAfterSortBy> sortByEnglishNameTranslationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'englishNameTranslation', Sort.desc);
    });
  }

  QueryBuilder<Surah, Surah, QAfterSortBy> sortByIsReciting() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isReciting', Sort.asc);
    });
  }

  QueryBuilder<Surah, Surah, QAfterSortBy> sortByIsRecitingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isReciting', Sort.desc);
    });
  }

  QueryBuilder<Surah, Surah, QAfterSortBy> sortByLastRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastRead', Sort.asc);
    });
  }

  QueryBuilder<Surah, Surah, QAfterSortBy> sortByLastReadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastRead', Sort.desc);
    });
  }

  QueryBuilder<Surah, Surah, QAfterSortBy> sortByLastRecited() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastRecited', Sort.asc);
    });
  }

  QueryBuilder<Surah, Surah, QAfterSortBy> sortByLastRecitedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastRecited', Sort.desc);
    });
  }

  QueryBuilder<Surah, Surah, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Surah, Surah, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Surah, Surah, QAfterSortBy> sortByNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'number', Sort.asc);
    });
  }

  QueryBuilder<Surah, Surah, QAfterSortBy> sortByNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'number', Sort.desc);
    });
  }

  QueryBuilder<Surah, Surah, QAfterSortBy> sortByNumberOfAyahs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numberOfAyahs', Sort.asc);
    });
  }

  QueryBuilder<Surah, Surah, QAfterSortBy> sortByNumberOfAyahsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numberOfAyahs', Sort.desc);
    });
  }

  QueryBuilder<Surah, Surah, QAfterSortBy> sortByRevelationType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'revelationType', Sort.asc);
    });
  }

  QueryBuilder<Surah, Surah, QAfterSortBy> sortByRevelationTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'revelationType', Sort.desc);
    });
  }

  QueryBuilder<Surah, Surah, QAfterSortBy> sortByTotalDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalDuration', Sort.asc);
    });
  }

  QueryBuilder<Surah, Surah, QAfterSortBy> sortByTotalDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalDuration', Sort.desc);
    });
  }
}

extension SurahQuerySortThenBy on QueryBuilder<Surah, Surah, QSortThenBy> {
  QueryBuilder<Surah, Surah, QAfterSortBy> thenByBookmarked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookmarked', Sort.asc);
    });
  }

  QueryBuilder<Surah, Surah, QAfterSortBy> thenByBookmarkedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookmarked', Sort.desc);
    });
  }

  QueryBuilder<Surah, Surah, QAfterSortBy> thenByCurrentDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentDuration', Sort.asc);
    });
  }

  QueryBuilder<Surah, Surah, QAfterSortBy> thenByCurrentDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentDuration', Sort.desc);
    });
  }

  QueryBuilder<Surah, Surah, QAfterSortBy> thenByEnglishName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'englishName', Sort.asc);
    });
  }

  QueryBuilder<Surah, Surah, QAfterSortBy> thenByEnglishNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'englishName', Sort.desc);
    });
  }

  QueryBuilder<Surah, Surah, QAfterSortBy> thenByEnglishNameTranslation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'englishNameTranslation', Sort.asc);
    });
  }

  QueryBuilder<Surah, Surah, QAfterSortBy> thenByEnglishNameTranslationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'englishNameTranslation', Sort.desc);
    });
  }

  QueryBuilder<Surah, Surah, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Surah, Surah, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Surah, Surah, QAfterSortBy> thenByIsReciting() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isReciting', Sort.asc);
    });
  }

  QueryBuilder<Surah, Surah, QAfterSortBy> thenByIsRecitingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isReciting', Sort.desc);
    });
  }

  QueryBuilder<Surah, Surah, QAfterSortBy> thenByLastRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastRead', Sort.asc);
    });
  }

  QueryBuilder<Surah, Surah, QAfterSortBy> thenByLastReadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastRead', Sort.desc);
    });
  }

  QueryBuilder<Surah, Surah, QAfterSortBy> thenByLastRecited() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastRecited', Sort.asc);
    });
  }

  QueryBuilder<Surah, Surah, QAfterSortBy> thenByLastRecitedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastRecited', Sort.desc);
    });
  }

  QueryBuilder<Surah, Surah, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Surah, Surah, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Surah, Surah, QAfterSortBy> thenByNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'number', Sort.asc);
    });
  }

  QueryBuilder<Surah, Surah, QAfterSortBy> thenByNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'number', Sort.desc);
    });
  }

  QueryBuilder<Surah, Surah, QAfterSortBy> thenByNumberOfAyahs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numberOfAyahs', Sort.asc);
    });
  }

  QueryBuilder<Surah, Surah, QAfterSortBy> thenByNumberOfAyahsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numberOfAyahs', Sort.desc);
    });
  }

  QueryBuilder<Surah, Surah, QAfterSortBy> thenByRevelationType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'revelationType', Sort.asc);
    });
  }

  QueryBuilder<Surah, Surah, QAfterSortBy> thenByRevelationTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'revelationType', Sort.desc);
    });
  }

  QueryBuilder<Surah, Surah, QAfterSortBy> thenByTotalDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalDuration', Sort.asc);
    });
  }

  QueryBuilder<Surah, Surah, QAfterSortBy> thenByTotalDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalDuration', Sort.desc);
    });
  }
}

extension SurahQueryWhereDistinct on QueryBuilder<Surah, Surah, QDistinct> {
  QueryBuilder<Surah, Surah, QDistinct> distinctByBookmarked() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bookmarked');
    });
  }

  QueryBuilder<Surah, Surah, QDistinct> distinctByCurrentDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentDuration');
    });
  }

  QueryBuilder<Surah, Surah, QDistinct> distinctByEnglishName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'englishName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Surah, Surah, QDistinct> distinctByEnglishNameTranslation(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'englishNameTranslation',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Surah, Surah, QDistinct> distinctByIsReciting() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isReciting');
    });
  }

  QueryBuilder<Surah, Surah, QDistinct> distinctByLastRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastRead');
    });
  }

  QueryBuilder<Surah, Surah, QDistinct> distinctByLastRecited() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastRecited');
    });
  }

  QueryBuilder<Surah, Surah, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Surah, Surah, QDistinct> distinctByNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'number');
    });
  }

  QueryBuilder<Surah, Surah, QDistinct> distinctByNumberOfAyahs() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'numberOfAyahs');
    });
  }

  QueryBuilder<Surah, Surah, QDistinct> distinctByRevelationType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'revelationType',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Surah, Surah, QDistinct> distinctByTotalDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalDuration');
    });
  }
}

extension SurahQueryProperty on QueryBuilder<Surah, Surah, QQueryProperty> {
  QueryBuilder<Surah, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Surah, bool?, QQueryOperations> bookmarkedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bookmarked');
    });
  }

  QueryBuilder<Surah, int?, QQueryOperations> currentDurationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentDuration');
    });
  }

  QueryBuilder<Surah, String, QQueryOperations> englishNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'englishName');
    });
  }

  QueryBuilder<Surah, String, QQueryOperations>
      englishNameTranslationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'englishNameTranslation');
    });
  }

  QueryBuilder<Surah, bool?, QQueryOperations> isRecitingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isReciting');
    });
  }

  QueryBuilder<Surah, int?, QQueryOperations> lastReadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastRead');
    });
  }

  QueryBuilder<Surah, int?, QQueryOperations> lastRecitedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastRecited');
    });
  }

  QueryBuilder<Surah, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Surah, int, QQueryOperations> numberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'number');
    });
  }

  QueryBuilder<Surah, int, QQueryOperations> numberOfAyahsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'numberOfAyahs');
    });
  }

  QueryBuilder<Surah, String, QQueryOperations> revelationTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'revelationType');
    });
  }

  QueryBuilder<Surah, int?, QQueryOperations> totalDurationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalDuration');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetReciterCollection on Isar {
  IsarCollection<Reciter> get reciters => this.collection();
}

const ReciterSchema = CollectionSchema(
  name: r'Reciter',
  id: -1582478539155196525,
  properties: {
    r'bookmarked': PropertySchema(
      id: 0,
      name: r'bookmarked',
      type: IsarType.bool,
    ),
    r'identifier': PropertySchema(
      id: 1,
      name: r'identifier',
      type: IsarType.string,
    ),
    r'isSelected': PropertySchema(
      id: 2,
      name: r'isSelected',
      type: IsarType.bool,
    ),
    r'lastRecited': PropertySchema(
      id: 3,
      name: r'lastRecited',
      type: IsarType.long,
    ),
    r'listenCount': PropertySchema(
      id: 4,
      name: r'listenCount',
      type: IsarType.int,
    ),
    r'name': PropertySchema(
      id: 5,
      name: r'name',
      type: IsarType.string,
    ),
    r'serverNo': PropertySchema(
      id: 6,
      name: r'serverNo',
      type: IsarType.int,
    )
  },
  estimateSize: _reciterEstimateSize,
  serialize: _reciterSerialize,
  deserialize: _reciterDeserialize,
  deserializeProp: _reciterDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _reciterGetId,
  getLinks: _reciterGetLinks,
  attach: _reciterAttach,
  version: '3.0.2',
);

int _reciterEstimateSize(
  Reciter object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.identifier.length * 3;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _reciterSerialize(
  Reciter object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.bookmarked);
  writer.writeString(offsets[1], object.identifier);
  writer.writeBool(offsets[2], object.isSelected);
  writer.writeLong(offsets[3], object.lastRecited);
  writer.writeInt(offsets[4], object.listenCount);
  writer.writeString(offsets[5], object.name);
  writer.writeInt(offsets[6], object.serverNo);
}

Reciter _reciterDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Reciter(
    bookmarked: reader.readBoolOrNull(offsets[0]) ?? false,
    id: id,
    identifier: reader.readString(offsets[1]),
    isSelected: reader.readBoolOrNull(offsets[2]) ?? false,
    lastRecited: reader.readLongOrNull(offsets[3]),
    listenCount: reader.readIntOrNull(offsets[4]) ?? 0,
    name: reader.readString(offsets[5]),
    serverNo: reader.readInt(offsets[6]),
  );
  return object;
}

P _reciterDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readIntOrNull(offset) ?? 0) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readInt(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _reciterGetId(Reciter object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _reciterGetLinks(Reciter object) {
  return [];
}

void _reciterAttach(IsarCollection<dynamic> col, Id id, Reciter object) {
  object.id = id;
}

extension ReciterQueryWhereSort on QueryBuilder<Reciter, Reciter, QWhere> {
  QueryBuilder<Reciter, Reciter, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ReciterQueryWhere on QueryBuilder<Reciter, Reciter, QWhereClause> {
  QueryBuilder<Reciter, Reciter, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Reciter, Reciter, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterWhereClause> idBetween(
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

extension ReciterQueryFilter
    on QueryBuilder<Reciter, Reciter, QFilterCondition> {
  QueryBuilder<Reciter, Reciter, QAfterFilterCondition> bookmarkedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bookmarked',
        value: value,
      ));
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Reciter, Reciter, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Reciter, Reciter, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Reciter, Reciter, QAfterFilterCondition> identifierEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'identifier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterFilterCondition> identifierGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'identifier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterFilterCondition> identifierLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'identifier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterFilterCondition> identifierBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'identifier',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterFilterCondition> identifierStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'identifier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterFilterCondition> identifierEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'identifier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterFilterCondition> identifierContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'identifier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterFilterCondition> identifierMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'identifier',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterFilterCondition> identifierIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'identifier',
        value: '',
      ));
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterFilterCondition> identifierIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'identifier',
        value: '',
      ));
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterFilterCondition> isSelectedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSelected',
        value: value,
      ));
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterFilterCondition> lastRecitedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastRecited',
      ));
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterFilterCondition> lastRecitedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastRecited',
      ));
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterFilterCondition> lastRecitedEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastRecited',
        value: value,
      ));
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterFilterCondition> lastRecitedGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastRecited',
        value: value,
      ));
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterFilterCondition> lastRecitedLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastRecited',
        value: value,
      ));
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterFilterCondition> lastRecitedBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastRecited',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterFilterCondition> listenCountEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'listenCount',
        value: value,
      ));
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterFilterCondition> listenCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'listenCount',
        value: value,
      ));
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterFilterCondition> listenCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'listenCount',
        value: value,
      ));
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterFilterCondition> listenCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'listenCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<Reciter, Reciter, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<Reciter, Reciter, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<Reciter, Reciter, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<Reciter, Reciter, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<Reciter, Reciter, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<Reciter, Reciter, QAfterFilterCondition> nameContains(
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

  QueryBuilder<Reciter, Reciter, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<Reciter, Reciter, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterFilterCondition> serverNoEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'serverNo',
        value: value,
      ));
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterFilterCondition> serverNoGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'serverNo',
        value: value,
      ));
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterFilterCondition> serverNoLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'serverNo',
        value: value,
      ));
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterFilterCondition> serverNoBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'serverNo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ReciterQueryObject
    on QueryBuilder<Reciter, Reciter, QFilterCondition> {}

extension ReciterQueryLinks
    on QueryBuilder<Reciter, Reciter, QFilterCondition> {}

extension ReciterQuerySortBy on QueryBuilder<Reciter, Reciter, QSortBy> {
  QueryBuilder<Reciter, Reciter, QAfterSortBy> sortByBookmarked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookmarked', Sort.asc);
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterSortBy> sortByBookmarkedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookmarked', Sort.desc);
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterSortBy> sortByIdentifier() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'identifier', Sort.asc);
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterSortBy> sortByIdentifierDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'identifier', Sort.desc);
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterSortBy> sortByIsSelected() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSelected', Sort.asc);
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterSortBy> sortByIsSelectedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSelected', Sort.desc);
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterSortBy> sortByLastRecited() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastRecited', Sort.asc);
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterSortBy> sortByLastRecitedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastRecited', Sort.desc);
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterSortBy> sortByListenCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listenCount', Sort.asc);
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterSortBy> sortByListenCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listenCount', Sort.desc);
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterSortBy> sortByServerNo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serverNo', Sort.asc);
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterSortBy> sortByServerNoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serverNo', Sort.desc);
    });
  }
}

extension ReciterQuerySortThenBy
    on QueryBuilder<Reciter, Reciter, QSortThenBy> {
  QueryBuilder<Reciter, Reciter, QAfterSortBy> thenByBookmarked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookmarked', Sort.asc);
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterSortBy> thenByBookmarkedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookmarked', Sort.desc);
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterSortBy> thenByIdentifier() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'identifier', Sort.asc);
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterSortBy> thenByIdentifierDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'identifier', Sort.desc);
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterSortBy> thenByIsSelected() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSelected', Sort.asc);
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterSortBy> thenByIsSelectedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSelected', Sort.desc);
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterSortBy> thenByLastRecited() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastRecited', Sort.asc);
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterSortBy> thenByLastRecitedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastRecited', Sort.desc);
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterSortBy> thenByListenCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listenCount', Sort.asc);
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterSortBy> thenByListenCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'listenCount', Sort.desc);
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterSortBy> thenByServerNo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serverNo', Sort.asc);
    });
  }

  QueryBuilder<Reciter, Reciter, QAfterSortBy> thenByServerNoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serverNo', Sort.desc);
    });
  }
}

extension ReciterQueryWhereDistinct
    on QueryBuilder<Reciter, Reciter, QDistinct> {
  QueryBuilder<Reciter, Reciter, QDistinct> distinctByBookmarked() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bookmarked');
    });
  }

  QueryBuilder<Reciter, Reciter, QDistinct> distinctByIdentifier(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'identifier', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Reciter, Reciter, QDistinct> distinctByIsSelected() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSelected');
    });
  }

  QueryBuilder<Reciter, Reciter, QDistinct> distinctByLastRecited() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastRecited');
    });
  }

  QueryBuilder<Reciter, Reciter, QDistinct> distinctByListenCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'listenCount');
    });
  }

  QueryBuilder<Reciter, Reciter, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Reciter, Reciter, QDistinct> distinctByServerNo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'serverNo');
    });
  }
}

extension ReciterQueryProperty
    on QueryBuilder<Reciter, Reciter, QQueryProperty> {
  QueryBuilder<Reciter, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Reciter, bool, QQueryOperations> bookmarkedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bookmarked');
    });
  }

  QueryBuilder<Reciter, String, QQueryOperations> identifierProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'identifier');
    });
  }

  QueryBuilder<Reciter, bool, QQueryOperations> isSelectedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSelected');
    });
  }

  QueryBuilder<Reciter, int?, QQueryOperations> lastRecitedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastRecited');
    });
  }

  QueryBuilder<Reciter, int, QQueryOperations> listenCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'listenCount');
    });
  }

  QueryBuilder<Reciter, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Reciter, int, QQueryOperations> serverNoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'serverNo');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetTextTranslationCollection on Isar {
  IsarCollection<TextTranslation> get textTranslations => this.collection();
}

const TextTranslationSchema = CollectionSchema(
  name: r'TextTranslation',
  id: -305717387777720209,
  properties: {
    r'bookmarked': PropertySchema(
      id: 0,
      name: r'bookmarked',
      type: IsarType.bool,
    ),
    r'direction': PropertySchema(
      id: 1,
      name: r'direction',
      type: IsarType.string,
    ),
    r'englishName': PropertySchema(
      id: 2,
      name: r'englishName',
      type: IsarType.string,
    ),
    r'format': PropertySchema(
      id: 3,
      name: r'format',
      type: IsarType.string,
    ),
    r'identifier': PropertySchema(
      id: 4,
      name: r'identifier',
      type: IsarType.string,
    ),
    r'isDownloaded': PropertySchema(
      id: 5,
      name: r'isDownloaded',
      type: IsarType.bool,
    ),
    r'isSelected': PropertySchema(
      id: 6,
      name: r'isSelected',
      type: IsarType.bool,
    ),
    r'language': PropertySchema(
      id: 7,
      name: r'language',
      type: IsarType.string,
    ),
    r'lastRead': PropertySchema(
      id: 8,
      name: r'lastRead',
      type: IsarType.long,
    ),
    r'name': PropertySchema(
      id: 9,
      name: r'name',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 10,
      name: r'type',
      type: IsarType.string,
    )
  },
  estimateSize: _textTranslationEstimateSize,
  serialize: _textTranslationSerialize,
  deserialize: _textTranslationDeserialize,
  deserializeProp: _textTranslationDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _textTranslationGetId,
  getLinks: _textTranslationGetLinks,
  attach: _textTranslationAttach,
  version: '3.0.2',
);

int _textTranslationEstimateSize(
  TextTranslation object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.direction.length * 3;
  bytesCount += 3 + object.englishName.length * 3;
  bytesCount += 3 + object.format.length * 3;
  bytesCount += 3 + object.identifier.length * 3;
  bytesCount += 3 + object.language.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.type.length * 3;
  return bytesCount;
}

void _textTranslationSerialize(
  TextTranslation object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.bookmarked);
  writer.writeString(offsets[1], object.direction);
  writer.writeString(offsets[2], object.englishName);
  writer.writeString(offsets[3], object.format);
  writer.writeString(offsets[4], object.identifier);
  writer.writeBool(offsets[5], object.isDownloaded);
  writer.writeBool(offsets[6], object.isSelected);
  writer.writeString(offsets[7], object.language);
  writer.writeLong(offsets[8], object.lastRead);
  writer.writeString(offsets[9], object.name);
  writer.writeString(offsets[10], object.type);
}

TextTranslation _textTranslationDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TextTranslation(
    bookmarked: reader.readBoolOrNull(offsets[0]) ?? false,
    direction: reader.readString(offsets[1]),
    englishName: reader.readString(offsets[2]),
    format: reader.readString(offsets[3]),
    identifier: reader.readString(offsets[4]),
    isDownloaded: reader.readBool(offsets[5]),
    isSelected: reader.readBoolOrNull(offsets[6]) ?? false,
    language: reader.readString(offsets[7]),
    lastRead: reader.readLongOrNull(offsets[8]),
    name: reader.readString(offsets[9]),
    type: reader.readString(offsets[10]),
  );
  object.id = id;
  return object;
}

P _textTranslationDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readLongOrNull(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _textTranslationGetId(TextTranslation object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _textTranslationGetLinks(TextTranslation object) {
  return [];
}

void _textTranslationAttach(
    IsarCollection<dynamic> col, Id id, TextTranslation object) {
  object.id = id;
}

extension TextTranslationQueryWhereSort
    on QueryBuilder<TextTranslation, TextTranslation, QWhere> {
  QueryBuilder<TextTranslation, TextTranslation, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TextTranslationQueryWhere
    on QueryBuilder<TextTranslation, TextTranslation, QWhereClause> {
  QueryBuilder<TextTranslation, TextTranslation, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterWhereClause>
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

  QueryBuilder<TextTranslation, TextTranslation, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterWhereClause> idBetween(
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

extension TextTranslationQueryFilter
    on QueryBuilder<TextTranslation, TextTranslation, QFilterCondition> {
  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      bookmarkedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bookmarked',
        value: value,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      directionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'direction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      directionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'direction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      directionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'direction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      directionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'direction',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      directionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'direction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      directionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'direction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      directionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'direction',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      directionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'direction',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      directionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'direction',
        value: '',
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      directionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'direction',
        value: '',
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      englishNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'englishName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      englishNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'englishName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      englishNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'englishName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      englishNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'englishName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      englishNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'englishName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      englishNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'englishName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      englishNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'englishName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      englishNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'englishName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      englishNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'englishName',
        value: '',
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      englishNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'englishName',
        value: '',
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      formatEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'format',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      formatGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'format',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      formatLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'format',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      formatBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'format',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      formatStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'format',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      formatEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'format',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      formatContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'format',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      formatMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'format',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      formatIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'format',
        value: '',
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      formatIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'format',
        value: '',
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      identifierEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'identifier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      identifierGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'identifier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      identifierLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'identifier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      identifierBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'identifier',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      identifierStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'identifier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      identifierEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'identifier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      identifierContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'identifier',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      identifierMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'identifier',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      identifierIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'identifier',
        value: '',
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      identifierIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'identifier',
        value: '',
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      isDownloadedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDownloaded',
        value: value,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      isSelectedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSelected',
        value: value,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      languageEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'language',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      languageGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'language',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      languageLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'language',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      languageBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'language',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      languageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'language',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      languageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'language',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      languageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'language',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      languageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'language',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      languageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'language',
        value: '',
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      languageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'language',
        value: '',
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      lastReadIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastRead',
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      lastReadIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastRead',
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      lastReadEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastRead',
        value: value,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      lastReadGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastRead',
        value: value,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      lastReadLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastRead',
        value: value,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      lastReadBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastRead',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      nameEqualTo(
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

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      nameGreaterThan(
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

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      nameLessThan(
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

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      nameBetween(
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

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      nameStartsWith(
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

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      nameEndsWith(
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

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      typeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      typeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      typeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      typeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      typeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      typeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterFilterCondition>
      typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }
}

extension TextTranslationQueryObject
    on QueryBuilder<TextTranslation, TextTranslation, QFilterCondition> {}

extension TextTranslationQueryLinks
    on QueryBuilder<TextTranslation, TextTranslation, QFilterCondition> {}

extension TextTranslationQuerySortBy
    on QueryBuilder<TextTranslation, TextTranslation, QSortBy> {
  QueryBuilder<TextTranslation, TextTranslation, QAfterSortBy>
      sortByBookmarked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookmarked', Sort.asc);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterSortBy>
      sortByBookmarkedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookmarked', Sort.desc);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterSortBy>
      sortByDirection() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'direction', Sort.asc);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterSortBy>
      sortByDirectionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'direction', Sort.desc);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterSortBy>
      sortByEnglishName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'englishName', Sort.asc);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterSortBy>
      sortByEnglishNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'englishName', Sort.desc);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterSortBy> sortByFormat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'format', Sort.asc);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterSortBy>
      sortByFormatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'format', Sort.desc);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterSortBy>
      sortByIdentifier() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'identifier', Sort.asc);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterSortBy>
      sortByIdentifierDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'identifier', Sort.desc);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterSortBy>
      sortByIsDownloaded() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDownloaded', Sort.asc);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterSortBy>
      sortByIsDownloadedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDownloaded', Sort.desc);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterSortBy>
      sortByIsSelected() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSelected', Sort.asc);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterSortBy>
      sortByIsSelectedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSelected', Sort.desc);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterSortBy>
      sortByLanguage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'language', Sort.asc);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterSortBy>
      sortByLanguageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'language', Sort.desc);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterSortBy>
      sortByLastRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastRead', Sort.asc);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterSortBy>
      sortByLastReadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastRead', Sort.desc);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterSortBy>
      sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension TextTranslationQuerySortThenBy
    on QueryBuilder<TextTranslation, TextTranslation, QSortThenBy> {
  QueryBuilder<TextTranslation, TextTranslation, QAfterSortBy>
      thenByBookmarked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookmarked', Sort.asc);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterSortBy>
      thenByBookmarkedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookmarked', Sort.desc);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterSortBy>
      thenByDirection() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'direction', Sort.asc);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterSortBy>
      thenByDirectionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'direction', Sort.desc);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterSortBy>
      thenByEnglishName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'englishName', Sort.asc);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterSortBy>
      thenByEnglishNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'englishName', Sort.desc);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterSortBy> thenByFormat() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'format', Sort.asc);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterSortBy>
      thenByFormatDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'format', Sort.desc);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterSortBy>
      thenByIdentifier() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'identifier', Sort.asc);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterSortBy>
      thenByIdentifierDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'identifier', Sort.desc);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterSortBy>
      thenByIsDownloaded() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDownloaded', Sort.asc);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterSortBy>
      thenByIsDownloadedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDownloaded', Sort.desc);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterSortBy>
      thenByIsSelected() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSelected', Sort.asc);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterSortBy>
      thenByIsSelectedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSelected', Sort.desc);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterSortBy>
      thenByLanguage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'language', Sort.asc);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterSortBy>
      thenByLanguageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'language', Sort.desc);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterSortBy>
      thenByLastRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastRead', Sort.asc);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterSortBy>
      thenByLastReadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastRead', Sort.desc);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QAfterSortBy>
      thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension TextTranslationQueryWhereDistinct
    on QueryBuilder<TextTranslation, TextTranslation, QDistinct> {
  QueryBuilder<TextTranslation, TextTranslation, QDistinct>
      distinctByBookmarked() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bookmarked');
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QDistinct> distinctByDirection(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'direction', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QDistinct>
      distinctByEnglishName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'englishName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QDistinct> distinctByFormat(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'format', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QDistinct>
      distinctByIdentifier({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'identifier', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QDistinct>
      distinctByIsDownloaded() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDownloaded');
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QDistinct>
      distinctByIsSelected() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSelected');
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QDistinct> distinctByLanguage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'language', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QDistinct>
      distinctByLastRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastRead');
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TextTranslation, TextTranslation, QDistinct> distinctByType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }
}

extension TextTranslationQueryProperty
    on QueryBuilder<TextTranslation, TextTranslation, QQueryProperty> {
  QueryBuilder<TextTranslation, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TextTranslation, bool, QQueryOperations> bookmarkedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bookmarked');
    });
  }

  QueryBuilder<TextTranslation, String, QQueryOperations> directionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'direction');
    });
  }

  QueryBuilder<TextTranslation, String, QQueryOperations>
      englishNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'englishName');
    });
  }

  QueryBuilder<TextTranslation, String, QQueryOperations> formatProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'format');
    });
  }

  QueryBuilder<TextTranslation, String, QQueryOperations> identifierProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'identifier');
    });
  }

  QueryBuilder<TextTranslation, bool, QQueryOperations> isDownloadedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDownloaded');
    });
  }

  QueryBuilder<TextTranslation, bool, QQueryOperations> isSelectedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSelected');
    });
  }

  QueryBuilder<TextTranslation, String, QQueryOperations> languageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'language');
    });
  }

  QueryBuilder<TextTranslation, int?, QQueryOperations> lastReadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastRead');
    });
  }

  QueryBuilder<TextTranslation, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<TextTranslation, String, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }
}
