import 'package:e_commerce_app_with_payment_gateway/core/style/color_manager.dart';
import 'package:e_commerce_app_with_payment_gateway/core/widets/custom_loading_widget.dart';
import 'package:e_commerce_app_with_payment_gateway/core/widets/exception_widet.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Authantication/domain/model/my_user/my_user.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/data/model/product_model/product_model.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/add_remove_favorites_cubit/add_remove_favorites_cubit.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/get_favorites_cubit/get_favorites_cubit.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/get_favorites_cubit/get_favorites_cubit_states.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/widgets/custom_rectangle_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({required this.myUser,super.key});
  final MyUser myUser;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetFavoritesProductsCubit,GetFavoritesProductsCubitStates>(
      builder: (context, state) {
        if(state is GetFavoritesProductsSuccessState){
          if(state.favoriteProducts.isEmpty){
            return ExceptionWidget(text: AppLocalizations.of(context)!.thereAreNoItems,);
          }
          return _getSuccessBody(state.favoriteProducts);
        }
        if(state is GetFavoritesProductsLoadingState){
          return const CustomLoadinWidget();
        }
        if(state is GetFavoritesProductsFailedState){
          return ExceptionWidget(text: state.message,);
        }
        return const SizedBox();
      },
    );
  }

  Widget _getSuccessBody(List<ProductModel>favoritesProducts) {
    return ListView.separated(
      itemCount: favoritesProducts.length,
      separatorBuilder: (context, index) =>const SizedBox(height: 5,),
      itemBuilder: (context, index) {
        return CustomRectangleCard(
          productModel: favoritesProducts[index],
          onDelete: ()async{
            await AddOrRemoveFavoritesCubit.get(context).addOrRemoveFavorites(
              context, 
              favoritesProducts[index], 
              myUser.token,
              );
          },
        );
      },
    );
  }
}