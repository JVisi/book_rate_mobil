import 'package:book_rate/serialized/book/book.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wish_list.g.dart';


@JsonSerializable()
class WishlistItem {
  final String id;
  final Book book;
  WishlistItem({required this.id, required this.book});


  factory WishlistItem.fromJson(Map<String, dynamic> json) => _$WishlistItemFromJson(json);
  Map<String, dynamic> toJson() => _$WishlistItemToJson(this);
}

@JsonSerializable()
class Wishlist {
  final List<WishlistItem> wishlist;

  Wishlist({required this.wishlist});

  factory Wishlist.fromJson(Map<String, dynamic> json) => _$WishlistFromJson(json);
  Map<String, dynamic> toJson() => _$WishlistToJson(this);
}
