import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_with_payment_gateway/core/error/failures.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/data/model/product_model/product_model.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/domain/home_repo/home_repo.dart';
import 'package:equatable/equatable.dart';

class GetFavoritesProductsUsecase extends Equatable{
  final HomeRepo homeRepo;
  const GetFavoritesProductsUsecase({required this.homeRepo});

  Either<Failure,List<ProductModel>>excute(){
    return  homeRepo.getFavorites();
  }
  @override
  List<Object?> get props => [homeRepo];
}