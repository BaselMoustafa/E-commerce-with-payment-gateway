import 'package:e_commerce_app_with_payment_gateway/core/resources/assets_manager.dart';
import 'package:e_commerce_app_with_payment_gateway/core/style/color_manager.dart';
import 'package:e_commerce_app_with_payment_gateway/core/widets/custom_cached_network_image.dart';
import 'package:e_commerce_app_with_payment_gateway/core/widets/custom_icon_widget.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/data/model/product_model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomSquareCard extends StatefulWidget {
  const CustomSquareCard({
    required this.productModel,
    required this.atCart,
    required this.onCartTap,
    required this.onFavTap,
    required this.onProductTap,
    super.key,
  });
  final ProductModel productModel;
  final VoidCallback onProductTap; 
  final VoidCallback onFavTap; 
  final VoidCallback onCartTap;
  final bool atCart;
  @override
  State<CustomSquareCard> createState() => _CustomSquareCardState();
}

class _CustomSquareCardState extends State<CustomSquareCard> {
  bool? atCart;
  @override
  Widget build(BuildContext context) {
    atCart==null?atCart=widget.atCart:null;
    return InkWell(
      onTap: widget.onProductTap,
      child: Container(
        padding:const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: ColorManager.primaryColor.withOpacity(0.2),width: 1)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap:widget.onFavTap,
              child: Align(
                alignment: AlignmentDirectional.topEnd,
                child: CustomIconWidget(
                  pathOfIconAtAssets: AssetsManager.favIcon, 
                  colorOfBackGround: widget.productModel.inFav?ColorManager.red:ColorManager.grey, 
                  ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding:const EdgeInsetsDirectional.only(top: 10,bottom: 20,start: 20,end: 20),
                child: CustomCachedNetworkImage(
                  imageUrl: widget.productModel.image,
                  boxFit: BoxFit.contain,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
            Text(widget.productModel.name,maxLines: 2,style:const TextStyle(color: ColorManager.black,fontWeight: FontWeight.w500,overflow: TextOverflow.ellipsis),),
            const SizedBox(height: 3,),
            Row(
              children: [
                if(widget.productModel.discount!=0)
                Text("${widget.productModel.oldPrice.round()}",style:const TextStyle(color: ColorManager.grey,fontWeight: FontWeight.w900,decoration: TextDecoration.lineThrough),),
                const SizedBox(width: 2,),
                Expanded(child: Text("${widget.productModel.price.round()} ${AppLocalizations.of(context)!.egp}",maxLines: 1,overflow: TextOverflow.ellipsis,style:Theme.of(context).textTheme.headlineLarge)),
                InkWell(
                  onTap:(){
                    widget.onCartTap.call();
                    atCart=!atCart!;
                    setState(() {});
                  },
                  child: Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: CustomIconWidget(
                      pathOfIconAtAssets: AssetsManager.cartIcon, 
                      colorOfBackGround:atCart!?ColorManager.primaryColor:ColorManager.grey, 
                      ),
                  ),
                ),
              ],
            ),
  
          ],
        ),
      ),
    );
  }

}
