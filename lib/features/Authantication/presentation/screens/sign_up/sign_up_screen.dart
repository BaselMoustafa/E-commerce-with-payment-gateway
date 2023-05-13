import 'package:e_commerce_app_with_payment_gateway/core/resources/assets_manager.dart';
import 'package:e_commerce_app_with_payment_gateway/core/resources/navigator_manager.dart';
import 'package:e_commerce_app_with_payment_gateway/core/widets/customButton.dart';
import 'package:e_commerce_app_with_payment_gateway/core/widets/flutter_toast.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Authantication/presentation/Widgets/authantication_widget.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Authantication/presentation/controllers/sign_up_cubit/sign_up_cubit.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Authantication/presentation/controllers/sign_up_cubit/sign_up_states.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Authantication/presentation/screens/sign_in/sigin_in_screen.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/get_home_data_cubit/get_home_data_cubit.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/screens/layout/main_layout_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({required this.contextOfMaterialApp,super.key});
  final List<TextEditingController>_textContrllers=[TextEditingController(),TextEditingController(),TextEditingController()];
  final List<GlobalKey<FormState>>_formKeys=[GlobalKey<FormState>(),GlobalKey<FormState>(),GlobalKey<FormState>()];
  final BuildContext contextOfMaterialApp;
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit,SignUpCubitStates>(
      listener: _signUpListener,
      child: _getScreenDesign(context),
    );
  }

  void _signUpListener(context, state) async{
    if(state is SignUpFailedState){
      showMyToast(message: state.message);
    }
    if(state is SignUpSuccessState){
      NavigatorManager.nagivateToAndCloseThePreviousScreens(context, MainLayoutWidget(myUser: state.myUser,contextOfMaterialApp: contextOfMaterialApp,));
      await GetHomeDataCubit.get(context).getHomeData(state.myUser.token);
      
    }
  }

  AuthanticationWidget _getScreenDesign(BuildContext context) {
    return AuthanticationWidget(
      screenName:AppLocalizations.of(context)!.register, 
      button: _getButton(),
      dialog: AppLocalizations.of(context)!.signUpSubTittle, 
      qustion:AppLocalizations.of(context)!.alreadyHaveQues, 
      formFieldData: _getFormFiledsData(context), 
      anotherScreenName:AppLocalizations.of(context)!.signIn,
      onTapNaviagtion:(){
        NavigatorManager.navigateTo(context, SignInScreen(contextOfMaterialApp: contextOfMaterialApp,));
      },
    );
  }

  

  List<FormFieldData> _getFormFiledsData(context) {
    return [
      FormFieldData(name:AppLocalizations.of(context)!.email, hintText: "Ex: john@gmail.com", prefixIcon: SvgPicture.asset(AssetsManager.emailIcon), textController: _textContrllers[0], formKey: _formKeys[0]),
      FormFieldData(name:AppLocalizations.of(context)!.name, hintText: "Ex: Basel Moustafa", prefixIcon: SvgPicture.asset(AssetsManager.profileIcon), textController: _textContrllers[1], formKey: _formKeys[1]),
      FormFieldData(isPassword: true,name:AppLocalizations.of(context)!.password, hintText: "Ex: #\$fds85515d#", prefixIcon: SvgPicture.asset(AssetsManager.passwordIcon), textController: _textContrllers[2], formKey: _formKeys[2]),
    ];
  }
  
  Widget _getButton() {
    return BlocBuilder<SignUpCubit,SignUpCubitStates>(
      builder: (context, state) {
        if(state is SignUpLoadingState){
          return const CustomButton(onTap: null, content: null);
        }else{
          return CustomButton(
          content:AppLocalizations.of(context)!.signUp,
          onTap: _onSignUpClicked, 
          );
        }
      },
    );
  }

  void _onSignUpClicked()async{
      List<bool>validInputs=[_formKeys[0].currentState!.validate(),_formKeys[1].currentState!.validate(),_formKeys[2].currentState!.validate()];
      for (var i = 0; i < validInputs.length; i++) {
        if(!validInputs[i]){
          break;
        }
        if(i==validInputs.length-1){
          await SignUpCubit.get(contextOfMaterialApp).signUp(email: _textContrllers[0].text,name:_textContrllers[1].text,password:_textContrllers[2].text);
        }
      }
    }
}