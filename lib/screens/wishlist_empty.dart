import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Widget EmptyWishlist(BuildContext context) {
  return SafeArea(
      child: Scaffold(
    body: Column(
      children: [Center(child: Text(AppLocalizations.of(context)!.wishlistEmpty))],
    ),
  ));
}
