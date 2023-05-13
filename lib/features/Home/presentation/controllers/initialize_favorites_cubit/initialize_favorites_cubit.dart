import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_with_payment_gateway/core/error/failures.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/domain/usecases/initialize_favorites.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/initialize_favorites_cubit/initialize_favorites_cubit_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InitializeFavoritesCubit extends Cubit<InitializeFavoritesCubitStates>{
  final InitializeFavoritesUsecase initializeFavoritesUsecase;
  InitializeFavoritesCubit({required this.initializeFavoritesUsecase}):super(InitializeFavoritesInitialState());
  static InitializeFavoritesCubit get(context)=> BlocProvider.of(context);
  Future<void>initializeFavorites(String token)async{
    emit(InitializeFavoritesLoadingState());
    Either<Failure , Unit>successOrFailure = await initializeFavoritesUsecase.excute(token);
    successOrFailure.fold(
      (failure){
        emit(InitializeFavoritesFailedState(message: failure.message));
      },
      (success){
        emit(InitializeFavoritesSuccessState());
      },
    );
  }

}