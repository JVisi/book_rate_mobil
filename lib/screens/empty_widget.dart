import 'package:book_rate/config/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shake/shake.dart';

class EmptyWidget extends StatefulWidget {
  final IconData? icon;
  final String? message;

  const EmptyWidget({Key? key, this.icon, this.message}) : super(key: key);

  @override
  State<EmptyWidget> createState() => _EmptyWidgetState();
}

class _EmptyWidgetState extends State<EmptyWidget> {
  late ShakeDetector detector;
  @override
  void initState() {
    super.initState();
    detector = ShakeDetector.autoStart(onPhoneShake: () {
      setState(() {
        CustomColors.backgroundColor = CustomColors.backgroundColor;
        CustomColors.textColor = CustomColors.textColor ;
      });

    });
  }
  @override
  void dispose(){
    detector.stopListening();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.backgroundColor,
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.icon ?? Icons.warning, color: CustomColors.textColor),
              Text(widget.message ?? AppLocalizations.of(context)!.empty,style: TextStyle(color: CustomColors.textColor))
            ],
          ),
        ),
      ),
    );
  }
}
