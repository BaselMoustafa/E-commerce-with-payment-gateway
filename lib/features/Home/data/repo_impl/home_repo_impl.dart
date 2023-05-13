import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_with_payment_gateway/core/error/exceptions.dart';
import 'package:e_commerce_app_with_payment_gateway/core/error/failure_messages.dart';
import 'package:e_commerce_app_with_payment_gateway/core/error/failures.dart';
import 'package:e_commerce_app_with_payment_gateway/core/network/api/api_constants.dart';
import 'package:e_commerce_app_with_payment_gateway/core/network/api/api_request_model.dart';
import 'package:e_commerce_app_with_payment_gateway/core/network/api/network_connection_info.dart';
import 'package:e_commerce_app_with_payment_gateway/core/network/hive/hive_constants.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Authantication/domain/model/my_user/my_user.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/data/data_sorce/home_local_data_source.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/data/data_sorce/home_remote_data_source.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/data/model/home_data_model/home_data_model.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/data/model/product_model/product_model.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/domain/home_repo/home_repo.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeReposImpl extends HomeRepo{
  final HomeLocaleDataSource homeLocaleDataSource;
  final HomeRemoteDataSource homeRemoteDataSource;
  final NetworkConnectionInfo networkConnectionInfo;
  HomeReposImpl({required this.homeLocaleDataSource,required this.homeRemoteDataSource,required this.networkConnectionInfo});

  @override
  Future<Either<Failure,Unit>> signOut(ApiRequestModel apiRequestModel)async{
    try{
      await homeLocaleDataSource.deleteUserData();
      if(await networkConnectionInfo.isConnected){
        await homeRemoteDataSource.signOut(apiRequestModel);
      }
      return const Right(unit);
    }on ServerException catch(ex){
      return Left(ServerFailure(message: ex.message));
    }on SafetyLocalDataBaseException catch (_){
      return Left(SafetyLocalDataBaseFailure(message: FailureMessages.localDataBaseFailure));
    }
  }

  @override
  Future<Either<Failure, HomeDataModel>> getHomeData(ApiRequestModel apiRequestModel) async{
    try{
      if(await networkConnectionInfo.isConnected){
        HomeDataModel homeDataModel= await homeRemoteDataSource.getHomeData(apiRequestModel);
        homeLocaleDataSource.setHomeData(homeDataModel);
        return Right(homeDataModel);
      }
      return Right(homeLocaleDataSource.getHomeData());
    }on ServerException catch(ex){
      return Left(ServerFailure(message: ex.message));
    }on SafetyLocalDataBaseException catch(ex){
      return Left(SafetyLocalDataBaseFailure(message: FailureMessages.localDataBaseFailure));
    }
  }

  @override
  List<Object?> get props =>[homeLocaleDataSource,homeRemoteDataSource];
  
  @override
  Future<Either<Failure, Unit>> addOrRemoveFavorites(ProductModel productModel,ApiRequestModel apiRequestModel,)async {
    if(await networkConnectionInfo.isConnected){
      try{
        homeLocaleDataSource.setOrDeleteProductFromFavorites(productModel);
        await homeRemoteDataSource.addOrRemoveToFavorites(apiRequestModel);
        return const Right(unit);
      }on ServerException catch(ex){
        homeLocaleDataSource.setOrDeleteProductFromFavorites(productModel);
        return Left(ServerFailure(message: ex.message));
      }
    }
    
    return Left(OfflineFailure(message: FailureMessages.offline));
  }
  
  @override
  Either<Failure, List<ProductModel>> getFavorites() {
    try{
      return Right(homeLocaleDataSource.getFavorites());
    }on SafetyLocalDataBaseException catch (ex){
      return Left(SafetyLocalDataBaseFailure(message: ex.message));
    }
  }
  
  @override
  Future<Either<Failure, Unit>> initializeFavorties(ApiRequestModel apiRequestModel) async{
    if(await networkConnectionInfo.isConnected){
      try{
        List<ProductModel>favoriteProducts= await homeRemoteDataSource.getFavorites(apiRequestModel);
        homeLocaleDataSource.setAllFavorites(favoriteProducts);
        return const Right(unit);
      }on ServerException catch (ex){
        return Left(ServerFailure(message: ex.message));
      }on SafetyLocalDataBaseException catch (ex){
        return Left(SafetyLocalDataBaseFailure(message: ex.message));
      }
    }
    return Left(OfflineFailure(message: FailureMessages.offline));
  }
  
  @override
  Future<Either<Failure, List<ProductModel>>> searchForProducts(ApiRequestModel apiRequestModel)async {
    if(await networkConnectionInfo.isConnected){
      try{
        List<ProductModel>products= await homeRemoteDataSource.searchProducts(apiRequestModel);
        return Right(products);
      }on ServerException catch (ex){
        return Left(ServerFailure(message: ex.message));
      }on SafetyLocalDataBaseException catch (ex){
        return Left(SafetyLocalDataBaseFailure(message: ex.message));
      }
    }
    return Left(OfflineFailure(message: FailureMessages.offline));
  }
  
  @override
  Either<Failure, MyUser> getUser() {
    try{
      return Right(homeLocaleDataSource.getUser());
    }on SafetyLocalDataBaseException catch(err){
      return Left(SafetyLocalDataBaseFailure(message: err.message));
    }
  }
  
  @override
  Future<Either<Failure, Unit>> updateUser(ApiRequestModel apiRequestModel) async{
    if(await networkConnectionInfo.isConnected){
      try{
        await homeRemoteDataSource.updateUser(apiRequestModel);
        homeLocaleDataSource.updateUser(apiRequestModel.body![ApiK.name], apiRequestModel.body![ApiK.email]);
        return const Right(unit);
      }on ServerException catch (ex){
        return Left(ServerFailure(message: ex.message));
      }
    }
    return Left(OfflineFailure(message: FailureMessages.offline));
  }

  
}