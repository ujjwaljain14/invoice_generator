import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class LanguageProvider extends ChangeNotifier{

  LanguageProvider(){
    refresh();
  }

  final languageBox = Hive.box('language_box');
  var list = [];

  void refresh()async{
    if(languageBox.keys.isNotEmpty){
      final data = languageBox.keys.map((key) {
        final item = languageBox.get(key);
        return {'key':key, 'language':item['language'],};
      }).toList();
      list = data;
    }else{
      var value = {
        'language':false,
      };
      await languageBox.add(value);
      refresh();
    }
    notifyListeners();
  }

  void toggleLanguage(dynamic key, bool value){
    languageBox.get(key)['language'] = value;
    languageBox.put(key, languageBox.get(key));
    refresh();
  }


}