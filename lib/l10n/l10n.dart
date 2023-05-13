import 'dart:ui';
import 'package:e_commerce_app_with_payment_gateway/core/network/hive/hive_constants.dart';
import 'package:hive_flutter/hive_flutter.dart';

class L10n{
  static final Box languageBox=Hive.box<String>(HiveK.languageBoxName);
  static final all=[
    const Locale("en"),
    const Locale("ar"),
  ];

  static Locale getTheCorrectLanguage(Locale? locale){
    if(locale==null){
      return all[0];
    }
    
    String? cachedLocaleCode=languageBox.get(HiveK.languageKey);
    if(cachedLocaleCode!=null){
      return Locale(cachedLocaleCode);
    }

    for (var i = 0; i < all.length; i++) {
      if(locale.languageCode==all[i].languageCode){
        languageBox.put(HiveK.languageKey, all[i].languageCode);
        return all[i];
      }
    }
    languageBox.put(HiveK.languageKey, all[0].languageCode);
    return all[0];
  }

  static String getLanguageCode(){
    return languageBox.get(HiveK.languageKey);
  }
}