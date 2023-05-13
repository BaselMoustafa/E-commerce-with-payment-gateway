import 'package:e_commerce_app_with_payment_gateway/core/resources/assets_manager.dart';
import 'package:e_commerce_app_with_payment_gateway/core/resources/navigator_manager.dart';
import 'package:e_commerce_app_with_payment_gateway/core/widets/customButton.dart';
import 'package:e_commerce_app_with_payment_gateway/core/widets/flutter_toast.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Authantication/presentation/Widgets/authantication_widget.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Authantication/presentation/controllers/sign_in_cubit/sign_in_cubit.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Authantication/presentation/controllers/sign_in_cubit/sign_in_states.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/get_home_data_cubit/get_home_data_cubit.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/initialize_favorites_cubit/initialize_favorites_cubit.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/screens/layout/main_layout_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({ required this.contextOfMaterialApp,super.key});
  final List<TextEditingController>_textContrllers=[TextEditingController(),TextEditingController()];
  final List<GlobalKey<FormState>>_formKeys=[GlobalKey<FormState>(),GlobalKey<FormState>()];
  final BuildContext contextOfMaterialApp;
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInCubit,SignInCubitStates>(
      listener: _signInListener,
      child: _getScreenDesign(context),
    );
  }

  void _signInListener(context, state)async{
    if(state is SignInFailedState){
      showMyToast(message: state.message);
    }
    if(state is SignInSuccessState){
      NavigatorManager.nagivateToAndCloseThePreviousScreens(context, MainLayoutWidget(myUser: state.myUser,contextOfMaterialApp: contextOfMaterialApp,));
      await GetHomeDataCubit.get(contextOfMaterialApp).getHomeData(state.myUser.token);
      await InitializeFavoritesCubit.get(contextOfMaterialApp).initializeFavorites(state.myUser.token);
    }
  }

  AuthanticationWidget _getScreenDesign(BuildContext context) {
    return AuthanticationWidget(
    screenName:AppLocalizations.of(context)!.signIn,
    button: _getButton(), 
    dialog:AppLocalizations.of(context)!.signInSubTittle, 
    qustion:AppLocalizations.of(context)!.dontHaveQues,
    anotherScreenName:AppLocalizations.of(context)!.signUp, 
    formFieldData: _getFormFiledsData(context),  
    onTapNaviagtion: (){
      NavigatorManager.pop(context);
    },
    );
  }

  Widget _getButton() {
    return BlocBuilder<SignInCubit,SignInCubitStates>(
      builder: (context, state) {
        if(state is SignInLoadingState){
          return const CustomButton(onTap: null, content: null);
        }else{
          return CustomButton(
          content:AppLocalizations.of(context)!.signIn,
          onTap: _onSignInClicked, 
          );
        }
      },
    );
  }

  List<FormFieldData>_getFormFiledsData(context) {
    return [
      FormFieldData(name: AppLocalizations.of(context)!.email, hintText: "Ex: john@gmail.com", prefixIcon: SvgPicture.asset(AssetsManager.emailIcon), textController: _textContrllers[0], formKey: _formKeys[0]),
      FormFieldData(name: AppLocalizations.of(context)!.password, isPassword: true,hintText: "Ex: \$@2jkn551d", prefixIcon: SvgPicture.asset(AssetsManager.passwordIcon), textController: _textContrllers[1], formKey: _formKeys[1]),
    ];
  }
  
  

  void _onSignInClicked() async{
    await SignInCubit.get(contextOfMaterialApp).signIn(email:_textContrllers[0].text, password:_textContrllers[1].text);
  }
}