import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_with_payment_gateway/core/error/failures.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/data/model/product_model/product_model.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/domain/usecases/add_or_remove_favorites.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/add_remove_favorites_cubit/add_remove_favorites_cubit_states.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/get_favorites_cubit/get_favorites_cubit.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/get_home_data_cubit/get_home_data_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddOrRemoveFavoritesCubit extends Cubit<AddOrRemoveFavoritesCubitStates>{
  final AddOrRemoveFavoritesUsecase addOrRemoveFavoritesUsecase;
  AddOrRemoveFavoritesCubit({required this.addOrRemoveFavoritesUsecase}):super(AddOrRemoveFavoritesInitialState());
  static AddOrRemoveFavoritesCubit get(context)=> BlocProvider.of(context);

  Future<void>addOrRemoveFavorites(BuildContext context,ProductModel productModel,String token)async{
    List<ProductModel>copies=[
      ProductModel.copy(productModel),
      ProductModel.copy(productModel),
      ProductModel.copy(productModel),
      ProductModel.copy(productModel),
      ];

    GetHomeDataCubit.get(context).updateDisplayedList(copies[0]);
    GetFavoritesProductsCubit.get(context).updateDisplayedList(copies[1]);
    emit(AddOrRemoveFavoritesSuccessState());
    Either<Failure , Unit>homeDataOrFailure = await addOrRemoveFavoritesUsecase.excute(productModel,token);
    homeDataOrFailure.fold(
      (failure)async{
        GetHomeDataCubit.get(context).updateDisplayedList(copies[2]);
        GetFavoritesProductsCubit.get(context).updateDisplayedList(copies[3]);
        emit(AddOrRemoveFavoritesFailedState(message: failure.message));
      },
      (unit){
        emit(AddOrRemoveFavoritesSuccessState());
      },
    );
  }

 
  
  
  

}