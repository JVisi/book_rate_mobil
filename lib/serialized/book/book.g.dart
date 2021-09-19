// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) => Book(
      json['ISBN'] as String,
      json['name'] as String,
      json['author'] as String,
      json['year'] as int,
      json['languageCode'] as String,
      DateTime.parse(json['added'] as String),
      json['addedBy'] as String,
    );

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'ISBN': instance.ISBN,
      'name': instance.name,
      'author': instance.author,
      'year': instance.year,
      'languageCode': instance.languageCode,
      'added': instance.added.toIso8601String(),
      'addedBy': instance.addedBy,
    };

Library _$LibraryFromJson(Map<String, dynamic> json) => Library(
      books: (json['books'] as List<dynamic>)
          .map((e) => Book.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LibraryToJson(Library instance) => <String, dynamic>{
      'books': instance.books,
    };
