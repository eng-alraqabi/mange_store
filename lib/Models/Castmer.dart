import 'package:flutter/foundation.dart';
import 'package:mange_store/DB/DBHelper.dart';
class Castmer{
  int? _No;
  String? _Name;
  int? _Phone;
  String? _Address;
  bool isserch=true;
  Castmer( this._Name, this._Phone, this._Address);
  Castmer.fromMap(Map<String, dynamic> data) {
    _No = data['No'];
    _Name = data['Name'];
    _Phone = data['Phone'];
    _Address = data['Address'];
  }
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["Name"] = _Name;
    map["Phone"] = _Phone;
    map["Address"] = _Address;
    return map;
  }
  Future<int> Insert() async {
    return await DBH.dH.get_db.insert("Castmers", this.toMap());
  }
  Future<int> Delet() async {
    return await DBH.dH.get_db.delete("Castmers", where: 'No = ?', whereArgs: [this.No]);
  }
  Future<bool> Update(Map<String, dynamic> map) async {
    int ud=await DBH.dH.get_db.update("Castmers",map, where: 'No = ?', whereArgs: [this.No]);
    if(ud==0){
      return false;
    }else{
      _Name = map['Name'];
      _Phone = map['Phone'];
      _Address = map['Address'];
      return true;
    }

  }
  String? get Address => _Address;
  int? get Phone => _Phone;
  String? get Name => _Name;
  int? get No => _No;
}
class ListCastmers with ChangeNotifier, DiagnosticableTreeMixin{
  List<Castmer> _list=<Castmer>[];
  List<Castmer>  get list => _list;
  ListCastmers();
  void initial(){
    _list.clear();
    Future<List<Map<String, Object?>>> _listps=  DBH.dH.get_db.rawQuery("SELECT * FROM Castmers;");
    _listps.then((value) => {
      for (int i = 0; i < value.length; i++) {
        _list.add(Castmer.fromMap(value[i])),
        notifyListeners(),
      }
    });
  }
  void resetlist(){
    _list.forEach((element) {element.isserch=true;});
    notifyListeners();
  }
  void serch_inlist(int val,String scrchtext){
    resetlist();
    switch(val){
      case 1:
        _list.forEach((element) {
          if(!element.Phone!.toString().contains(scrchtext)){
            element.isserch=false;
            notifyListeners();
          }
        });
        break;
      case 2:
        _list.forEach((element) {
          if(!element.Name!.contains(scrchtext)){
            element.isserch=false;
            notifyListeners();
          }
        });
        break;
    }
    notifyListeners();
  }
  Future<bool> add_tolist(Castmer castmer) async {
    int row=await castmer.Insert();
    if(row>0){
      _list.add(castmer);
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
