import 'package:book_rate/config/core.dart';
import 'package:book_rate/config/loader.dart';
import 'package:book_rate/config/model.dart';
import 'package:book_rate/screens/book_page.dart';
import 'package:book_rate/screens/menu_tile.dart';
import 'package:book_rate/screens/wishlist_empty.dart';
import 'package:book_rate/serialized/book/book.dart';
import 'package:book_rate/serialized/rates/rates.dart';
import 'package:book_rate/serialized/wishList/wish_list.dart';
import 'package:book_rate/web/get_book.dart';
import 'package:book_rate/web/get_user_books.dart';
import 'package:book_rate/web/get_wishlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainPage extends StatefulWidget {
  final String name;

  const MainPage({Key? key, required this.name}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {

  String _scanBarcode = "";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    //return const LoadBooks();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    menu_tile(context, loadBooks,
                        AppLocalizations.of(context)!.loadBooks, null)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    menu_tile(
                        context,
                        scanBarcodeNormal,
                        AppLocalizations.of(context)!.scanBarcode,
                        Icons.qr_code)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      menu_tile(context, loadBooks,
                          AppLocalizations.of(context)!.loadBooks, null)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      menu_tile(
                          context,
                          scanBarcodeNormal,
                          AppLocalizations.of(context)!.scanBarcode,
                          Icons.qr_code)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      menu_tile(
                          context,
                          scanBarcodeNormal,
                          AppLocalizations.of(context)!.myBooks,
                          Icons.collections_bookmark)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      menu_tile(
                          context,
                          scanBarcodeNormal,
                          AppLocalizations.of(context)!.whishList,
                          Icons.list)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      menu_tile(
                          context,
                          scanBarcodeNormal,
                          AppLocalizations.of(context)!.settings,
                          Icons.settings)
                    ],
                  ),
                ),

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


    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  Future<void> loadBooks() async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LoadingHandler(
                  future: GetAllBooks()
                      .sendRequest,
                  succeeding: (Library wl) {
                      //List<Book> l = wl.wishlist.map((e) => e.book).toList();
                      return Books(library: wl);
                  return EmptyWishlist(context);
                  },
                )));
  }
}
