import 'package:e_commerce_app_with_payment_gateway/core/resources/assets_manager.dart';
import 'package:e_commerce_app_with_payment_gateway/core/resources/navigator_manager.dart';
import 'package:e_commerce_app_with_payment_gateway/core/style/color_manager.dart';
import 'package:e_commerce_app_with_payment_gateway/core/widets/colored_svg_widget.dart';
import 'package:e_commerce_app_with_payment_gateway/core/widets/customButton.dart';
import 'package:e_commerce_app_with_payment_gateway/core/widets/flutter_toast.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Authantication/domain/model/my_user/my_user.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Authantication/presentation/screens/sign_up/sign_up_screen.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/get_favorites_cubit/get_favorites_cubit.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/get_home_data_cubit/get_home_data_cubit.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/get_user_cubit/get_user_cubit.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/get_user_cubit/get_user_cubit_states.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/profile_cubit/profile_cubit.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/update_user_cubit/update_user_cubit.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/update_user_cubit/update_user_cubit_states.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/widgets/bottom_sheet_of_update_user.dart';
import 'package:e_commerce_app_with_payment_gateway/l10n/l10n.dart';
import 'package:e_commerce_app_with_payment_gateway/l10n/language_cubit/language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatelessWidget {
  final BuildContext contextOfMaterialApp;
  final _pathAtAssets=[AssetsManager.profileIcon,AssetsManager.emailIcon];
   ProfileScreen({required this.contextOfMaterialApp,super.key});
  late MyUser myUser;
  @override
  Widget build(BuildContext context) {   
    return MultiBlocListener(
      listeners: _getBlocListeners,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getLabelWidget(context, AppLocalizations.of(context)!.personalInfo ,()=>Scaffold.of(context).showBottomSheet((_)=>UpdateUserBottomSheet(myUser: myUser),),),
            const SizedBox(height: 10,),
            _getUserInfoWidget(),
            _getLabelWidget(context,AppLocalizations.of(context)!.language , ()async{
              LanguageCubit.get(context).toggleLanugae();
              await GetHomeDataCubit.get(context).getHomeData(myUser.token);
            },),
            const SizedBox(height: 10,),
            _getLanguageInfoWidget(context),
            const SizedBox(height: 30,),
            _getLogoutButton(context),
          ],
        ),
      ),
    );
  }

  List<BlocListener> get _getBlocListeners {
    return [
      BlocListener<UpdateUserCubit,UpdateUserCubitStates>(
        listener: (context, state) {
          if(state is UpdateUserFailedState){
            showMyToast(message: state.message);
          }
          if(state is UpdateUserSuccessState){
            showMyToast(message: AppLocalizations.of(context)!.updatedSuccfully,color: ColorManager.green);
            NavigatorManager.pop(context);
            GetUserCubit.get(context).getUser();
          }
        },
      ),
      BlocListener<GetUserCubit,GetUserCubitStates>(
        listener: (context, state) {
          if(state is GetUserFailedState){
            showMyToast(message: state.message);
          }
        },
      ),
    ];
  }

  Center _getLogoutButton(BuildContext context) {
    return Center(
      child: CustomButton(
        onTap: ()async{
          NavigatorManager.nagivateToAndCloseThePreviousScreens(context, SignUpScreen(contextOfMaterialApp: contextOfMaterialApp));
          await ProfileCubit.get(context).signOut(myUser.token);
        }, 
        content:AppLocalizations.of(context)!.logout ,
        ),
    );
  }

  Padding _getLanguageInfoWidget(BuildContext context) {
    return Padding(
      padding:const EdgeInsetsDirectional.only(start: 15),
      child: Row(
        children: [
          const Icon(Icons.language,size: 28,color: ColorManager.primaryColor,),
          const SizedBox(width: 10,),
          Text(L10n.getLanguageCode()=="en"?"English":"اللغة العربية",style: Theme.of(context).textTheme.bodySmall,),
        ],  
      ),
    );
  }

  Widget _getUserInfoWidget(){
    return BlocBuilder<GetUserCubit,GetUserCubitStates>(
      builder: (context, state) {
        if(state is GetUserSuccessState){
          myUser=state.myUser;
          return Column(
            children: [
              for(int i=0;i<_pathAtAssets.length;i++)
              Container(
                padding: const EdgeInsetsDirectional.only(start: 15),
                margin: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    SizedBox(height: 23,width: 23,child: ColoredSvgPicture(color: ColorManager.primaryColor, path: _pathAtAssets[i])),
                    const SizedBox(width: 10,),
                    Text(i==0?state.myUser.name:state.myUser.email,style: Theme.of(context).textTheme.bodySmall,),
                  ],
                ),
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }

  Row _getLabelWidget(BuildContext context,String label,VoidCallback onTapIcon) {
    return Row(
      children: [
        Text(label,style: Theme.of(context).textTheme.displayLarge,),
        const SizedBox(width: 5,),
        InkWell(
          onTap: onTapIcon,
          child:const CircleAvatar(
            radius: 15,
            backgroundColor: ColorManager.primaryColor,
            child: Icon(Icons.edit,color: ColorManager.white,size: 15,),
          ),
        ),
      ],
    );
  }


}