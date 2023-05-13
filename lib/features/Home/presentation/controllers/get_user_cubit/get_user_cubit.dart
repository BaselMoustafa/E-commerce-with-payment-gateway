import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_with_payment_gateway/core/error/failures.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Authantication/domain/model/my_user/my_user.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/domain/usecases/get_user_usecase.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/get_user_cubit/get_user_cubit_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetUserCubit extends Cubit<GetUserCubitStates>{
  final GetUserUseCase getUserUseCase;
  GetUserCubit({required this.getUserUseCase}):super(GetUserInitialState());
  static GetUserCubit get(context)=> BlocProvider.of(context);

  void getUser(){
    emit(GetUserLoadingState());
    Either<Failure , MyUser>userOrFailure = getUserUseCase.excute();
    userOrFailure.fold(
      (failure){
        emit(GetUserFailedState(message: failure.message));
      },
      (user){
        emit(GetUserSuccessState(myUser: user));
      },
    );
  }

}