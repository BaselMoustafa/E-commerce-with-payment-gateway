import 'package:e_commerce_app_with_payment_gateway/features/Home/data/model/product_model/product_model.dart';

abstract class SearchProductsCubitStates{}

class SearchProductsInitialState extends SearchProductsCubitStates{}

class SearchProductsSuccessState extends SearchProductsCubitStates{
  List<ProductModel> products;
  SearchProductsSuccessState({required this.products});
}
class SearchProductsFailedState extends SearchProductsCubitStates{
  final String message ;
  SearchProductsFailedState({required this.message});
}