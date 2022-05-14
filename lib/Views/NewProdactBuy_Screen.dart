import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:mange_store/DB/DBHelper.dart';
import 'package:mange_store/Models/ProductBuy.dart';
import 'package:mange_store/Models/Suplier.dart';
import 'package:mange_store/Models/Product.dart';
import 'package:mange_store/Models/Suplier.dart';
import 'package:mange_store/Widget/BottomBar.dart';
import 'package:provider/src/provider.dart';
import 'package:sqflite/sqflite.dart';
import '../constants.dart';

class NewProdactBuy_Screen extends StatefulWidget {
  @override
  _NewProdactBuy_ScreenState createState() => _NewProdactBuy_ScreenState();
}

class _NewProdactBuy_ScreenState extends State<NewProdactBuy_Screen> {
  List<Map<String,dynamic>> _listSelectproduct=[];
  List<Map<String,dynamic>> _listTosaveproduct=[];
  // List<Product> _listprodsorce=[];
  // List<Suplier>  _listSuplier=[];
  // late Database _db;
  int _NoSuplier=0;
  int _NoProduct=0;
  int _Quntity=0;
  int _price=0;
  String _DateBuy="${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}";
  int _BarcodProduct=0;
  TextEditingController _name_cont=TextEditingController();
  TextEditingController _nameprod_cont=TextEditingController();
  TextEditingController _Price_cont=TextEditingController();
  TextEditingController _Qntity_cont=TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: KCardColor,
          appBar: AppBar(
            backgroundColor: KprimaryColor,
            title: Text(
              "أصناف واردة بفواتير مبيعات",
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                foreground: Paint()..color = Colors.white,
              ),
            ),
          ),
          body:  ListView(
            padding: EdgeInsets.only(top: 0, left: 10, right: 10),
            children: [
              SizedBox(height: 20,),
              Row(

                children: [
                  //------------------------------------- رقم فاتورة المورد )
                  Flexible(
                    child: TextFormField(
                      cursorColor: KprimaryColor,
                    //  readOnly: castmearname_nagdy_bool,
                      controller: _name_cont,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Kwhite.withOpacity(0.8),
                        border:OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide: BorderSide(color: KprimaryColor, width: 2),
                        ),
                        contentPadding: EdgeInsets.all(5),
                        helperStyle: TextStyle(fontSize: 8),
                        labelText:"اسم المورد",
                        prefixIcon: Icon(Icons.person_sharp,color:KaccentColor,),
                        suffixIcon: IconButton(
                            icon: Icon(
                              Icons.view_list_outlined,
                            ),
                            color: KprimaryColor,
                            onPressed: () {
                             listSuplier();
                            }),
                        labelStyle: TextStyle(
                          color: KprimaryColor,
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

                  SizedBox(
                    width: 10,
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.date_range_sharp,
                      ),
                      color: KprimaryColor,
                      onPressed: () async {
                       DateTime? date=await _selectDate();
                       setState(() {
                         _DateBuy="${date?.year}/${date?.month}/${date?.day}";
                       });
                      }),
                  SizedBox(
                    width: 5,
                  ),
                  //-------------------------------date pill
                  Column(
                    children: [
                      Text(
                        "تاريخ الفاتورة",
                        style: TextStyle(
                            color: KprimaryColor,
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _DateBuy,
                        style: TextStyle(
                            color: KprimaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              //-------------------------------------(كود الصنف)
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: _nameprod_cont,
                  keyboardType: TextInputType.text,
                  cursorColor: KprimaryColor,
                  onEditingComplete: () {
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: KprimaryColor, width: 2),
                    ),
                    filled: true,
                    fillColor: Kwhite.withOpacity(0.8),
                    contentPadding: EdgeInsets.only(left:10,bottom: 5,right: 15,top: 5),
                    labelText: "أسم الصنف",
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(left:10),
                      child: IconButton(
                        splashColor: KprimaryColor,
                        onPressed: (){
                          listPorduct();
                        },
                        icon: Icon(Icons.search,color: KprimaryColor,),
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: KprimaryColor.withOpacity(0.5),
                      fontFamily: "Cairo",
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    prefixIcon: IconButton(
                        onPressed: (){
                          scanBarcodeNormal();
                        },
                        icon:Icon(Icons.qr_code)),
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
              SizedBox(
                height: 5,
              ),
              Row(

                children: [
                  SizedBox(width: 10,),
                  Expanded(
                    child: TextField(

                      controller: _Qntity_cont,
                      cursorColor: KprimaryColor,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Kwhite.withOpacity(0.8),
                        border:OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide: BorderSide(color: KprimaryColor, width: 2),
                        ),
                        contentPadding: EdgeInsets.zero,
                        helperStyle: TextStyle(fontSize: 8),
                        labelText:"عدد الأصناف",
                        prefixIcon: Icon(Icons.add),
                        labelStyle: TextStyle(
                          color: KprimaryColor,
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
                  SizedBox(width: 20,),
                  Expanded(
                    child: TextField(
                      controller: _Price_cont,
                      cursorColor: KprimaryColor,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Kwhite.withOpacity(0.8),
                        border:OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide: BorderSide(color: KprimaryColor, width: 2),
                        ),
                        contentPadding: EdgeInsets.zero,
                        helperStyle: TextStyle(fontSize: 8),
                        prefixIcon: Icon(Icons.monetization_on),
                        labelText:"سعر الصنف",
                        labelStyle: TextStyle(
                          color: KprimaryColor,
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
                  SizedBox(width: 10,),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              RaisedButton(
                highlightElevation: 5,
                splashColor: KaccentColor,
                elevation: 10,
                color: KprimaryColor,
                child: Icon(Icons.add_shopping_cart_outlined,color: Kwhite,),
                  onPressed: (){
                  if(_BarcodProduct!=0 && _Qntity_cont.text.isNotEmpty && _Price_cont.text.isNotEmpty){
                    Map<String,dynamic> _mapshow={
                      "Barcode":_BarcodProduct,
                      "Name":_nameprod_cont.value.text,
                      "Quntity":_Qntity_cont.value.text,
                      "Price":_Price_cont.value.text,
                    };
                    Map<String,dynamic> _mapsave={
                      "Product_No":_NoProduct,
                      "Suplier_No":_NoSuplier,
                      "Quntity":_Qntity_cont.value.text,
                      "Price":_Price_cont.value.text,
                      "DateBuy":_DateBuy,
                    };
                    setState(() {
                      _listTosaveproduct.add(_mapsave);
                      _listSelectproduct.add(_mapshow);
                      _name_cont.text="";
                      _nameprod_cont.text="";
                      _Price_cont.text="";
                      _Qntity_cont.text="";
                    });
                  }
                  }),
              //----------------------------------عناوين تفاصيل الأصناف في القائمة
              Container(
                color: KprimaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "كود الصنف",
                      style:
                      TextStyle(color: Kwhite, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "أسم الصنف",
                      style:
                      TextStyle(color: Kwhite, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      " الكمية",
                      style:
                      TextStyle(color: Kwhite, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "السعر",
                      style:
                      TextStyle(color: Kwhite, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              //----------------------------قائمة الأصناف في القائمة
              Container(
                color: Kwhite,

                padding: EdgeInsets.all(2),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _listSelectproduct.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          InkWell(child: Icon(Icons.delete,color: Colors.red,
                          ),onTap: (){
                            setState(() {
                              _listTosaveproduct.removeAt(index);
                              _listSelectproduct.removeAt(index);
                            });
                          },),
                          Text(_listSelectproduct[index]["Barcode"].toString()),
                          Text(_listSelectproduct[index]["Name"].toString()),
                          Text(_listSelectproduct[index]["Quntity"].toString()),
                          Text(_listSelectproduct[index]["Price"].toString()),
                        ],
                      );
                    }),
              ),
              //----------------------------خصم مشتريات /مبيعات
            ],
          ),
          bottomNavigationBar: BottomBar((){

            showtost(context,"محمد علي الرقابي");

          },(){}),floatingActionButton: FloatingActionButton(
            child: Icon(Icons.save),
            backgroundColor: KaccentColor,
            elevation: 5,
            focusColor: KprimaryColor,
            onPressed: () {
              if(_listTosaveproduct.length!=0){
                Future<bool> _is =_save();
                _is.then((value) => {
                  if(value){
                    _name_cont.text="",
                    _nameprod_cont.text="",
                    _Price_cont.text="",
                    _Qntity_cont.text="",
                    _listTosaveproduct.clear(),
                    _listSelectproduct.clear(),
                    setState(() {

                    }),
                    showtost(context,"تم الحفظ"),
                    Provider.of<ProductBuy>(context,listen: false).reinitial(),
                  }else{
                    showtost(context,"هناك خطاء"),
                  }
                });
              }else{
                showtost(context,"لاتوجد منتجات للحفظ");}

            }),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    ));
  }
  Future<DateTime?> _selectDate(){
    return showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2020), lastDate: DateTime(2099));
  }
  Future<bool> _save() async {
    List<int> _idlist=[];
    for(Map<String,dynamic> _mp in _listTosaveproduct){
     int _id=await DBH.dH.get_db.insert("StoreBuy", _mp);
     if(_id==0){
       for(int x in _idlist){
         await DBH.dH.get_db.delete("StoreBuy",where: 'No = ?', whereArgs: [x]);
       }
       return false;
     }
     _idlist.add(_id);
    }
    return  true;
  }
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes="";
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    } on PlatformException {
      setState(() {
        _nameprod_cont.text = "";
      });
    }
    if (!mounted) return;
    setState(() async {
      switch(barcodeScanRes){
        case "-1":
          _nameprod_cont.text="";
          break;
        default:
          List<Map<String, dynamic>> _list = await DBH.dH.get_db.query("Products",where:"Barcode LIKE ?",whereArgs: [barcodeScanRes]);
          _BarcodProduct=int.parse(_list.first["Barcode"]);
          _NoProduct=_list.first["No"];
          _nameprod_cont.text=_list.first["Name"];
          break;
      }

    });
  }
  void listSuplier(){
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
              color:KprimaryColor,
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
                  "أسماء الموردين",style: B_16_W(),),
            ),
            titlePadding: EdgeInsets.only(top: 10),
            backgroundColor:KprimaryColor,
            contentPadding:
            EdgeInsets.only(
                top: 5,
                bottom: 5),

            content:
            Container(
              height: 400,
              child: ListView.builder(
                itemCount:context
                    .watch<ListSupliers>()
                    .list.length,
                itemBuilder:(context, index){
                 return Container(
                   margin: EdgeInsets.only(bottom: 5,right: 10,left: 10),
                   decoration: BoxDecoration(
                     color: Kwhite,
                     border: Border.all(width:1,color: KprimaryColor),
                     borderRadius: BorderRadius.all(Radius.circular(20))
                   ),
                   child: ListTile(

                     selectedColor: KaccentColor,
                     trailing: IconButton(
                       splashColor: KaccentColor,
                       onPressed: (){
                         setState(() {
                           _name_cont.text =Provider.of<ListSupliers>(context,listen: false).list[index].Name.toString();
                           _NoSuplier = Provider.of<ListSupliers>(context,listen: false).list[index].No!;
                         });
                         Navigator.of(context)
                             .pop();
                       },
                       icon: Icon(Icons.check_circle,color: KprimaryColor,),
                     ),
                     title: Text("${context
                         .watch<ListSupliers>()
                         .list[index].Name}"),
                     leading: Icon(Icons.person_sharp,color: KprimaryColor,),
                   ),
                 );
                },

              ),
            ),

          ),
        );
      },
    );
  }
  void listPorduct(){
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
              color:KprimaryColor,
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
                "أسماء المنتجات",style: B_16_W(),),
            ),
            titlePadding: EdgeInsets.only(top: 10),
            backgroundColor:KprimaryColor,
            contentPadding:
            EdgeInsets.only(
                top: 5,
                bottom: 5),
            content:
            Container(
              height: 400,
              child: ListView.builder(
                itemCount:context
                    .watch<ProductBuy>()
                    .list.length,
                itemBuilder:(context, index){
                  return Container(
                    margin: EdgeInsets.only(bottom: 5,right: 10,left: 10),
                    decoration: BoxDecoration(
                        color: Kwhite,
                        border: Border.all(width:1,color: KprimaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: ListTile(

                      selectedColor: KaccentColor,
                      trailing: IconButton(
                        splashColor: KaccentColor,
                        onPressed: (){
                          setState(() {
                            _nameprod_cont.text =Provider.of<ProductBuy>(context,listen: false).list[index].Product_Name.toString();
                            _NoProduct = Provider.of<ProductBuy>(context,listen: false).list[index].Product_No;
                            _BarcodProduct=int.parse(Provider.of<ProductBuy>(context,listen: false).list[index].barcode);
                          });
                          Navigator.of(context)
                              .pop();
                        },
                        icon: Icon(Icons.check_circle,color: KprimaryColor,),
                      ),
                      title: Text("${context
                          .watch<ProductBuy>()
                          .list[index].Product_Name}"),
                      leading: Icon(Icons.person_sharp,color: KprimaryColor,),
                    ),
                  );
                },

              ),
            ),

          ),
        );
      },
    );
  }
}
