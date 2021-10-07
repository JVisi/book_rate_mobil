import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmptyWidget extends StatelessWidget {
  final IconData? icon;
  final String? message;

  const EmptyWidget({Key? key, this.icon, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon ?? Icons.warning),
              Text(message ?? AppLocalizations.of(context)!.empty)
            ],
          ),
        ),
      ),
    );
  }
}
