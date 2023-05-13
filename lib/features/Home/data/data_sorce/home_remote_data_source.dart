import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_app_with_payment_gateway/core/error/exceptions.dart';
import 'package:e_commerce_app_with_payment_gateway/core/error/failure_messages.dart';
import 'package:e_commerce_app_with_payment_gateway/core/network/api/api_constants.dart';
import 'package:e_commerce_app_with_payment_gateway/core/network/api/api_request_model.dart';
import 'package:e_commerce_app_with_payment_gateway/core/network/api/dio_helper.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/data/model/home_data_model/home_data_model.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/data/model/product_model/product_model.dart';
import 'package:equatable/equatable.dart';

abstract class HomeRemoteDataSource extends Equatable{
  Future<Unit>signOut(ApiRequestModel apiRequestModel);
  Future<HomeDataModel>getHomeData(ApiRequestModel apiRequestModel);
  Future<Unit>addOrRemoveToFavorites(ApiRequestModel apiRequestModel);
  Future<List<ProductModel>>getFavorites(ApiRequestModel apiRequestModel);
  Future<List<ProductModel>>searchProducts(ApiRequestModel apiRequestModel);
  Future<Unit>updateUser(ApiRequestModel apiRequestModel);
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {

  final DioHelper dioHelper;
  HomeRemoteDataSourceImpl({required this.dioHelper});

  @override
  Future<Unit>signOut(ApiRequestModel apiRequestModel)async{
    Response response =await dioHelper.postData(apiRequestModel);
    if(response.statusCode==200){
      if(response.data[ApiK.status]==true){
        return unit;
      }
      throw ServerException(message: response.data[ApiK.message]);
    }
    throw ServerException(message: FailureMessages.serverFailure);
  }


  @override
  Future<HomeDataModel>getHomeData(ApiRequestModel apiRequestModel)async{
    Response response =await dioHelper.getData(apiRequestModel);
    if(response.statusCode==200){
      if(response.data[ApiK.status]==true){
        return HomeDataModel.fromMap(response.data[ApiK.data]);
      }
      throw ServerException(message: response.data[ApiK.message]);
    }
    throw ServerException(message: FailureMessages.serverFailure);
  }

  
  
  @override
  Future<Unit> addOrRemoveToFavorites(ApiRequestModel apiRequestModel) async{
    Response response =await dioHelper.postData(apiRequestModel);
    if(response.statusCode==200){
      if(response.data[ApiK.status]==true){
        return unit;
      }
      throw ServerException(message: response.data[ApiK.message]);
    }
    throw ServerException(message: FailureMessages.serverFailure);
  }
  
  @override
  Future<List<ProductModel>> getFavorites(ApiRequestModel apiRequestModel) async{
    Response response=await dioHelper.getData(apiRequestModel);
    if(response.statusCode==200){
      if(response.data[ApiK.status]==true){
        List<ProductModel>favoriteProducts=[];
        for (var i = 0; i < response.data[ApiK.data][ApiK.data].length; i++) {
          favoriteProducts.add(ProductModel.fromMap(response.data[ApiK.data][ApiK.data][i][ApiK.producttttt],favoriteProduct: true));          
        }
        return favoriteProducts;
      }
      throw ServerException(message: response.data[ApiK.message]);
    }
    throw ServerException(message: FailureMessages.serverFailure);
  }

  @override
  Future<List<ProductModel>>searchProducts(ApiRequestModel apiRequestModel)async{
    Response response=await dioHelper.postData(apiRequestModel);
    if(response.statusCode==200){
      if(response.data[ApiK.status]==true){
        List<ProductModel>products=[];
        for (var i = 0; i < response.data[ApiK.data][ApiK.data].length; i++) {
          products.add(ProductModel.fromMap(response.data[ApiK.data][ApiK.data][i],searchProduct: true));          
        }
        return products;
      }
      throw ServerException(message: response.data[ApiK.message]);
    }
    throw ServerException(message: FailureMessages.serverFailure);
  }

  @override
  List<Object?> get props => [];
  
  @override
  Future<Unit> updateUser(ApiRequestModel apiRequestModel)async{
    Response response=await dioHelper.updateData(apiRequestModel);
    if(response.statusCode==200){
      if(response.data[ApiK.status]==true){
        return unit;
      }
      throw ServerException(message: response.data[ApiK.message]);
    }
    throw ServerException(message: FailureMessages.serverFailure);
  }
}