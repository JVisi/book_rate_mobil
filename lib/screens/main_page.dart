import 'package:book_rate/config/core.dart';
import 'package:book_rate/config/loader.dart';
import 'package:book_rate/screens/book_page.dart';
import 'package:book_rate/serialized/book/book.dart';
import 'package:book_rate/web/get_book.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class MainPage extends StatefulWidget {
  final String name;

  const MainPage({Key? key, required this.name}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {

  String _scanBarcode="";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    //return const LoadBooks();
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      child: Container(
                        width: SizeConfig.screenWidth/3,
                        height: SizeConfig.screenWidth/3,
                        child: Card(
                          color: Colors.indigo,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical),
                                child: Icon(Icons.book,color: Colors.white,size: SizeConfig.blockSizeVertical*8,),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoadBooks()));
                                  },
                                  child: Text("Load books",style:TextStyle(color: Colors.white70,fontSize: SizeConfig.blockSizeVertical * 2.5) ,),
                              ),
                            ],
                          ),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                      onTap: () {
                        return print("sadf");
                      },
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      child: Container(
                        width: SizeConfig.screenWidth/3,
                        height: SizeConfig.screenWidth/3,
                        child: Card(
                          color: Colors.indigo,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical),
                                child: Icon(Icons.book,color: Colors.white,size: SizeConfig.blockSizeVertical*8,),
                              ),
                              TextButton(
                                onPressed: () async{
                                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>LoadBooks()));
                                  await scanBarcodeNormal();
                                },
                                child: Text("Load books",style:TextStyle(color: Colors.white70,fontSize: SizeConfig.blockSizeVertical * 2.5) ,),
                              ),
                            ],
                          ),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                      onTap: () {
                        return print("sadf");
                      },
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);

      ///MAKE REQUEST HERE

      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

}

class LoadBooks extends StatelessWidget {
  const LoadBooks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return LoadingHandler(
      future: GetAllBooks().sendRequest,
      succeeding: (Library l) {
        return Books(library: l);
      },
    );
  }
}
