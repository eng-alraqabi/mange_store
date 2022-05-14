import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mange_store/Models/Product.dart';
import 'package:mange_store/Widget/BottomBar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/src/provider.dart';
import '../constants.dart';

class NewProdact_Screen extends StatefulWidget {
  @override
  _NewProdact_ScreenState createState() => _NewProdact_ScreenState();
}

class _NewProdact_ScreenState extends State<NewProdact_Screen> {
  bool _issetimage = false;
  Uint8List? _imgememory;
  TextEditingController _Nam_control = TextEditingController();
  TextEditingController _Barcode_control = TextEditingController();
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes = "";
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    } on PlatformException {
      setState(() {
        _Barcode_control.text = "";
      });
    }
    if (!mounted) return;
    setState(() {
      switch (barcodeScanRes) {
        case "-1":
          _Barcode_control.text = "";
          break;
        default:
          _Barcode_control.text = barcodeScanRes;
          break;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: KprimaryColor,
          foregroundColor: Kwhite,
          title: Text(
            "إظافة صنف جديد",
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..color = Colors.white,
            ),
          ),
        ),
        backgroundColor: KbgColor,
        body: ListView(
          children: [
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(5),
              child: TextFormField(
                controller: _Nam_control,
                cursorColor: KprimaryColor,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: KprimaryColor, width: 2),
                  ),
                  filled: true,
                  fillColor: Kwhite.withOpacity(0.8),
                  contentPadding: EdgeInsets.only(
                      left: 10, bottom: 5, right: 15, top: 5),
                  labelText: "أسم الصنف",
                  labelStyle: TextStyle(
                    color: KprimaryColor.withOpacity(0.5),
                    fontFamily: "Cairo",
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: KprimaryColor, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: KprimaryColor, width: 2),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                controller: _Barcode_control,
                keyboardType: TextInputType.text,
                cursorColor: KprimaryColor,
                onEditingComplete: () {},
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: KprimaryColor, width: 2),
                  ),
                  filled: true,
                  fillColor: Kwhite.withOpacity(0.8),
                  contentPadding: EdgeInsets.only(
                      left: 10, bottom: 5, right: 15, top: 5),
                  labelText: "باركود الصنف",
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: IconButton(
                      splashColor: KprimaryColor,
                      onPressed: () {},
                      icon: Icon(Icons.search, color: KprimaryColor,),
                    ),
                  ),
                  labelStyle: TextStyle(
                    color: KprimaryColor.withOpacity(0.5),
                    fontFamily: "Cairo",
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  prefixIcon: IconButton(
                      onPressed: () {
                        scanBarcodeNormal();
                      },
                      icon: Icon(Icons.qr_code, color: KprimaryColor,)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: KprimaryColor, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: KprimaryColor, width: 2),
                  ),
                ),
              ),
            ),
            Container(
                width: size.width,
                height: size.width / 1.5,
                margin: EdgeInsets.all(20),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  color: KaccentColor,

                  shape: BoxShape.rectangle,
                  boxShadow: [BoxShadow(blurRadius: 5, color: KprimaryColor)],
                ),
                child: Stack(
                  children: [
                    Container(
                      width: size.width,
                      height: size.width / 1.5,
                      child: _issetimage ? Image.memory(
                        _imgememory!, fit: BoxFit.fill,) : SizedBox(),
                    ),
                    Positioned(
                        bottom: 0,
                        child: Container(
                          height: 50,
                          width: size.width * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: Kwhite,
                            boxShadow: [
                              BoxShadow(blurRadius: 5, color: KprimaryColor)
                            ],
                          ),
                          child: RaisedButton(
                            splashColor: KprimaryColor,
                            color: KaccentColor,
                            onPressed: () async {
                              try{
                                _imgememory = await getimage();
                              }catch(e){
                                showtost(context, e.toString());
                              }
                              setState(() {
                                _issetimage = true;
                              });
                            },
                            padding: EdgeInsets.all(10),
                            child: Icon(Icons.add_a_photo, size: 30,),
                          ),
                        )),

                  ],
                ))
          ],
        ),
        bottomNavigationBar: BottomBar(() {}, () {}),
        floatingActionButton: FloatingActionButton(
            splashColor: KprimaryColor,
            elevation: 5,
            child: Icon(Icons.save, color: KprimaryColor,),
            backgroundColor: KaccentColor,
            onPressed: () {
              setState(() {
                _saveproductimage();
              });
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),);
  }

  Future<Uint8List> getimage() async {
    ImagePicker _imag = ImagePicker();
    XFile? xfile = await _imag.pickImage(source: ImageSource.camera);
    return await xfile!.readAsBytes();
  }

  Future<void> _saveproductimage() async {
    String name_file = "${DateTime
        .now()
        .year
        .toString()}"
        "${DateTime
        .now()
        .month
        .toString()}"
        "${DateTime
        .now()
        .day
        .toString()}"
        "${DateTime
        .now()
        .minute
        .toString()}"
        "${DateTime
        .now()
        .second
        .toString()}";
    String? dir_path;
    try{
      await new Directory('/storage/emulated/0/Prodactsphoto')
          .create()
          .then((Directory directory) {
        dir_path = directory.path;
      });
    }catch(e){
      showtost(context, e.toString());
    }

    final String path = '$dir_path/$name_file.jpg';
    final File file = File(path);
    file.writeAsBytes(_imgememory!);
    String _name = _Nam_control.value.text;
    String _barcode = _Barcode_control.value.text;
    bool isadd = await Provider.of<ListProducts>(context, listen: false)
        .add_tolist(Product(_barcode, _name, "${name_file}"));
    if (isadd) {
      showtost(context, "تم الحفظ");
      _Nam_control.text = "";
      _Barcode_control.text = "";
      _imgememory!.clear();
    }
  }
}
