import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:book_rate/config/core.dart';

class LoadingHandler<T> extends StatefulWidget {
  final Future<T> Function()? future;
  final Widget Function(T data)? succeeding;
  final Widget? onError;
  final bool? needReloadButton;

  LoadingHandler({@required this.future, @required this.succeeding, this.onError, this.needReloadButton});

  @override
  LoadingHandlerState<T> createState() => LoadingHandlerState();
}

class LoadingHandlerState<T> extends State<LoadingHandler<T>> {
  Future<T>? _future;
  bool? _needReloadButton;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = widget.future!();
    _needReloadButton = widget.needReloadButton;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // TODO: implement build
    return FutureBuilder<T>(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot<T> snapshot) =>
            SnapshotManager<T>(
                snapshot: snapshot,
                onError: <T>(T error){
                    if(widget.onError!=null){
                      return widget.onError!;
                    }
                    return showErrorWidget(error.toString(), Icons.error,_needReloadButton);
                    },
                onSuccess: (T data) => widget.succeeding!(data),
                onWait: showLoadingWidget("", "", null)));
  }

  refresh() {
    setState(() {
      this._future = widget.future!();
    });
  }

  Widget showErrorWidget(String? name, IconData? icon, bool? needReload){
    return Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[
              const Spacer(
                flex: 1,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical:SizeConfig.blockSizeVertical),
                child: Icon(icon ?? Icons.warning,color: Colors.red,),
              ),
              Text(name ?? "Error",
                style: themeConfig().textTheme.bodyText1,),
              needReload!=null?Padding(
                padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical),
                child: ElevatedButton(onPressed: refresh,
                    child: Text("Reload",style: themeConfig().textTheme.bodyText1)
                ),
              ): Text(""),
              Spacer(
                flex: 2,
              )
            ],
          ),
        ));
  }
  Widget showLoadingWidget(String? name, String? desc, IconData? icon) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Spacer(
          flex: 1,
        ),
        SpinKitWave(
          color: Colors.blue,
          size: SizeConfig.blockSizeVertical*10,
        ),
        Icon(icon ?? Icons.hourglass_empty),
        Text(name ?? "Now Loading...",style: themeConfig().textTheme.bodyText1),
        Text(desc ?? "",style: themeConfig().textTheme.bodyText1),
        Spacer(
          flex: 2,
        )
      ],
    ));
  }
}

class SnapshotManager<T> extends StatelessWidget {
  final AsyncSnapshot<T>? snapshot;
  final Widget Function<T>(T data)? onError;
  final Widget? onWait;
  final Widget Function(T data)? onSuccess;

  SnapshotManager(
      {@required this.snapshot,
      @required this.onError,
      @required this.onSuccess,
      @required this.onWait});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (this.snapshot!.connectionState == ConnectionState.waiting) return onWait!;
    if (snapshot!.hasData) {
      return this.onSuccess!(snapshot!.data!);
    }
    return this.onError!(snapshot!.error);
  }
}
