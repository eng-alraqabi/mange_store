import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mange_store/DB/DBHelper.dart';
import 'package:mange_store/Views/Home_Screen.dart';
import 'package:provider/provider.dart';
import 'Models/Castmer.dart';
import 'Models/Product.dart';
import 'Models/ProductBuy.dart';
import 'Models/ProductSell.dart';
import 'Models/Suplier.dart';
import 'constants.dart';

void main() {

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ListProducts()),
        ChangeNotifierProvider(create: (_) => ProductBuy()),
        ChangeNotifierProvider(create: (_) => ProductSell()),
        ChangeNotifierProvider(create: (_) => ListCastmers()),
        ChangeNotifierProvider(create: (_) => ListSupliers()),
      ],
      child: const MyApp(),
    ),
  );
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    // navigation bar color
    statusBarColor: KprimaryColor, // status bar color
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    DBH.dH.initDB();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "توريد المنتجات",
      theme: ThemeData(

        primarySwatch: Colors.lime,
      ),
      home:  Home_Screen(),
    );
  }
}

