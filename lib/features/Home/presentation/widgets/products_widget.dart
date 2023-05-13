import 'package:e_commerce_app_with_payment_gateway/core/resources/navigator_manager.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Authantication/domain/model/my_user/my_user.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/data/model/product_model/product_model.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/add_remove_favorites_cubit/add_remove_favorites_cubit.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/card_cubit/card_cubit.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/get_home_data_cubit/get_home_data_cubit.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/screens/product_details_screen/product_details_screen.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/widgets/custom_square_card.dart';
import 'package:flutter/material.dart';

class ProductsWidget extends StatelessWidget {
  const ProductsWidget({super.key,required this.myUser,required this.products});
  final MyUser myUser;
  final List<ProductModel>products;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 5,crossAxisSpacing: 5,childAspectRatio: 2.2/3),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return CustomSquareCard(
          atCart: CartCubit.get(context).thisProductIsAtCart(products[index].id),
          productModel: products[index],
          onCartTap: ()=>CartCubit.get(context).addOrRemoveToCart(products[index],context),
          onProductTap: ()=>NavigatorManager.navigateTo(
              context, 
              ProductDetailsScreen(productModel: products[index]),
              toExcuteAfterPop: ()=>GetHomeDataCubit.get(context).refresh(),
              ),
          onFavTap: ()async{
            await AddOrRemoveFavoritesCubit.get(context).addOrRemoveFavorites(context,products[index],myUser.token);
          },
        );
      },
    );
  }
}