import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mange_store/DB/DBHelper.dart';
import 'package:mange_store/Models/ProductBuy.dart';
import 'package:mange_store/Models/Suplier.dart';
import 'package:mange_store/Widget/BottomBar.dart';
import 'package:mange_store/Widget/Header_Table.dart';
import 'package:mange_store/Widget/Fild_Serch.dart';
import 'package:mange_store/constants.dart';
import 'package:provider/src/provider.dart';
import 'NewProdactBuy_Screen.dart';

class ProductsStore_Screen extends StatelessWidget{
  TextEditingController _Barcodeserch_c=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
         appBar: AppBar(
         backgroundColor: KprimaryColor,
         title: Text(
            "حركـة توريـد الأصناف",
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
                     child: Fild_Scrch(
                       type: 1,
                       controllerserch:_Barcodeserch_c,
                       model:context.read<ProductBuy>(),
                       iscastmer:false,
                     ),
                   ),
                   Header_Table(["الصورة","تفاصيل المنتج","تعديل "]),
                   Expanded(child: Prodactsstore_list())
                 ]),
        bottomNavigationBar: BottomBar(() {

        }, (){
          context.read<ProductBuy>().resetlist();
          _Barcodeserch_c.text="";
        }),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add_chart),
            backgroundColor: Colors.lime[900],
            onPressed: () {
              Provider.of<ListSupliers>(context,listen: false).initial();
             var _nv= Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewProdactBuy_Screen()));
              _nv.then((value) => context.read<ProductBuy>().resetlist());
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ));
  }
}
class Prodactsstore_list extends StatelessWidget{
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
        itemCount:context.watch<ProductBuy>().list.length,
        itemBuilder: (context, index){
          if(context.watch<ProductBuy>().list[index].isserch) {
            return Container(
              height: 70,
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: Image.file(_getfile("${context
                                        .watch<ProductBuy>()
                                        .list[index].linkphoto}"), width: 80, height: 60,fit: BoxFit.cover),
                       ),
                    Expanded(
                      flex:6,
                      child: ListTile(
                        minVerticalPadding: 0,
                        trailing: IconButton(
                          splashColor: KprimaryColor,
                            onPressed: (){
                            showdilogproductbuy(context,Provider.of<ProductBuy>(context,listen: false)
                                .list[index]);
                            },
                            icon:Icon(Icons.microwave,size: 30,color: KsecondaryColor,)),
                        title:  Text('${context
                                        .watch<ProductBuy>()
                                        .list[index].Product_Name}',style: B_12_G()),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'المورد : ${context
                                  .watch<ProductBuy>()
                                  .list[index].Suplier_Name} - الكمية:   ${context
                                  .watch<ProductBuy>()
                                  .list[index].Quntity}',
                              style: B_10_G(),
                            ),
                            Text(
                              'السعر: ${context
                                  .watch<ProductBuy>()
                                  .list[index].Price} - التاريخ :${context
                                  .watch<ProductBuy>()
                                  .list[index].DateBuy}',
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
  void showdilogproductbuy(BuildContext context,ProductBuy _brodctbuy){
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
              KbgColor,
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
              child: Text("حذف بيانات التوريد",style: B_12_W(),),
            ),
            titlePadding: EdgeInsets.only(top: 10),
            backgroundColor:KbgColor,
            contentPadding:
            EdgeInsets.only(
                top: 5,left: 5,right: 5,
                bottom: 5),

            content:Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("هل تود حذف بيانات التوريد هذة"),
                Text("اسم المنتج : ${_brodctbuy.Product_Name}"),
                Text("مورد من  : ${_brodctbuy.Suplier_Name}"),
                Text("بسعر   : ${_brodctbuy.Price}"),
                Text("العدد   : ${_brodctbuy.Quntity}"),
                Text("التاريخ   : ${_brodctbuy.DateBuy}"),
              ],
            ),

            actionsAlignment:MainAxisAlignment.spaceAround ,
            actions: <Widget>[
              FlatButton(
                color: KaccentColor,
                textColor: Colors.red,
                child: Text('حذف'),
                onPressed: () async {
                   int i=await DBH.dH.get_db.delete("StoreBuy",where: "No=?",whereArgs: [_brodctbuy.No]);
                   if(i>0){
                     Provider.of<ProductBuy>(context,listen: false).reinitial();
                     Navigator.of(context)
                         .pop();
                   }
                },
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('خروج'),
                onPressed: () {
                  Navigator.of(context)
                      .pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}