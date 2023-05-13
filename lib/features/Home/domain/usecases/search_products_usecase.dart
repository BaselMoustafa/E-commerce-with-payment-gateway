import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_with_payment_gateway/core/error/failures.dart';
import 'package:e_commerce_app_with_payment_gateway/core/network/api/api_constants.dart';
import 'package:e_commerce_app_with_payment_gateway/core/network/api/api_request_model.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/data/model/product_model/product_model.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/domain/home_repo/home_repo.dart';
import 'package:equatable/equatable.dart';

class SearchProductsUsecase extends Equatable{
  final HomeRepo homeRepo;
  const SearchProductsUsecase({required this.homeRepo});

  Future<Either<Failure,List<ProductModel>>>excute(String text,String token)async{
    return await homeRepo.searchForProducts(
      ApiRequestModel(
        endPoint: ApiK.searchProductsEndPoint,
        headers: {
          ApiK.authorization:token,
        },
        body: {
          ApiK.text:text,
        },
      ),
    );
  }

  @override
  List<Object?> get props => [homeRepo];
}