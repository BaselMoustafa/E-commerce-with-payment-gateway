import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_with_payment_gateway/core/error/exceptions.dart';
import 'package:e_commerce_app_with_payment_gateway/core/error/failure_messages.dart';
import 'package:e_commerce_app_with_payment_gateway/core/network/hive/hive_constants.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Authantication/domain/model/my_user/my_user.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/data/model/home_data_model/home_data_model.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/data/model/product_model/product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class HomeLocaleDataSource extends Equatable{
  Future<Unit> deleteUserData();
  Unit setHomeData(HomeDataModel homeDataModel);
  HomeDataModel getHomeData();
  List<ProductModel>getFavorites();
  Unit setOrDeleteProductFromFavorites(ProductModel productModel);
  Unit setAllFavorites(List<ProductModel> favoriteProducts);
  MyUser getUser();
  Unit updateUser(String name,String email);
}

class HomeLocaleDataSourceImpl extends HomeLocaleDataSource{
  final Box userPassOnBoardingBox=Hive.box<bool>(HiveK.userPassOnBoardingBoxName);
  final Box userInfoBox=Hive.box<MyUser>(HiveK.myUserBoxName);
  final Box homeDataBox=Hive.box<HomeDataModel>(HiveK.homeDataBoxName);
  final Box favoritesBox=Hive.box<List>(HiveK.favoritesBoxName);
  final Box languageBox=Hive.box<String>(HiveK.languageBoxName);
  @override
  Future<Unit> deleteUserData()async{
    try{
      await userInfoBox.clear();
      await homeDataBox.clear();
      await favoritesBox.clear();
      return unit;
    }catch(ex){
      throw SafetyLocalDataBaseException(message: FailureMessages.localDataBaseFailure);
    }
  }

  @override
  Unit setHomeData(HomeDataModel homeDataModel){
    try{
      homeDataBox.put(HiveK.myHomeData, homeDataModel);
      return unit;
    }catch(ex){
      throw SafetyLocalDataBaseException(message: FailureMessages.localDataBaseFailure);
    }
  }

  @override 
  HomeDataModel getHomeData(){
    return homeDataBox.get(HiveK.myHomeData);
  }

  @override
  List<Object?> get props => [];
  
  @override
  List<ProductModel> getFavorites() {
    try{
      List? dynamicVersion=favoritesBox.get(HiveK.favoritesKey);
      List<ProductModel>?favoriteProducts=dynamicVersion==null?null:dynamicVersion.cast<ProductModel>();
      if(favoriteProducts==null){return [];}
      return favoriteProducts;
    }catch (ex){
      throw SafetyLocalDataBaseException(message: FailureMessages.localDataBaseFailure);
    }
    
  }
  
  @override
  Unit setOrDeleteProductFromFavorites(ProductModel productModel) {
    try{
      List<ProductModel>favoriteProducts=getFavorites();
      _applyOperationAfterSearch(favoriteProducts, productModel);
      favoritesBox.put(HiveK.favoritesKey, favoriteProducts);
      return unit;
    }catch (ex){      
      throw SafetyLocalDataBaseException(message: FailureMessages.localDataBaseFailure);
    }
  }

  @override
  Unit setAllFavorites(List<ProductModel> favoriteProducts) {
    try{
      for (var i = 0; i < favoriteProducts.length; i++) {
        setOrDeleteProductFromFavorites(favoriteProducts[i]);
      }
      return unit;
    }catch(ex){
      throw SafetyLocalDataBaseException(message: FailureMessages.localDataBaseFailure);
    }
  }

  void _applyOperationAfterSearch(List<ProductModel>favoriteProducts,ProductModel productModel){
    for (var i = 0; i < favoriteProducts.length; i++) {
      if(productModel.id==favoriteProducts[i].id){
        favoriteProducts.removeAt(i);
        return;
      }
    }
    favoriteProducts.add(productModel);
  }
  
  @override
  MyUser getUser() {
    try{
      return userInfoBox.get(HiveK.myUserInfoKey);
    }catch(err){
      throw SafetyLocalDataBaseException(message: FailureMessages.localDataBaseFailure);
    }
  }
  
  @override
  Unit updateUser(String name, String email) {
    try{
      MyUser myUser=getUser();
      userInfoBox.put(HiveK.myUserInfoKey,MyUser(id: myUser.id, name: name, email: email, token: myUser.token));
      return unit;
    }catch(err){
      throw SafetyLocalDataBaseException(message: FailureMessages.localDataBaseFailure);
    }
  }
  
}