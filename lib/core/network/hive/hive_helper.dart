import 'package:e_commerce_app_with_payment_gateway/core/network/hive/hive_constants.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Authantication/domain/model/my_user/my_user.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Authantication/domain/model/my_user/my_user_type_adapter.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/data/model/home_data_model/home_data_model.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/data/model/home_data_model/home_data_model_adabter.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/data/model/product_model/product_model_type_adabter.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class HiveHelper{

  //Initialization methods
  static Future<void> init()async{
    await Hive.initFlutter();
    _registerAdabters.call(); 
    await _openBoxes.call();
  } 

  static Future<void> _openBoxes()async{
    await Hive.openBox<MyUser>(HiveK.myUserBoxName);
    await Hive.openBox<bool>(HiveK.userPassOnBoardingBoxName);
    await Hive.openBox<HomeDataModel>(HiveK.homeDataBoxName);
    await Hive.openBox<List>(HiveK.favoritesBoxName);
    await Hive.openBox<String>(HiveK.languageBoxName);
  }

  static void _registerAdabters(){
    Hive.registerAdapter(MyUserAdabter());
    Hive.registerAdapter(ProductModelAdabter());
    Hive.registerAdapter(HomeDataModelAdabter());
  }
}