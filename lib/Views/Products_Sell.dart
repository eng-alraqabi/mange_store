import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mange_store/Models/Castmer.dart';
import 'package:mange_store/Models/ProductSell.dart';
import 'package:mange_store/Widget/BottomBar.dart';
import 'package:mange_store/Widget/Header_Table.dart';
import 'package:mange_store/Widget/Fild_Serch.dart';
import 'package:mange_store/constants.dart';
import 'package:provider/src/provider.dart';
import 'NewProdactSell_Screen.dart';

class Products_Sell extends StatelessWidget{
  TextEditingController _Barcodeserch_c=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: KprimaryColor,
            title: Text(
              "حركـة مبيعات الأصناف",
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
                    type: 2,
                    controllerserch:_Barcodeserch_c,
                    model:context.read<ProductSell>(),
                    iscastmer:false,
                  ),
                ),
                Header_Table(["الصورة","تفاصيل المنتج","تعديل"]),
                Expanded(child: Prodactssell_list())
              ]),
          bottomNavigationBar: BottomBar(() {

          }, (){
            context.read<ProductSell>().resetlist();
            _Barcodeserch_c.text="";
          }),
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add_chart),
              backgroundColor: Colors.lime[900],
              onPressed: () {
                Provider.of<ListCastmers>(context,listen: false).initial();
                var _nv= Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewProdactSell_Screen()));
                _nv.then((value) => context.read<ProductSell>().resetlist());
              }),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        ));
  }
}
class Prodactssell_list extends StatelessWidget{
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
        itemCount:context.watch<ProductSell>().list.length,
        itemBuilder: (context, index){
          if(context.watch<ProductSell>().list[index].isserch) {
            return Container(
              height: 70,
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Image.file(_getfile("${context
                          .watch<ProductSell>()
                          .list[index].linkphoto}"), width: 80, height: 60,fit: BoxFit.cover),
                    ),
                    Expanded(
                      flex:6,
                      child: ListTile(
                        minVerticalPadding: 0,
                        trailing: IconButton(
                            splashColor: KprimaryColor,
                            onPressed: (){

                            },
                            icon:Icon(Icons.microwave,size: 30,color: KsecondaryColor,)),
                        title:  Text('${context
                            .watch<ProductSell>()
                            .list[index].Product_Name}',style: B_12_G()),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'العميل : ${context
                                  .watch<ProductSell>()
                                  .list[index].Castmer_Name} - الكمية:   ${context
                                  .watch<ProductSell>()
                                  .list[index].Quntity}',
                              style: B_10_G(),
                            ),
                            Text(
                              'السعر: ${context
                                  .watch<ProductSell>()
                                  .list[index].Price} - التاريخ :${context
                                  .watch<ProductSell>()
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
  }}

