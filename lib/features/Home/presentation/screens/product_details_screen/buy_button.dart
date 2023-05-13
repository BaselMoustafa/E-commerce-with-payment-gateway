import 'package:e_commerce_app_with_payment_gateway/core/widets/customButton.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/data/model/product_model/product_model.dart';
import 'package:flutter/material.dart';
import '../../controllers/card_cubit/card_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class BuyButton extends StatelessWidget {
  const BuyButton({super.key,required this.buttonHeight,required this.productModel});
  final ProductModel productModel;
  final double buttonHeight;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomButton(
        height: buttonHeight,
        onTap: ()async{
          await CartCubit.get(context).checkOut(productModel.price.round().toString(), context);
        }, 
        content:AppLocalizations.of(context)!.buyNow,
      ),
    );
  }
}