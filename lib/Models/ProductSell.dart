import 'package:flutter/foundation.dart';
import 'package:mange_store/DB/DBHelper.dart';
import 'package:mange_store/Views/Products_Sell.dart';

class StoreSell{
  int? _No;
  int? _Product_No;
  int? _Castmer_No;
  int? _Quntity;
  int? _Price;
  String? _DateSell;
  StoreSell(this._No, this._Product_No, this._Castmer_No, this._Quntity,
      this._Price, this._DateSell);
  StoreSell.empty();
  StoreSell.fromMap (Map<String, dynamic> data) {
    _No = data['No'];
    _Product_No = data['Product_No'];
    _Castmer_No = data['Castmer_No'];
    _Quntity = data['Quntity'];
    _Price = data['Price'];
    _DateSell = data['DateSell'];
  }
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["Product_No"] = _Product_No;
    map["Castmer_No"] = _Castmer_No;
    map["Quntity"] = _Quntity;
    map["Price"] = _Price;
    map["DateSell"] = _DateSell;
    return map;
  }

  String get DateBuy => _DateSell!;
  int get Price => _Price!;
  int get Quntity => _Quntity!;
  int get Suplier_No => _Castmer_No!;
  int get Product_No => _Product_No!;
  int get No => _No!;
}
class ProductSell extends StoreSell with ChangeNotifier, DiagnosticableTreeMixin{

  String? _barcode;
  String? _Product_Name;
  String? _linkphoto;
  String? _Castmer_Name;
  int? _Total_mony;
  bool isserch=true;
  List<ProductSell> _list=<ProductSell>[];
  ProductSell() : super.empty();
  initial(){
    _list.clear();
    Future<List<Map<String, Object?>>> _listps=  DBH.dH.get_db.rawQuery("SELECT * FROM store_sell_move");
    _listps.then((value) => {
      for (int i = 0; i < value.length; i++) {
        _list.add(ProductSell.fromMap(value[i])),
        notifyListeners(),
      }
    });
  }
  List<ProductSell> get list => _list;
  void resetlist(){
    _list.forEach((element) {element.isserch=true; });
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
          if(!element._Castmer_Name!.contains(scrchtext)){
            element.isserch=false;
            notifyListeners();
          }
        });
        break;
    }
    notifyListeners();
  }
  Future<bool> add_tolist(StoreSell _storesell) async {
    int row=await DBH.dH.get_db.insert("StoreSell",_storesell.toMap());
    if(row>0){
      Future<List<Map<String, Object?>>> _listps=  DBH.dH.get_db.rawQuery("SELECT * FROM store_sell_move");
      _listps.then((value) => {
        for (int i = 0; i < value.length; i++) {
          _list.add(ProductSell.fromMap(value[i])),
          notifyListeners(),
        }
      });
      return true;
    }else{
      return false;
    }
  }
  Future<bool> delet_fromlist(int no) async {
    int row=await DBH.dH.get_db.delete("StoreSell",where: "No = ?",whereArgs: [no]);
    if(row>0){
      _list.removeWhere((element) => element.No==no);
      notifyListeners();
      return true;
    }else {
      return false;
    }
  }
  ProductSell.set(
      _No,
      _Product_No,
      this._barcode,
      this._Product_Name,
      this._linkphoto,
      _Castmer_No,
      this._Castmer_Name,
      _Quntity,
      _Price,
      _DateSell,
      this._Total_mony
      ) : super(_No, _Product_No, _Castmer_No, _Quntity, _Price, _DateSell);


  ProductSell.fromMap(Map<String, dynamic> data) : super.fromMap(data) {
    _barcode = data['barcode'];
    _Product_Name = data['Product_Name'];
    _linkphoto = data['linkphoto'];
    _Castmer_Name = data['castmer_Name'];
    _Total_mony = data['Total_mony'];
  }
  int get Total_mony => _Total_mony!;
  String get DateSell => _DateSell!;
  int get Price => _Price!;
  int get Quntity => _Quntity!;
  String get Castmer_Name => _Castmer_Name!;
  int get Castmer_No => _Castmer_No!;
  String get linkphoto => _linkphoto!;
  String get Product_Name => _Product_Name!;
  String get barcode => _barcode!;
  int get Product_No => _Product_No!;
  int get No => _No!;
}
// class ProductSell{
//   int? _No;
//   int? _Product_No;
//   String? _barcode;
//   String? _Product_Name;
//   String? _linkphoto;
//   int? _Castmer_No;
//   String? _castmer_Name;
//   int? _Quntity;
//   int? _Price;
//   String? _DateSell;
//   int? _Total_mony;
//   static List<String> culmn=["No","Product_No","barcode","Product_Name","linkphoto","Castmer_No","castmer_Name","Quntity","Price","DateSell","Total_mony"];
//   ProductSell(
//       this._No,
//       this._Product_No,
//       this._barcode,
//       this._Product_Name,
//       this._linkphoto,
//       this._Castmer_No,
//       this._castmer_Name,
//       this._Quntity,
//       this._Price,
//       this._DateSell,
//       this._Total_mony
//       );
//   ProductSell.fromMap (Map<String, dynamic> data) {
//     _No = data['No'];
//     _Product_No = data['Product_No'];
//     _barcode = data['barcode'];
//     _Product_Name = data['Product_Name'];
//     _linkphoto = data['linkphoto'];
//     _Castmer_No = data['Castmer_No'];
//     _castmer_Name = data['castmer_Name'];
//     _Quntity = data['Quntity'];
//     _Price = data['Price'];
//     _DateSell = data['DateSell'];
//     _Total_mony = data['Total_mony'];
//   }
//   int get Total_mony => _Total_mony!;
//   String get DateSell => _DateSell!;
//   int get Price => _Price!;
//   int get Quntity => _Quntity!;
//   String get castmer_Name => _castmer_Name!;
//   int get Castmer_No => _Castmer_No!;
//   String get linkphoto => _linkphoto!;
//   String get Product_Name => _Product_Name!;
//   String get barcode => _barcode!;
//   int get Product_No => _Product_No!;
//   int get No => _No!;
// }
