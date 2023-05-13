import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_with_payment_gateway/core/error/failures.dart';
import 'package:e_commerce_app_with_payment_gateway/core/network/api/api_request_model.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Authantication/domain/model/my_user/my_user.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/data/model/home_data_model/home_data_model.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/data/model/product_model/product_model.dart';
import 'package:equatable/equatable.dart';

abstract class HomeRepo extends Equatable{
  Future<Either<Failure,Unit>> signOut(ApiRequestModel apiRequestModel);
  Future<Either<Failure,HomeDataModel>>getHomeData(ApiRequestModel apiRequestModel);
  Future<Either<Failure,Unit>>addOrRemoveFavorites(ProductModel productModel,ApiRequestModel apiRequestModel,);
  Either<Failure,List<ProductModel>>getFavorites();
  Future<Either<Failure, Unit>> initializeFavorties(ApiRequestModel apiRequestModel);
  Future<Either<Failure, List<ProductModel>>> searchForProducts(ApiRequestModel apiRequestModel);
  Future<Either<Failure,Unit>>updateUser(ApiRequestModel apiRequestModel);
  Either<Failure,MyUser>getUser();
}