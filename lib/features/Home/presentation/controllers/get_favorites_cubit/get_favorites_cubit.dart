import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_with_payment_gateway/core/error/failures.dart';
import 'package:e_commerce_app_with_payment_gateway/core/network/hive/hive_constants.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/data/model/product_model/product_model.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/domain/usecases/get_favorites_usecase.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/get_favorites_cubit/get_favorites_cubit_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class GetFavoritesProductsCubit extends Cubit<GetFavoritesProductsCubitStates>{
  final GetFavoritesProductsUsecase getFavoritesProductsUsecase;
  GetFavoritesProductsCubit({required this.getFavoritesProductsUsecase}):super(GetFavoritesProductsInitialState());
  static GetFavoritesProductsCubit get(context)=> BlocProvider.of(context);
  List<ProductModel>_favoritesProducts=[];
  void getFavoritesProducts(){
    emit(GetFavoritesProductsLoadingState());
    Either<Failure , List<ProductModel>>homeDataOrFailure = getFavoritesProductsUsecase.excute();
    homeDataOrFailure.fold(
      (failure){
        emit(GetFavoritesProductsFailedState(message: failure.message));
      },
      (favoriteProducts){
        _favoritesProducts=[];
        for (var i = 0; i < favoriteProducts.length; i++) {
          _favoritesProducts.add(favoriteProducts[i]);
        }
        emit(GetFavoritesProductsSuccessState(favoriteProducts: _favoritesProducts));
      },
    );
  }

  void updateDisplayedList(ProductModel productModel){
    if(!productModel.inFav){
      _favoritesProducts.add(productModel);
    }else{
      for (var i = 0; i < _favoritesProducts.length; i++) {
        if(productModel.id==_favoritesProducts[i].id){
          _favoritesProducts.removeAt(i);
          break;
        }
      }
    }
    emit(GetFavoritesProductsSuccessState(favoriteProducts: _favoritesProducts));
  }

 
  
  
  

}