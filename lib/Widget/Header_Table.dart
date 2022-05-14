import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class Header_Table extends StatelessWidget {
  List<String> _list;
  Header_Table(this._list);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:1,left: 5,right: 5),
      //color: klightGreen900,
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0)),
        color: KsecondaryColor,
        shape: BoxShape.rectangle,
        boxShadow: [BoxShadow(blurRadius: 5, color: Colors.white)],
      ),
      padding: EdgeInsets.only(top: 5, right: 5, left: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for(int i=0;i<_list.length;i++)
            Builder(
            builder: (context){
                return Expanded(
                  child: Center(
                    child: Text(_list[i],
                        style:  TextStyle(
                            color: Kwhite,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0)),
                  ),
                );
          },),
        ],
      ),
    );
  }
}
