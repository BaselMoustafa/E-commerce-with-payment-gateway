import 'package:e_commerce_app_with_payment_gateway/core/widets/custom_loading_widget.dart';
import 'package:e_commerce_app_with_payment_gateway/core/widets/exception_widet.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Authantication/domain/model/my_user/my_user.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/get_home_data_cubit/get_home_data_cubit.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/get_home_data_cubit/get_home_data_cubit_states.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/widgets/banners_widget.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/widgets/products_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({required this.myUser,super.key});
  final MyUser myUser;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetHomeDataCubit,GetHomeDataCubitStates>(
      builder: (context, state) {
        if(state is GetHomeDataSuccessState){
          return _getSuccessDesign(state, context);
        }
        if(state is GetHomeDataLoadingState){
          return const CustomLoadinWidget();
        }
        if(state is GetHomeDataFailedState){
          return ExceptionWidget(text: state.message,);
        }
        return const SizedBox();
      },
    );
  }

  ListView _getSuccessDesign(GetHomeDataSuccessState state, BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        BannersWidget(banners: state.homeDataModel.banners),
        const SizedBox(height: 20,),
        Text(AppLocalizations.of(context)!.newProducts,style:Theme.of(context).textTheme.displayLarge,),
        const SizedBox(height: 10,),
        ProductsWidget(myUser: myUser, products: state.homeDataModel.products),
      ],
    );
  }
}