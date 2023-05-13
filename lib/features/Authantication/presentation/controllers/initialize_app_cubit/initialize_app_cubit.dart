import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Authantication/domain/model/my_user/my_user.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Authantication/domain/usecases/initialize_app_usecase.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Authantication/presentation/controllers/initialize_app_cubit/initialize_app_states.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Authantication/presentation/screens/onboarding/onboarding.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Authantication/presentation/screens/sign_up/sign_up_screen.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/get_home_data_cubit/get_home_data_cubit.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/screens/layout/main_layout_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InitializeAppCubit extends Cubit<InitializeAppCubitStates>{
  static InitializeAppCubit get(context)=> BlocProvider.of(context);

  final InitializeAppUseCase initializeAppUseCase;
  InitializeAppCubit({
    required this.initializeAppUseCase,
  }):super(InitializeAppInitialState());

  Widget getStartScreen(BuildContext context){
    Widget screenToReturn=const SizedBox();
    Either<MyUser , bool>userState=initializeAppUseCase.excute();
    userState.fold(
      (myUser){
        GetHomeDataCubit.get(context).getHomeData(myUser.token);
        screenToReturn= MainLayoutWidget(myUser: myUser,contextOfMaterialApp: context,);
      },
      (isPassOnBoarding){
        if(isPassOnBoarding){
          screenToReturn= SignUpScreen(contextOfMaterialApp: context,);
        }else{
          screenToReturn= OnboardingScreen(contextOfMaterialApp: context,);
        }
      },
    );
    return screenToReturn;
  }

}