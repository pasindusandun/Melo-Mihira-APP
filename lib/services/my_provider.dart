import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class MyProvider with ChangeNotifier {
   Map<String, dynamic> _user={
    
   };

  Map<String, dynamic> get user => _user;

  

  set user(Map<String, dynamic> value) {
    _user = value;
    notifyListeners();
  }


  bool _islogin = false;

  bool get islogin => _islogin;

   set islogin(bool value) {
    _islogin = value;
    notifyListeners();
  }

  String _serachValue = "";

  String get serachValue => _serachValue;

   set serachValue(String value) {
    _serachValue = value;
    notifyListeners();
  }

}
