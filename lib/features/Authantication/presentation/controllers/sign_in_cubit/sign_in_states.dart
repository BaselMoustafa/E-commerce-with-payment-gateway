import 'package:e_commerce_app_with_payment_gateway/features/Authantication/domain/model/my_user/my_user.dart';

abstract class SignInCubitStates{}

class SignInInitialState extends SignInCubitStates{}

class SignInLoadingState extends SignInCubitStates{}
class SignInSuccessState extends SignInCubitStates{
  MyUser myUser;
  SignInSuccessState({required this.myUser});
}
class SignInFailedState extends SignInCubitStates{
  final String message ;
  SignInFailedState({required this.message});
}