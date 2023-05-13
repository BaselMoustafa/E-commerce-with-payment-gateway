import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_with_payment_gateway/core/error/failures.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Authantication/domain/model/my_user/my_user.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Authantication/domain/usecases/sign_in_use_case.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Authantication/presentation/controllers/sign_in_cubit/sign_in_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInCubit extends Cubit<SignInCubitStates>{
  SignInUsecase signInUsecase;
  SignInCubit({required this.signInUsecase}):super(SignInInitialState());
  static SignInCubit get(context)=> BlocProvider.of(context);

  Future<void>signIn({required String email , required String password})async{
    emit(SignInLoadingState());
    Either<Failure , MyUser>myUserOrFailure = await signInUsecase.excute(email: email, password: password);
    myUserOrFailure.fold(
      (failure){
        emit(SignInFailedState(message: failure.message));
      },
      (myUser){
        emit(SignInSuccessState(myUser: myUser));
      },
    );
  }

 
  
  
  

}