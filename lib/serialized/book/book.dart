import 'package:json_annotation/json_annotation.dart';

part 'book.g.dart';


@JsonSerializable()
class Book {
  final String ISBN;
  final String name;
  final String author;
  final int year;
  final String languageCode;
  final DateTime added;
  final String addedBy;

  Book(this.ISBN, this.name, this.author, this.year, this.languageCode, this.added, this.addedBy);

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
  Map<String, dynamic> toJson() => _$BookToJson(this);
}

@JsonSerializable()
class Library{
  final List<Book> books;

  Library({required this.books});

  factory Library.fromJson(Map<String, dynamic> json) => _$LibraryFromJson(json);
  Map<String, dynamic> toJson() => _$LibraryToJson(this);
}
