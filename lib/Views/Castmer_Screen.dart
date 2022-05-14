import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mange_store/Models/Castmer.dart';
import 'package:mange_store/Widget/BottomBar.dart';
import 'package:mange_store/Widget/Fild_Serch.dart';
import 'package:mange_store/Widget/Header_Table.dart';
import 'package:mange_store/constants.dart';
import 'package:provider/src/provider.dart';
class Castmers_Screen extends StatelessWidget {
  TextEditingController _Barcodeserch_c = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: KprimaryColor,
              title: Text(
                "قائمــة العملاء",
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
                      model: context.read<ListCastmers>(),
                      iscastmer: true,
                  ),
                ),
                Header_Table(["العميـــــل", "    ", "   ", "تعديل"]),
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
Castmer_Dailog(BuildContext context,Castmer? castmer,int index){
  TextEditingController name_con=TextEditingController();
  TextEditingController phone_con=TextEditingController();
  TextEditingController address_con=TextEditingController();
  showDialog<void>(
    context: context,
    useSafeArea: false,
    barrierDismissible:
    false, // user must tap button!
    builder: (BuildContext context) {
      if(castmer!=null){
        name_con.text=castmer.Name!;
        phone_con.text=castmer.Phone!.toString();
        address_con.text=castmer.Address!;
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
              child: Text("${castmer==null?'انشاء عميل جديد':'تعديل بيانات العميل'}"),
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
              _Fildinput("أسم العميل",name_con),
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
              child: Text(castmer==null?'حفظ':'تعديل'),
              onPressed: () async {
                if(castmer==null){
                  Castmer _cas=Castmer(name_con.value.text,int.parse(phone_con.value.text), address_con.value.text);
                  bool result= await context.read<ListCastmers>().add_tolist(_cas);
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
                  bool result= await context.read<ListCastmers>().update_onlist(index,map);
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
        itemCount:context.watch<ListCastmers>().list.length,
        itemBuilder: (context, index){
          if(context.watch<ListCastmers>().list[index].isserch) {
            return Card(
              margin: EdgeInsets.all(1),
              clipBehavior: Clip.antiAlias,
              elevation: 2,
              child: ListTile(
                minVerticalPadding: 0,
                leading:CircleAvatar(
                  radius: 20,
                  child: Icon(Icons.person_sharp),
                  backgroundColor: KsecondaryColor,
                ),
                trailing: InkWell(
                    splashColor:KprimaryColor,
                    onTap: (){
                      Castmer_Dailog(context,
                          Provider.of<ListCastmers>(context,listen: false).list[index]
                          ,index);
                    },
                    child: Icon(Icons.microwave,size:25,color: KsecondaryColor,)),
                title:  Text('${context
                    .watch<ListCastmers>()
                    .list[index].Name}',style: B_12_G()),
                subtitle: Text(
                  ' الرقم : ${context
                      .watch<ListCastmers>()
                      .list[index].Phone} - العنوان :   ${context
                      .watch<ListCastmers>()
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

