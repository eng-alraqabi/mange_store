import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import '../constants.dart';

class Fild_Scrch extends StatefulWidget {
  int type;
  TextEditingController controllerserch;
  final model;
  final bool iscastmer;
  Fild_Scrch({required this.type ,required this.controllerserch, required this.model,required this.iscastmer});

  @override
  _Fild_ScrchState createState() => _Fild_ScrchState();
}

class _Fild_ScrchState extends State<Fild_Scrch> {

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
                    Text(widget.iscastmer?"رقم الجوال":"الباركود",style: B_10_W()),
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
                    Text(widget.iscastmer?"الأســــم":"اسم الصنف",style: B_10_W()),
                  ],
                ),
              ),
              widget.iscastmer?SizedBox(width: 0,):Expanded(
                flex: 2,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    Radio(
                      fillColor:MaterialStateProperty.all(Color(0xFFFFFFFF)),
                      value: 3,
                      groupValue: Radio_P_Store,
                      onChanged: (value) {
                        setState(() {
                          Radio_P_Store = value as int;
                        });
                      },
                      activeColor:KprimaryColor,
                    ),
                    Text(widget.type==1?"المورد":"العميل",style: B_10_W()),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom:5,left: 5,right: 5),
            child: TextFormField(
              controller:widget.controllerserch,
              readOnly: (Radio_P_Store==1 && !widget.iscastmer)?true:false,
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
                icon:widget.iscastmer?null:IconButton(
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
