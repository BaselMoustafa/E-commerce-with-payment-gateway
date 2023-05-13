import 'package:e_commerce_app_with_payment_gateway/features/Authantication/domain/model/my_user/my_user.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/data/model/product_model/product_model.dart';

abstract class GetFavoritesProductsCubitStates{}

class GetFavoritesProductsInitialState extends GetFavoritesProductsCubitStates{}

class GetFavoritesProductsLoadingState extends GetFavoritesProductsCubitStates{}
class GetFavoritesProductsSuccessState extends GetFavoritesProductsCubitStates{
  List<ProductModel> favoriteProducts;
  GetFavoritesProductsSuccessState({required this.favoriteProducts});
}
class GetFavoritesProductsFailedState extends GetFavoritesProductsCubitStates{
  final String message ;
  GetFavoritesProductsFailedState({required this.message});
}