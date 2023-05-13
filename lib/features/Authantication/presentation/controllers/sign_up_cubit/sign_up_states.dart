import 'package:e_commerce_app_with_payment_gateway/features/Authantication/domain/model/my_user/my_user.dart';

abstract class SignUpCubitStates{}

class SignUpInitialState extends SignUpCubitStates{}
class SignUpLoadingState extends SignUpCubitStates{}
class SignUpSuccessState extends SignUpCubitStates{
  MyUser myUser;
  SignUpSuccessState({required this.myUser});
}
class SignUpFailedState extends SignUpCubitStates{
  final String message;
  SignUpFailedState({required this.message});
}



