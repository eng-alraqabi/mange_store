import 'package:flutter/foundation.dart';
import 'package:mange_store/DB/DBHelper.dart';

class StoreBuy{
  int? _No;
  int? _Product_No;
  int? _Suplier_No;
  int? _Quntity;
  int? _Price;
  String? _DateBuy;
  //static List<String> column=["No","Product_No","Suplier_No","Quntity","Price","DateBuy"];

  StoreBuy(this._No, this._Product_No, this._Suplier_No, this._Quntity,
      this._Price, this._DateBuy);
  StoreBuy.empty();
  StoreBuy.fromMap (Map<String, dynamic> data) {
    _No = data['No'];
    _Product_No = data['Product_No'];
    _Suplier_No = data['Suplier_No'];
    _Quntity = data['Quntity'];
    _Price = data['Price'];
    _DateBuy = data['DateBuy'];
  }
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["Product_No"] = _Product_No;
    map["Suplier_No"] = _Suplier_No;
    map["Quntity"] = _Quntity;
    map["Price"] = _Price;
    map["DateBuy"] = _DateBuy;
    return map;
  }

  String get DateBuy => _DateBuy!;
  int get Price => _Price!;
  int get Quntity => _Quntity!;
  int get Suplier_No => _Suplier_No!;
  int get Product_No => _Product_No!;
  int get No => _No!;
}
class ProductBuy extends StoreBuy with ChangeNotifier, DiagnosticableTreeMixin{

  String? _barcode;
  String? _Product_Name;
  String? _linkphoto;
  String? _Suplier_Name;
  int? _Total_mony;
  bool isserch=true;
  List<ProductBuy> _list=<ProductBuy>[];
  ProductBuy() : super.empty(){
    _list.clear();
    Future<List<Map<String, Object?>>> _listps=  DBH.dH.get_db.rawQuery("SELECT * FROM store_buy_move");
    _listps.then((value) => {
      for (int i = 0; i < value.length; i++) {
        _list.add(ProductBuy.fromMap(value[i])),
        notifyListeners(),
      }
    });
  }
  void reinitial(){
    _list.clear();
    Future<List<Map<String, Object?>>> _listps=  DBH.dH.get_db.rawQuery("SELECT * FROM store_buy_move");
    _listps.then((value) => {
      for (int i = 0; i < value.length; i++) {
        _list.add(ProductBuy.fromMap(value[i])),
        notifyListeners(),
      }
    });
  }
  List<ProductBuy> get list => _list;
  void resetlist(){
    _list.forEach((element) {element.isserch=true; });
    notifyListeners();
  }
   get_porducts_bySuplier(int? no) {
     for (int i = 0; i < _list.length; i++) {
       if (_list[i].Suplier_No == no) {
         _list[i].isserch = true;
         notifyListeners();
       } else {
         _list[i].isserch = false;
         notifyListeners();
       }
     }
     notifyListeners();
  }

  void serch_inlist(int val,String scrchtext){
    resetlist();
    switch(val){
      case 1:
        _list.forEach((element) {
          if(element.barcode!=scrchtext){
            element.isserch=false;
          }
        });
        break;
      case 2:
        _list.forEach((element) {
          if(!element.Product_Name.contains(scrchtext)){
            element.isserch=false;
          }
        });
        break;
      case 3:
        _list.forEach((element) {
          if(!element.Suplier_Name.contains(scrchtext)){
            element.isserch=false;
            notifyListeners();
          }
        });
        break;
    }
    notifyListeners();
  }
  Future<bool> add_tolist(StoreBuy _storebuy) async {
    int row=await DBH.dH.get_db.insert("StoreBuy",_storebuy.toMap());
    if(row>0){
      Future<List<Map<String, Object?>>> _listps=  DBH.dH.get_db.rawQuery("SELECT * FROM store_buy_move");
      _listps.then((value) => {
        for (int i = 0; i < value.length; i++) {
          _list.add(ProductBuy.fromMap(value[i])),
          notifyListeners(),
        }
      });
      return true;
    }else{
      return false;
    }
  }
  Future<bool> delet_fromlist(int no) async {
    int row=await DBH.dH.get_db.delete("StoreBuy",where: "No = ?",whereArgs: [no]);
    if(row>0){
      _list.removeWhere((element) => element.No==no);
      notifyListeners();
      return true;
    }else {
      return false;
    }
  }
  ProductBuy.set(
      _No,
      _Product_No,
      this._barcode,
      this._Product_Name,
      this._linkphoto,
      _Suplier_No,
      this._Suplier_Name,
      _Quntity,
      _Price,
      _DateBuy,
      this._Total_mony
      ) : super(_No, _Product_No, _Suplier_No, _Quntity, _Price, _DateBuy);


  ProductBuy.fromMap(Map<String, dynamic> data) : super.fromMap(data) {
    _barcode = data['barcode'];
    _Product_Name = data['Product_Name'];
    _linkphoto = data['linkphoto'];
    _Suplier_Name = data['Suplier_Name'];
    _Total_mony = data['Total_mony'];
  }
  int get Total_mony => _Total_mony!;
  String get DateBuy => _DateBuy!;
  int get Price => _Price!;
  int get Quntity => _Quntity!;
  String get Suplier_Name => _Suplier_Name!;
  int get Suplier_No => _Suplier_No!;
  String get linkphoto => _linkphoto!;
  String get Product_Name => _Product_Name!;
  String get barcode => _barcode!;
  int get Product_No => _Product_No!;
  int get No => _No!;
}

// class ProductBuy{
//   int? _No;
//   int? _Product_No;
//   String? _barcode;
//   String? _Product_Name;
//   String? _linkphoto;
//   int? _Suplier_No;
//   String? _Suplier_Name;
//   int? _Quntity;
//   int? _Price;
//   String? _DateBuy;
//   int? _Total_mony;
//   ProductBuy(
//       this._No,
//       this._Product_No,
//       this._barcode,
//       this._Product_Name,
//       this._linkphoto,
//       this._Suplier_No,
//       this._Suplier_Name,
//       this._Quntity,
//       this._Price,
//       this._DateBuy,
//       this._Total_mony
//       );
//   ProductBuy.fromMap (Map<String, dynamic> data) {
//     _No = data['No'];
//     _Product_No = data['Product_No'];
//     _barcode = data['barcode'];
//     _Product_Name = data['Product_Name'];
//     _linkphoto = data['linkphoto'];
//     _Suplier_No = data['Suplier_No'];
//     _Suplier_Name = data['Suplier_Name'];
//     _Quntity = data['Quntity'];
//     _Price = data['Price'];
//     _DateBuy = data['DateBuy'];
//     _Total_mony = data['Total_mony'];
//   }
//   int get Total_mony => _Total_mony!;
//   String get DateBuy => _DateBuy!;
//   int get Price => _Price!;
//   int get Quntity => _Quntity!;
//   String get Suplier_Name => _Suplier_Name!;
//   int get Suplier_No => _Suplier_No!;
//   String get linkphoto => _linkphoto!;
//   String get Product_Name => _Product_Name!;
//   String get barcode => _barcode!;
//   int get Product_No => _Product_No!;
//   int get No => _No!;
// // static List<String> culmn=["No","Product_No","barcode","Product_Name","linkphoto","Suplier_No","Suplier_Name","Quntity","Price","DateBuy","Total_mony"];
//
// }
// //store_buy_move