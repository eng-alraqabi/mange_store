import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:mange_store/Models/Product.dart';
import 'package:mange_store/Views/NewProdact_Screen.dart';
import 'package:mange_store/Widget/BottomBar.dart';
import 'package:mange_store/Widget/Header_Table.dart';
import 'package:mange_store/constants.dart';
import 'package:provider/src/provider.dart';

class Products_Mange extends StatelessWidget {
  TextEditingController _Barcodeserch_c=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: KprimaryColor,
          foregroundColor: Kwhite,
          title: Text(
            "قائمــة الأصناف",
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              foreground: Paint()..color = Colors.white,
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5,left: 5,right: 5),
              child: Product_Scrch(controllerserch: _Barcodeserch_c,model: context.read<ListProducts>()),
            ),
            Header_Table(["الصورة","اسم المنتج","الباركود"]),
            Expanded(
                child:Prodacts_mang_list()
            ),

          ],
        ),
        bottomNavigationBar: BottomBar(() {}, (){
         Provider.of<ListProducts>(context,listen: false).resetlist();
        }),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add_chart),
            backgroundColor: Colors.lime[900],
            onPressed: () {
              var _nv=Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewProdact_Screen()));
             // _nv.then((value) => void);
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}

class Prodacts_mang_list extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color:KsecondaryColor,width: 2),

        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25)),
        color: Kwhite,
      ),
      width: size.width,
      margin: EdgeInsets.only(left: 5,right: 5,bottom:0),
      child: ListView.builder(
        itemCount:context.watch<ListProducts>().list.length,
        itemBuilder: (context, index){
          if(context.watch<ListProducts>().list[index].isserch) {
            return Container(
              height: 70,
              child:Card(
                clipBehavior: Clip.antiAlias,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Image.file(_getfile("${context
                          .watch<ListProducts>()
                          .list[index].Photo}"), width: 80, height: 60,fit: BoxFit.cover),
                    ),
                    Expanded(
                      flex:6,
                      child: ListTile(
                        minVerticalPadding: 0,
                        trailing: IconButton(
                            splashColor: KprimaryColor,
                            onPressed: (){
                              showalrt(context,Provider.of<ListProducts>(context,listen: false).list[index],index);
                            },
                            icon:Icon(Icons.microwave,size: 30,color: KsecondaryColor,)),
                        title:  Text('${context
                            .watch<ListProducts>()
                            .list[index].Name}',style: B_16_G()),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'الباركــود : ${context
                                  .watch<ListProducts>()
                                  .list[index].Barcode}',
                              style:  B_10_G(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }else{
            return Divider(color: KbgColor,height: 0.0,thickness: 0.0,);
          }
        },),
    );
  }
  File _getfile(String filename){
    File file = new File("/storage/emulated/0/Prodactsphoto/"+filename+".jpg");
    return file;
  }
  void showalrt(BuildContext context ,Product _Product,int index){
    showDialog<void>(
      context: context,
      useSafeArea: false,
      barrierDismissible:
      false, // user must tap button!
      builder: (BuildContext context) {
        return Directionality(
          textDirection:
          TextDirection.rtl,
          child: AlertDialog(
            titleTextStyle: TextStyle(
              color:
              Colors.lightGreen[900],
              fontFamily: "Cairo",
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.all(
                    Radius.circular(
                        10.0))),
            title: Center(
              child: Text(
                  "أســم الصنف : ${_Product.Name}"),
            ),
            titlePadding: EdgeInsets.only(top: 10),
            backgroundColor:KbgColor,
            contentPadding:
            EdgeInsets.only(
                top: 5,
                bottom: 5),

            content:
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("الباركود :${_Product.Barcode}"),
                 Image.file(_getfile("${_Product.Photo}"),width:200,height:200,),
              ],
            ),
            actionsAlignment: MainAxisAlignment.spaceAround,
            actions: <Widget>[

              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('خروج'),
                onPressed: () {
                  Navigator.of(context)
                      .pop();
                },
              ),
              FlatButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text('حذف'),
                onPressed: ()  async {
                   bool isde=await  Provider.of<ListProducts>(context,listen: false).delet_fromlist(index);
                   if(isde){
                       Navigator.of(context)
                           .pop();
                   }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class Product_Scrch extends StatefulWidget {
  TextEditingController controllerserch;
  final model;
  //final bool iscastmer;
  Product_Scrch({ required this.controllerserch, required this.model});

  @override
  _Product_ScrchState createState() => _Product_ScrchState();
}

class _Product_ScrchState extends State<Product_Scrch> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          color: KsecondaryColor,
          shape: BoxShape.rectangle,
          border: Border.all(width:2,color: KsecondaryColor)
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                  flex:1,
                  child: Center(child: Text("بحث بـ:",style: B_12_W()))),
              Expanded(
                flex:2,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    Radio(
                      fillColor:MaterialStateProperty.all(Color(0xFFFFFFFF)),
                      value: 1,
                      groupValue: Radio_P_Store,
                      onChanged: (value) {
                        setState(() {
                          Radio_P_Store = value as int;
                        });
                      },
                      activeColor:KprimaryColor,
                    ),
                    Text("الباركود",style: B_10_W()),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio(
                      fillColor:MaterialStateProperty.all(Color(0xFFFFFFFF)),
                      value: 2,
                      groupValue: Radio_P_Store,
                      onChanged: (value) {
                        setState(() {
                          Radio_P_Store = value as int;
                        });
                      },
                      activeColor:KprimaryColor,
                    ),
                    Text("اسم الصنف",style: B_10_W()),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom:5,left: 5,right: 5),
            child: TextFormField(
              controller:widget.controllerserch,
              readOnly:Radio_P_Store==1 ?true:false,
              onChanged: (v){
                widget.model.serch_inlist(Radio_P_Store, v);
              },
              decoration:InputDecoration(
                label: Text("    بحـــث"),
                floatingLabelStyle: TextStyle(
                  color: KprimaryColor,
                ),
                floatingLabelBehavior:FloatingLabelBehavior.auto ,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Kwhite,width:2),
                  borderRadius: BorderRadius.all( Radius.circular(20)),
                ),
                focusedBorder:OutlineInputBorder(
                  borderSide: BorderSide(color:KprimaryColor,width:2),
                  borderRadius: BorderRadius.all( Radius.circular(20)),
                ),
                filled: true,
                fillColor: Kwhite.withOpacity(0.7),
                contentPadding: EdgeInsets.zero,
                icon:IconButton(
                  onPressed: (){
                    scanBarcodeNormal();
                  },
                  icon: Icon(Icons.qr_code_outlined,size:30,color: Kwhite,),
                ) ,

                suffixIcon: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: IconButton(
                    onPressed: (){
                      widget.model.resetlist();
                      widget.controllerserch.text="";
                    },
                    icon: Icon(Icons.restore,size: 30,color: KprimaryColor,),
                  ),
                ),

              ) ,
            ),
          ),
        ],
      ),
    );
  }
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes="";
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    } on PlatformException {
      setState(() {
        widget.controllerserch.text = "";
      });
    }
    if (!mounted) return;
    setState(() {
      switch(barcodeScanRes){
        case "-1":
          widget.controllerserch.text="";
          break;
        default:
          widget.controllerserch.text = barcodeScanRes;
          widget.model.serch_inlist(Radio_P_Store, barcodeScanRes);
          break;
      }

    });
  }
}


