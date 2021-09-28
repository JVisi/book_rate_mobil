import 'package:book_rate/serialized/book/book.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wish_list.g.dart';


@JsonSerializable()
class Wishlist {
  final String? id;
  final Book? book;
  Wishlist({required this.id, this.book});

  factory Wishlist.fromJson(Map<String, dynamic> json) => _$WishlistFromJson(json);
  Map<String, dynamic> toJson() => _$WishlistToJson(this);
}