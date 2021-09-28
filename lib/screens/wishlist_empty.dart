import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget EmptyWishlist() {
  return SafeArea(
      child: Scaffold(
    body: Column(
      children: const [Text("Wishlist is empty, motherfucker")],
    ),
  ));
}
