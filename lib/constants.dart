import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

var KprimaryColor = Color(0xFF33691E);
var KsecondaryColor = Color(0xFF827717);
var KaccentColor = Colors.lime;
var Kwhite = Colors.white;
var KbgColor = Color(0xFFfff8e1);
var KCardColor = Color(0xFFf0f4c3);
var KbrunColor = Color(0xFFb26500);
var KTextColor = Color(0xFF3e2723);

//--------------------------------------------------
const int la = 1;
const defaultPadding = 8.0;
int Radio_P_Store=1;
//--------------------------------------------------
TextStyle B_12_W() {
  return TextStyle(
      fontFamily: "ALAWI-3-67",fontSize: 12, fontWeight: FontWeight.bold, color: Kwhite);
}

TextStyle B_25_W() {
  return TextStyle(
      fontFamily: "ALAWI-3-67",
      fontSize: 25,
      fontWeight: FontWeight.bold,
      color: Kwhite);
}

TextStyle B_12_G() {
  return TextStyle(fontFamily: "ALAWI-3-67",
      fontSize: 12, fontWeight: FontWeight.bold, color: KprimaryColor);
}

TextStyle B_10_G() {
  return TextStyle(fontFamily: "ALAWI-3-67",
      fontSize:10, fontWeight: FontWeight.bold, color: KprimaryColor);
}
TextStyle B_10_W() {
  return TextStyle(fontFamily: "ALAWI-3-67",
      fontSize:10, fontWeight: FontWeight.bold, color: Kwhite);
}
TextStyle B_16_G() {
  return TextStyle(fontFamily: "ALAWI-3-67",
      fontSize: 16, fontWeight: FontWeight.bold, color: KprimaryColor);
}
TextStyle B_16_W() {
  return TextStyle(fontFamily: "ALAWI-3-67",
      fontSize: 16, fontWeight: FontWeight.bold, color: Kwhite);
}
TextStyle B_16_B() {
  return const TextStyle(
    decoration: TextDecoration.none,
      fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black);
}
void showtost(BuildContext context,String txt){
  showCupertinoDialog(context: context,
      barrierDismissible: true,
      useRootNavigator: true,
      builder:(context){
        return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 20,left: 20,right: 20),
                    padding: EdgeInsets.only(top: 10,bottom: 10,right: 20,left: 10),
                    decoration: BoxDecoration(
                      color: Kwhite,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(color: Colors.red,width:2),
                      boxShadow: [BoxShadow(offset:Offset(10,10),blurRadius:50, color: Colors.lightGreen)],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Container(

                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.all(Radius.circular(50)),
                                border: Border.all(color: Colors.red,width:2)
                            ),

                            child: GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                                child: Icon(Icons.clear,color: Kwhite,))),
                        Text(txt,style: B_16_B(),),
                      ],
                    )),

                ] );

      } );
}
