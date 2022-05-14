import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mange_store/Models/ProductBuy.dart';
import 'package:mange_store/Models/Suplier.dart';
import 'package:mange_store/Views/Suplier_Products.dart';
import 'package:mange_store/Widget/BottomBar.dart';
import 'package:mange_store/Widget/Fild_Serch.dart';
import 'package:mange_store/Widget/Header_Table.dart';
import 'package:mange_store/constants.dart';
import 'package:provider/src/provider.dart';
class Supliers_Screen extends StatelessWidget {
  TextEditingController _Barcodeserch_c = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: KprimaryColor,
          title: Text(
            "قائمــة الموردين",
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..color = Colors.white,
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
              child: Fild_Scrch(
                type: 1,
                controllerserch: _Barcodeserch_c,
                model: context.read<ListSupliers>(),
                iscastmer: true,
              ),
            ),
            Header_Table(["المـــــورد", "    ", "   ", "تعديل"]),
            Expanded(child: Prodactsstore_list())
          ],
        ),
        bottomNavigationBar: BottomBar((){}, (){}),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: KaccentColor,
            onPressed: () {
              Castmer_Dailog(context,null,0);
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
Castmer_Dailog(BuildContext context,Suplier? suplier,int index){
  TextEditingController name_con=TextEditingController();
  TextEditingController phone_con=TextEditingController();
  TextEditingController address_con=TextEditingController();
  showDialog<void>(
    context: context,
    useSafeArea: false,
    barrierDismissible:
    false, // user must tap button!
    builder: (BuildContext context) {
      if(suplier!=null){
        name_con.text=suplier.Name!;
        phone_con.text=suplier.Phone!.toString();
        address_con.text=suplier.Address!;
      }
      return Directionality(
        textDirection:
        TextDirection.rtl,
        child: AlertDialog(
          titleTextStyle: B_16_W(),
          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.all(
                  Radius.circular(
                      10.0))),
          title: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              color: KprimaryColor,
              shape: BoxShape.rectangle,
              boxShadow: [BoxShadow(blurRadius: 5, color: Colors.white)],
            ),
            child: Center(
              child: Text("${suplier==null?'انشاء مورد جديد':'تعديل بيانات المورد'}"),
            ),
          ),
          titlePadding: EdgeInsets.all(10),
          backgroundColor:KaccentColor,
          contentPadding:
          EdgeInsets.only(
              top: 5,left: 5,right: 5,
              bottom: 5),
          content:
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _Fildinput("أسم المورد",name_con),
              SizedBox(height: 5,),
              _Fildinput("رقم الجوال",phone_con),
              SizedBox(height: 5,),
              _Fildinput(" العنوان",address_con),
            ],
          ),
          actionsAlignment:MainAxisAlignment.spaceAround ,
          actions: <Widget>[
            FlatButton(
              color: KprimaryColor,
              textColor: Colors.white,
              child: Text(suplier==null?'حفظ':'تعديل'),
              onPressed: () async {
                if(suplier==null){
                  Suplier _cas=Suplier(name_con.value.text,int.parse(phone_con.value.text), address_con.value.text);
                  bool result= await context.read<ListSupliers>().add_tolist(_cas);
                  if(result){
                    Navigator.of(context)
                        .pop();
                  }
                }else{
                  Map<String ,dynamic>map={
                    "Name":name_con.value.text,
                    "Phone":int.parse(phone_con.value.text),
                    "Address":address_con.value.text,
                  };
                  bool result= await context.read<ListSupliers>().update_onlist(index,map);
                  if(result){
                    Navigator.of(context)
                        .pop();
                  }
                }
              },
            ),
            FlatButton(
              color: Colors.red,
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

Widget _Fildinput(String label,TextEditingController contr){
  return  Flexible(
    child: TextFormField(
      cursorColor: KprimaryColor,
      controller: contr,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.all(5),
        helperStyle: TextStyle(fontSize: 8),
        labelText:
        label,
        filled: true,
        fillColor: Kwhite.withOpacity(0.8),
        labelStyle: TextStyle(
          color: KprimaryColor,
          fontFamily: "Cairo",
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(color: KprimaryColor, width: 2),
        ),
      ),
    ),
  );
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
        itemCount:context.watch<ListSupliers>().list.length,
        itemBuilder: (context, index){
          if(context.watch<ListSupliers>().list[index].isserch) {
            return Card(
              margin: EdgeInsets.all(1),
              clipBehavior: Clip.antiAlias,
              elevation: 2,
              child: ListTile(
                minVerticalPadding: 0,
                leading:InkWell(
                  onTap: (){
                    Castmer_Dailog(context,
                        Provider.of<ListSupliers>(context,listen: false).list[index]
                        ,index);
                  },
                  child: CircleAvatar(
                    radius: 20,
                    child: Icon(Icons.person_sharp),
                    backgroundColor: KsecondaryColor,
                  ),
                ),
                trailing: TextButton.icon(
                   style: ButtonStyle(
                       foregroundColor:MaterialStateProperty.all(KprimaryColor) ),
                    onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Suplier_Products(suplier: Provider.of<ListSupliers>(context,listen: false).list[index])));
                },  label:Text("عرض "),icon: Icon(Icons.microwave),),
                    //Icon(Icons.microwave,size:25,color: KsecondaryColor,)),
                title:  Text('${context
                    .watch<ListSupliers>()
                    .list[index].Name}',style: B_12_G()),
                subtitle: Text(
                  ' الرقم : ${context
                      .watch<ListSupliers>()
                      .list[index].Phone} - العنوان :   ${context
                      .watch<ListSupliers>()
                      .list[index].Address}',
                  style: B_10_G(),
                ),
              ),
            );
          }else{
            return Divider(color: KbgColor,height: 0.0,thickness: 0.0,);
          }
        },),
    );
  }
}



