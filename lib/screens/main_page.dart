import 'package:book_rate/config/core.dart';
import 'package:book_rate/config/loader.dart';
import 'package:book_rate/config/model.dart';
import 'package:book_rate/screens/book_detailed.dart';
import 'package:book_rate/screens/book_page.dart';
import 'package:book_rate/screens/empty_widget.dart';
import 'package:book_rate/screens/menu_tile.dart';
import 'package:book_rate/screens/rated_book_page.dart';
import 'package:book_rate/serialized/book/book.dart';
import 'package:book_rate/serialized/rates/rates.dart';
import 'package:book_rate/serialized/wishList/wish_list.dart';
import 'package:book_rate/web/barcode_search.dart';
import 'package:book_rate/web/get_book.dart';
import 'package:book_rate/web/get_user_books.dart';
import 'package:book_rate/web/get_wishlist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shake/shake.dart';

class MainPage extends StatefulWidget {
  final String name;

  const MainPage({Key? key, required this.name}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MainPageState();
}
//static Color changedBackgroundColor = Colors.red;
//static Color changedCardsColor = Colors.blue;
class MainPageState extends State<MainPage> {
  late ShakeDetector detector;
  String _scanBarcode = "";

  @override
  void initState() {
    super.initState();
    detector = ShakeDetector.autoStart(onPhoneShake: () {
      setState(() {
        if (CustomColors.backgroundColor == Colors.blue) {
          CustomColors.backgroundColor = Colors.black;
          CustomColors.interact = Colors.grey;
          CustomColors.textColor = Colors.grey;
          CustomColors.starColor = Colors.blueGrey;
        } else {
          CustomColors.backgroundColor = Colors.blue;
          CustomColors.interact = Colors.orangeAccent;
          CustomColors.textColor = Colors.orangeAccent;
          CustomColors.starColor = Colors.yellow;
        }
      });
    });
  }

  @override
  void dispose() {
    detector.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    //return const LoadBooks();
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
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
                          loadMyBooks,
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
                      menu_tile(context, loadWishList,
                          AppLocalizations.of(context)!.whishList, Icons.list)
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
                          logout,
                          AppLocalizations.of(context)!.logout,
                          Icons.logout)
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

  Future<void> logout() async{
    await killLoginCreds();
    SystemNavigator.pop();
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);

      if (barcodeScanRes != "-1") {
        final response =
        await BarcodeSearch(barcode: barcodeScanRes).sendRequest();
        if (response != null) {
          if (response.books.isNotEmpty) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DetailedBook(book: response.books.first)));
          } else if (response.books.isEmpty) {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) =>
                  AlertDialog(
                    title: Text(AppLocalizations.of(context)!.alertDialogTitle),
                    content: Text(
                        AppLocalizations.of(context)!.alertDialogText),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
            );
          }
        }
      }
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
            builder: (context) =>
                LoadingHandler(
                  future: GetAllBooks().sendRequest,
                  succeeding: (Library wl) {
                    //List<Book> l = wl.wishlist.map((e) => e.book).toList();
                    return Books(library: wl);
                  },
                )));
  }

  Future<void> loadWishList() async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                LoadingHandler(
                  future: GetWishlist(AppModel
                      .of(context)
                      .getUser()
                      .id)
                      .sendRequest,
                  succeeding: (Wishlist wl) {
                    List<Book> l = wl.wishlist.map((e) => e.book).toList();
                    if (l.isNotEmpty) {
                      return Books(library: Library(books: l));
                    } else {
                      return EmptyWidget(
                          message: AppLocalizations.of(context)!.wishlistEmpty);
                    }
                  },
                )));
  }

  Future<void> loadMyBooks() async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                LoadingHandler(
                  future: GetRatesOfUser(AppModel
                      .of(context)
                      .getUser()
                      .id)
                      .sendRequest,
                  succeeding: (Rates wl) {
                    if (wl.rates.isNotEmpty) {
                      return RatedBooks(rates: wl);
                    } else {
                      return EmptyWidget(
                          message: AppLocalizations.of(context)!.empty);

                      ///EmptyWidget neeeded
                    }
                  },
                )));
  }
}
