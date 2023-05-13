import 'package:e_commerce_app_with_payment_gateway/features/Authantication/domain/model/my_user/my_user.dart';

abstract class GetUserCubitStates{}

class GetUserInitialState extends GetUserCubitStates{}

class GetUserLoadingState extends GetUserCubitStates{}
class GetUserSuccessState extends GetUserCubitStates{
  MyUser myUser;
  GetUserSuccessState({required this.myUser});
}
class GetUserFailedState extends GetUserCubitStates{
  final String message ;
  GetUserFailedState({required this.message});
}