import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_with_payment_gateway/core/error/failures.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/domain/usecases/update_user_usecase.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/update_user_cubit/update_user_cubit_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateUserCubit extends Cubit<UpdateUserCubitStates>{
  final UpdateUserUseCase updateUserUseCase;
  UpdateUserCubit({required this.updateUserUseCase}):super(UpdateUserInitialState());
  static UpdateUserCubit get(context)=> BlocProvider.of(context);

  Future<void> updateUser(String token,String name,String email)async{
    emit(UpdateUserLoadingState());
    Either<Failure , Unit>updatedOrFailure = await updateUserUseCase.excute(token,name,email);
    updatedOrFailure.fold(
      (failure){
        emit(UpdateUserFailedState(message: failure.message));
      },
      (updated){
        emit(UpdateUserSuccessState());
      },
    );
  }

  

}