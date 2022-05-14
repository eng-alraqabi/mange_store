import 'package:flutter/foundation.dart';
import 'package:mange_store/DB/DBHelper.dart';
class Product{
  int? _No;
  String?  _Barcode;
  String? _Name;
  String? _Photo;
  bool isserch=true;
  Product( this._Barcode, this._Name, this._Photo);
  Product.fromMap(Map<String, dynamic> data) {
    _No = data['No'];
    _Barcode = data['Barcode'];
    _Name = data['Name'];
    _Photo = data['Photo'];
  }
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["Barcode"] = _Barcode;
    map["Name"] = _Name;
    map["Photo"] = _Photo;
    return map;
  }
  String? get Photo => _Photo;
  String? get Name => _Name;
  String? get Barcode => _Barcode;
  int? get No => _No;
  Future<int> Insert() async {
    return await DBH.dH.get_db.insert("Products", this.toMap());
  }
  Future<int> Delet() async {
    return await DBH.dH.get_db.delete("Products", where: 'No = ?', whereArgs: [this.No]);
  }
  Future<bool> Update(Map<String, dynamic> map) async {
    int ud=await DBH.dH.get_db.update("Products",map, where: 'No = ?', whereArgs: [this.No]);
    if(ud==0){
      return false;
    }else{
      _Barcode = map['Barcode'];
      _Name = map['Name'];
      _Photo = map['Photo'];
      return true;
    }
  }
}

class ListProducts  with ChangeNotifier, DiagnosticableTreeMixin {
  List<Product> _list=<Product>[];
  List<Product>  get list => _list;
  ListProducts();
  void initial(){
    _list.clear();
       Future<List<Map<String, Object?>>> _listps=  DBH.dH.get_db.rawQuery("SELECT * FROM Products");
       _listps.then((value) => {
         for (int i = 0; i < value.length; i++) {
           _list.add(Product.fromMap(value[i])),
            notifyListeners(),
         }
       });
  }
   void resetlist(){
     _list.forEach((element) {element.isserch=true; });
     notifyListeners();
   }
  void serch_inlist(int val,String scrchtext){
    resetlist();
    switch(val){
      case 1:
        _list.forEach((element) {
          if(element.Barcode!=scrchtext){
            element.isserch=false;
          }
        });
        break;
      case 2:
        _list.forEach((element) {
          if(!element.Name!.contains(scrchtext)){
            element.isserch=false;
          }
        });
        break;
    }
    notifyListeners();
  }
  Future<bool> add_tolist(Product product) async {
    int row=await product.Insert();
    if(row>0){
      _list.add(product);
      notifyListeners();
      return true;
    }else{
      return false;
    }
  }
  Future<bool> delet_fromlist(int i) async {
    int row=await _list[i].Delet();
    if(row>0){
      _list.removeAt(i);
      notifyListeners();
      return true;
    }else{
      return false;
    }
  }
  Future<bool> update_onlist(int i,Map<String, dynamic> map) async {
    bool row=await _list[i].Update(map);
    if(row){
      notifyListeners();
      return true;
    }else{
      return false;
    }
  }
}