import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_with_payment_gateway/core/error/failures.dart';
import 'package:e_commerce_app_with_payment_gateway/core/network/hive/hive_constants.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/data/model/product_model/product_model.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/domain/usecases/search_products_usecase.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/search_products_cubit/search_products_cubit_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchProductsCubit extends Cubit<SearchProductsCubitStates>{
  final SearchProductsUsecase searchProductsUsecase;
  SearchProductsCubit({required this.searchProductsUsecase}):super(SearchProductsInitialState());
  static SearchProductsCubit get(context)=> BlocProvider.of(context);

  Future<void> searchProducts(String text ,String token)async{
    Either<Failure , List<ProductModel>>products = await searchProductsUsecase.excute(text,token);
    products.fold(
      (failure){
        emit(SearchProductsFailedState(message: failure.message));
      },
      (products){
        emit(SearchProductsSuccessState(products: products));
      },
    );
  }

  void refresh(){
    emit(SearchProductsInitialState());
  }  

}