//
//
// class Suplierss_Screen extends StatefulWidget {
//   @override
//   _Supliers_ScreenState createState() => _Supliers_ScreenState();
// }
//
// class _Supliers_ScreenState extends State<Suplierss_Screen> {
//   late Database _db;
//   List<Person> _listPerson = [];
//   int val=1;
//   TextEditingController _Barcodeserch_c=TextEditingController();
//   Future<void> getPerson() async {
//     try {
//       _db = await DBH.dH.get_db;
//       List<Map<String, dynamic>> _list = await _db.rawQuery("SELECT * FROM Supliers;");
//       for (int i = 0; i < _list.length; i++) {
//         Person _cv =  Person.fromMap(_list[i]);
//         _listPerson.add(_cv);
//       }
//     }  catch (e) {
//
//     }
//     setState(() {
//       _listPerson;
//     });
//   }
//   Future<void> serchProdact(String  serch) async {
//     String mod="";
//     switch(val){
//       case 1:
//         mod="Phone LIKE ?";
//         break;
//       case 2:
//         mod="Name LIKE ?";
//         break;
//     }
//     try {
//
//       List<Map<String, dynamic>> _list = await _db.query("Supliers",where:mod,whereArgs: [serch]);
//       if(!_list.isEmpty){
//         _listPerson.clear();
//       }
//       for (int i = 0; i < _list.length; i++) {
//         Person _cv =  Person.fromMap(_list[i]);
//         _listPerson.add(_cv);
//       }
//     }  catch (e) {
//     }
//     setState(() {
//       _listPerson;
//     });
//   }
//   Future<List<Person>> _setbulidrs()async{
//     return  _listPerson;
//   }
//   @override
//   void initState() {
//     getPerson();
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: KprimaryColor,
//           title: Text(
//             "قائمــة الموردين",
//             textAlign: TextAlign.right,
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               foreground: Paint()..color = Colors.white,
//             ),
//           ),
//         ),
//         body: Column(
//           children: [
//             _SerchFild(),
//             Container(
//               margin: EdgeInsets.only(top:1,left: 5,right: 5),
//               //color: klightGreen900,
//               height: 35,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(25.0),
//                     topRight: Radius.circular(25.0)),
//                 color: KsecondaryColor,
//                 shape: BoxShape.rectangle,
//                 boxShadow: [BoxShadow(blurRadius: 5, color: Colors.white)],
//               ),
//               padding: EdgeInsets.only(top: 5, right: 5, left: 15),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Expanded(
//                     flex: 2,
//                     child: Center(
//                       child: Text("اسم المورد",
//                           style: new TextStyle(
//                               color: Kwhite,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 12.0)),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 2,
//                     child: Center(
//                       child: Text("رقم المــورد",
//                           style: new TextStyle(
//                               color: Kwhite,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 12.0)),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 2,
//                     child: Center(
//                       child: Text("العنـــوان",
//                           style: new TextStyle(
//                               color: Kwhite,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 12.0)),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//                 child: _Builderlist()
//             ),
//
//           ],
//         ),
//         bottomNavigationBar: BottomBar(() {}, (){setState((){});}),
//         floatingActionButton: FloatingActionButton(
//             child: Icon(Icons.add_chart),
//             backgroundColor: Colors.lime[900],
//             onPressed: () {
//               _insertshow();
//             }),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       ),
//     );
//   }
//
//   Widget _Builderlist(){
//     return FutureBuilder<List<Person>>(
//       future: _setbulidrs(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return ListView.builder(
//               shrinkWrap: true,
//               addAutomaticKeepAlives: true,
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 return InkWell(
//                   onLongPress: (){
//                     //showalrt(_listPerson[index]);
//                   },
//                   child: Container(
//                     margin: EdgeInsets.only(left:5,right: 5),
//                     color: KbgColor,
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment:
//                           MainAxisAlignment.spaceAround,
//                           children: [
//
//                             Text("${_listPerson[index].Name}",
//                                 textAlign: TextAlign.center,
//                                 style: new TextStyle(
//                                     color: Colors.lightGreen[900],
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 12.0)),
//                             Text("${_listPerson[index].Phone.toString()}",
//                                 textAlign: TextAlign.center,
//                                 style: new TextStyle(
//                                     color: Colors.lightGreen[900],
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 12.0)),
//                             Text(
//                                 "${_listPerson[index].Address}",
//                                 textAlign: TextAlign.center,
//                                 style: new TextStyle(
//                                     color: Colors.lightGreen[900],
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 12.0)),
//
//
//                             IconButton(
//                               onPressed: () {
//                 showDialog<void>(
//                 context: context,
//                 useSafeArea: false,
//                 barrierDismissible:
//                 false, // user must tap button!
//                 builder: (BuildContext context) {
//                   return AlertDialog(
//                     backgroundColor: KbgColor,
//                     titleTextStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),
//                     title: Center(child: Text("تاكيد الحذف")),
//                     content: Text(
//                         "هل تريد حذف المورد : ${_listPerson[index]
//                             .Name}"),
//                     actionsAlignment: MainAxisAlignment.start,
//                     actions: [
//                       FlatButton(
//                         color: Colors.red,
//                         textColor: Colors.white,
//                         child: Text('حذف'),
//                         onPressed: () async {
//                           int y = await _listPerson[index].Delet(
//                               _db, "Supliers");
//                           if (y != -1) {
//                             Navigator.of(context)
//                                 .pop();
//                             setState(() {
//                               _listPerson.clear();
//                               getPerson();
//                             });
//                           }
//                         },
//                       ),
//                       FlatButton(
//                         color: Colors.green,
//                         textColor: Colors.white,
//                         child: Text('الغاء'),
//                         onPressed: () {
//                           Navigator.of(context)
//                               .pop();
//                         },
//                       ),
//                     ],
//                   );
//                 });
//
//                               },
//                               icon: Icon(Icons.delete,color: Colors.red,)),
//
//                           ],
//                         ),
//                         Divider(
//                           color: KaccentColor,
//                           height: 2,
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               });
//         } else if (snapshot.data!.length == 0) {
//           return new Text("No Data found");
//         }
//         return new Container(
//           alignment: AlignmentDirectional.center,
//           child: new CircularProgressIndicator(),
//         );
//       },
//     );
//   }
//   void _insertshow(){
//     TextEditingController name_con=TextEditingController();
//     TextEditingController phone_con=TextEditingController();
//     TextEditingController address_con=TextEditingController();
//     showDialog<void>(
//       context: context,
//       useSafeArea: false,
//       barrierDismissible:
//       false, // user must tap button!
//       builder: (BuildContext context) {
//         return Directionality(
//           textDirection:
//           TextDirection.rtl,
//           child: AlertDialog(
//             titleTextStyle: TextStyle(
//               color:
//               Colors.lightGreen[900],
//               fontFamily: "Cairo",
//               fontWeight: FontWeight.bold,
//               fontSize: 15,
//             ),
//             shape: RoundedRectangleBorder(
//                 borderRadius:
//                 BorderRadius.all(
//                     Radius.circular(
//                         10.0))),
//             title: Center(
//               child: Text("إنشاء مورد جديد",style: B_12_W(),),
//             ),
//             titlePadding: EdgeInsets.only(top: 10),
//             backgroundColor:KprimaryColor,
//             contentPadding:
//             EdgeInsets.only(
//                 top: 5,left: 5,right: 5,
//                 bottom: 5),
//
//             content:
//             Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 _Fildinput("أسم المورد",name_con),
//                 SizedBox(height: 5,),
//                 _Fildinput("رقم الجوال",phone_con),
//                 SizedBox(height: 5,),
//                  _Fildinput(" العنوان",address_con),
//               ],
//             ),
//             actionsAlignment:MainAxisAlignment.spaceAround ,
//             actions: <Widget>[
//               FlatButton(
//                 color: KaccentColor,
//                 textColor: Colors.white,
//                 child: Text('حفظ'),
//                 onPressed: () async {
//                    Person _pers=Person.New(name_con.value.text,int.parse(phone_con.value.text), address_con.value.text);
//                    int y=await _pers.Insert(_db, "Supliers");
//                    if(y!=-1){
//                      Navigator.of(context)
//                          .pop();
//                      setState(() {
//                        _listPerson.clear();
//                        getPerson();
//                      });
//                    }
//                 },
//               ),
//               FlatButton(
//                 color: Colors.red,
//                 textColor: Colors.white,
//                 child: Text('خروج'),
//                 onPressed: () {
//                   Navigator.of(context)
//                       .pop();
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//   Widget _Fildinput(String label,TextEditingController contr){
//     return  Flexible(
//       child: TextFormField(
//         cursorColor: KprimaryColor,
//         controller: contr,
//         keyboardType: TextInputType.text,
//         textInputAction: TextInputAction.next,
//         decoration: InputDecoration(
//           border: OutlineInputBorder(),
//           contentPadding: EdgeInsets.all(5),
//           helperStyle: TextStyle(fontSize: 8),
//           labelText:
//            label,
//           filled: true,
//           fillColor: Kwhite.withOpacity(0.8),
//           labelStyle: TextStyle(
//             color: KprimaryColor,
//             fontFamily: "Cairo",
//             fontSize: 12,
//             fontWeight: FontWeight.bold,
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.all(Radius.circular(15)),
//             borderSide: BorderSide(color: KprimaryColor, width: 2),
//           ),
//         ),
//       ),
//     );
//   }
//   Widget _SerchFild(){
//
//     return Container(
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(15.0)),
//           color: KsecondaryColor.withOpacity(0.1),
//           shape: BoxShape.rectangle,
//           border: Border.all(width: 1,color: KprimaryColor)
//       ),
//       padding: EdgeInsets.all(5),
//       margin: EdgeInsets.only(top:5,bottom: 2,left: 5,right: 5),
//       child: Column(
//         children: [
//           Container(
//             height: 25,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Expanded(
//                     flex:1,
//                     child: Center(child: Text("بحث بـ:",style: B_12_G()))),
//                 Expanded(
//                   flex:1,
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//
//                       Radio(
//                         value: 1,
//                         groupValue: val,
//                         onChanged: (value) {
//                           setState(() {
//                             val = value as int;
//                           });
//                         },
//                         activeColor:KprimaryColor,
//                       ),
//                       Text("رقم الجوال",style: B_10_G()),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   flex: 1,
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//
//                       Radio(
//                         value: 2,
//                         groupValue: val,
//                         onChanged: (value) {
//                           setState(() {
//                             val = value as int;
//                           });
//                         },
//                         activeColor:KprimaryColor,
//                       ),
//                       Text("أسم المورد",style: B_10_G()),
//                     ],
//                   ),
//                 ),
//
//               ],
//             ),
//           ),
//           TextFormField(
//             controller:_Barcodeserch_c ,
//             decoration:InputDecoration(
//               label: Text("    بحـــث"),
//               floatingLabelStyle: TextStyle(
//                 color: KprimaryColor,
//               ),
//               floatingLabelBehavior:FloatingLabelBehavior.auto ,
//               enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: KsecondaryColor,width:2),
//                 borderRadius: BorderRadius.all( Radius.circular(20)),
//               ),
//               focusedBorder:OutlineInputBorder(
//                 borderSide: BorderSide(color:KprimaryColor,width:2),
//                 borderRadius: BorderRadius.all( Radius.circular(20)),
//               ),
//               fillColor: KbrunColor,
//               contentPadding: EdgeInsets.zero,
//               // icon:IconButton(
//               //   onPressed: (){
//               //     scanBarcodeNormal();
//               //   },
//               //   icon: Icon(Icons.qr_code_outlined,size:30,color: KprimaryColor,),
//               // ) ,
//               suffixIcon: Padding(
//                 padding: const EdgeInsets.only(left: 10.0),
//                 child: IconButton(
//                   onPressed: (){
//                     serchProdact(_Barcodeserch_c.value.text);
//
//                   },
//                   icon: Icon(Icons.search,size: 30,color: KprimaryColor,),
//                 ),
//               ),
//
//             ) ,
//           ),
//         ],
//       ),
//     );
//   }
// }
