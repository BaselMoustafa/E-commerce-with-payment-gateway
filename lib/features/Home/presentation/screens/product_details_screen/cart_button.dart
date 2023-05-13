import 'package:e_commerce_app_with_payment_gateway/core/style/color_manager.dart';
import 'package:e_commerce_app_with_payment_gateway/core/widets/customButton.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/data/model/product_model/product_model.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/card_cubit/card_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class AddToCartButton extends StatefulWidget {
  const AddToCartButton({
    super.key,
    required this.productModel,
    required double buttonHeight,
  }) : _buttonHeight = buttonHeight;
  final ProductModel productModel;
  final double _buttonHeight;

  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomButton(
        onTap: (){
          CartCubit.get(context).addOrRemoveToCart(widget.productModel,context);
          setState(() {});
        }, 
        height: widget._buttonHeight,
        buttonColor: CartCubit.get(context).thisProductIsAtCart(widget.productModel.id)?ColorManager.primaryColor:ColorManager.scaffoldBackgroundColor,
        contentColor: CartCubit.get(context).thisProductIsAtCart(widget.productModel.id)?ColorManager.white:ColorManager.black,
        content: CartCubit.get(context).thisProductIsAtCart(widget.productModel.id)?AppLocalizations.of(context)!.removeFromCart:AppLocalizations.of(context)!.addToCart,
      ),
    );
  }
}