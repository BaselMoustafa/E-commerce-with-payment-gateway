import 'package:e_commerce_app_with_payment_gateway/core/style/color_manager.dart';
import 'package:e_commerce_app_with_payment_gateway/core/widets/customButton.dart';
import 'package:e_commerce_app_with_payment_gateway/core/widets/exception_widet.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/card_cubit/card_cubit.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/card_cubit/card_cubit_states.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/widgets/custom_rectangle_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class CardScreen extends StatelessWidget {
  const CardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit,CartCubitStates>(
      builder: (context, state) {
        if(state is CartCubitInitialState){
          return  ExceptionWidget(text: AppLocalizations.of(context)!.thereAreNoItems,);
        }
        if(state is CartCubitInterActiveState){
          if(state.cardProducts.isNotEmpty){
            return _getNormalBody(state, context);
          }
          return  ExceptionWidget(text: AppLocalizations.of(context)!.thereAreNoItems,);
        }
        return const SizedBox();
      },
      
    );
  }
  
  Widget _getNormalBody(CartCubitInterActiveState state,BuildContext context){
    return Column(
      children: [
        _getProductsListWidget(state),
        _getCheckoutWidget(context, state),
      ],
    );
  }

  Container _getCheckoutWidget(BuildContext context, CartCubitInterActiveState state) {
    return Container(
        height: 85,
        padding:const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: ColorManager.white,
          border: Border.all(color: ColorManager.primaryColor.withOpacity(1),width: 2),
          borderRadius: BorderRadius.circular(20)
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.price,style:Theme.of(context).textTheme.headlineMedium,),
                const SizedBox(height: 5,),
                Text("${state.totalPric} ${AppLocalizations.of(context)!.egp}",style:Theme.of(context).textTheme.titleMedium,),
              ],
            ),
            const Spacer(),
            CustomButton(
              width: null,
              height: 50,
              padding:const EdgeInsets.all(10),
              content:AppLocalizations.of(context)!.checkOut,
              onTap: ()async{
                await CartCubit.get(context).checkOut("${state.totalPric.round()}", context);
              }, 
              )
          ],
        ),
      );
  }

  Expanded _getProductsListWidget(CartCubitInterActiveState state) {
    return Expanded(
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: state.cardProducts.length,
          separatorBuilder: (context, index) =>const SizedBox(height: 5,),
          itemBuilder: (context, index) {
            return Dismissible(
              key: Key(state.cardProducts[index].productModel.id.toString()),
              onDismissed: (direction) => CartCubit.get(context).addOrRemoveToCart(state.cardProducts[index].productModel,context), 
              child: CustomRectangleCard(
                numOfElements: state.cardProducts[index].count,
                productModel: state.cardProducts[index].productModel,
                withCounter: true,
                onClickPlus:()=>CartCubit.get(context).increaseCount(index),
                onClickMinus:()=>CartCubit.get(context).decreaseCount(index),   
              ),
            );
          },
        ),
      );
  }
}