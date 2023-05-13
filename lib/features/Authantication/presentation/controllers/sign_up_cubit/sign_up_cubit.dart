
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_with_payment_gateway/core/error/failures.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Authantication/domain/model/my_user/my_user.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Authantication/domain/usecases/sign_up_usecase.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Authantication/presentation/controllers/sign_up_cubit/sign_up_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpCubitStates>{

  SignUpUsecase signUpUsecase;
  static SignUpCubit get(context)=> BlocProvider.of(context);

  SignUpCubit({
    required this.signUpUsecase,
  }):super(SignUpInitialState());

  Future<void> signUp({required String email,required String password,required String name})async{
    emit(SignUpLoadingState());
    Either<Failure,MyUser>myUserOrFailure= await signUpUsecase.excute(
      name: name,
      email: email,
      password: password,
    );

    myUserOrFailure.fold(
      (failure){
        emit(SignUpFailedState(message: failure.message));
      },
      (myUser){

        emit(SignUpSuccessState(myUser: myUser));
        
      },
    );
  } 

  
  

}