
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mange_store/Models/ProductBuy.dart';
import 'package:mange_store/Models/Suplier.dart';
import 'package:mange_store/Widget/BottomBar.dart';
import 'package:mange_store/Widget/Header_Table.dart';
import 'package:provider/src/provider.dart';
import '../constants.dart';

class Suplier_Products extends StatelessWidget{
  Suplier suplier;
  Suplier_Products({required this.suplier});
 // TextEditingController _Barcodeserch_c=TextEditingController();
 //  @override
 //  void didChangeDependencies() {
 //    context
 //        .read(weatherStateNotifierProvider)
 //        .getDetailedWeather(widget.masterWeather.cityName);
 //    super.didChangeDependencies();
 //  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Future.delayed(
        Duration.zero,
            () => Provider.of<ProductBuy>(context,listen: false).get_porducts_bySuplier(suplier.No));
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: KprimaryColor,
            title: Text(
              "المنتجات الموردة من ${suplier.Name}",
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
                Header_Table(["الصورة","اسم الصنف","اسم المورد"]),
                Expanded(child: Container(
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
                        if (context.watch<ProductBuy>().list[index].isserch){
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
                                        .list[index].linkphoto}"), width: 80,
                                        height: 60,
                                        fit: BoxFit.cover),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: ListTile(
                                      minVerticalPadding: 0,
                                      trailing: IconButton(
                                          splashColor: KprimaryColor,
                                          onPressed: () {},
                                          icon: Icon(Icons.microwave, size: 30,
                                            color: KsecondaryColor,)),
                                      title: Text('${context
                                          .watch<ProductBuy>()
                                          .list[index].Product_Name}',
                                          style: B_12_G()),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                            'المورد : ${context
                                                .watch<ProductBuy>()
                                                .list[index]
                                                .Suplier_Name} - الكمية:   ${context
                                                .watch<ProductBuy>()
                                                .list[index].Quntity}',
                                            style: B_10_G(),
                                          ),
                                          Text(
                                            'السعر: ${context
                                                .watch<ProductBuy>()
                                                .list[index]
                                                .Price} - التاريخ :${context
                                                .watch<ProductBuy>()
                                                .list[index].DateBuy}',
                                            style: B_10_G(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return Divider(
                            color: KbgColor, height: 0.0, thickness: 0.0,);
                        }
                    },),
                ))
              ]),
          bottomNavigationBar: BottomBar(() {
            // final snackbar=SnackBar(
            //   behavior: SnackBarBehavior.floating,
            //   content: Text('Text label'),
            //   action: SnackBarAction(
            //     label: 'Action',
            //     onPressed: () {},
            //   ),
            // );
            // Scaffold.of(context).showSnackBar(snackbar);
          }, (){

          }),
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add_chart),
              backgroundColor: Colors.lime[900],
              onPressed: () {
                // Provider.of<ListSupliers>(context,listen: false).initial();
                // var _nv= Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => NewProdactBuy_Screen()));
                // _nv.then((value) => context.read<ProductBuy>().resetlist());
              }),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        ));
  }
  File _getfile(String filename){
    File file = new File("/storage/emulated/0/Prodactsphoto/"+filename+".jpg");
    return file;
  }
}
