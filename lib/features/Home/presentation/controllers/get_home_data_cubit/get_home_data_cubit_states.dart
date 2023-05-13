import 'package:e_commerce_app_with_payment_gateway/features/Authantication/domain/model/my_user/my_user.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/data/model/home_data_model/home_data_model.dart';

abstract class GetHomeDataCubitStates{}

class GetHomeDataInitialState extends GetHomeDataCubitStates{}

class GetHomeDataLoadingState extends GetHomeDataCubitStates{}
class GetHomeDataSuccessState extends GetHomeDataCubitStates{
  HomeDataModel homeDataModel;
  GetHomeDataSuccessState({required this.homeDataModel});
}
class GetHomeDataFailedState extends GetHomeDataCubitStates{
  final String message ;
  GetHomeDataFailedState({required this.message});
}