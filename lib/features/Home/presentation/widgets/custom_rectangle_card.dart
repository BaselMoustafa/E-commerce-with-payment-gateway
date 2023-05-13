import 'package:e_commerce_app_with_payment_gateway/core/style/color_manager.dart';
import 'package:e_commerce_app_with_payment_gateway/core/widets/custom_cached_network_image.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/data/model/product_model/product_model.dart';
import 'package:flutter/material.dart';

class CustomRectangleCard extends StatelessWidget {
  const CustomRectangleCard({this.numOfElements=0,this.onClickPlus,this.onClickMinus,this.onDelete,required this.productModel,this.cardHeight=120,this.withCounter=false,super.key});
  final double cardHeight;
  final bool withCounter;
  final ProductModel productModel;
  final VoidCallback? onClickPlus;
  final VoidCallback? onClickMinus;
  final VoidCallback? onDelete;
  final int numOfElements;  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: cardHeight,
      child:Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorManager.white,
          border: Border.all(color: ColorManager.primaryColor.withOpacity(0.2),width: 1),
        ),
        child: _getMainDesign(context),
      ),
    );
  }

  Row _getMainDesign(BuildContext context) {
    return Row(
      children: [
        _getImage(),
        _getNameAndPrice(context),
        withCounter?_getCounterWidget(context):_getDeleteWidget(),
        const SizedBox(width: 10,),
      ],
    );
  }

  Widget _getDeleteWidget(){
    return InkWell(
      onTap:onDelete,
      child:const CircleAvatar(backgroundColor: ColorManager.primaryColor,radius: 17,child: Icon(Icons.delete,color: ColorManager.white,size: 19,),),
    );
  }

  Padding _getCounterWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap:onClickPlus,
            child:const Icon(Icons.add,color: ColorManager.grey,),
          ),
          Container(
            height: 30,
            width: 30,
            decoration:  BoxDecoration(
              border: Border.all(width: 2,color: ColorManager.primaryColor),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(child: Text("$numOfElements",style: Theme.of(context).textTheme.bodyLarge,)),
          ),
          InkWell(
            onTap:onClickMinus,
            child:const Icon(Icons.remove,color: ColorManager.grey,),
          ),
        ],
      ),
    );
  }

  Expanded _getNameAndPrice(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsetsDirectional.only(top: 10,bottom: 10,end: 10,),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(productModel.name,maxLines: 3,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.bodyLarge,),
            const Spacer(),
            Row(
              children: [
                if(productModel.discount!=0)
                Text("${productModel.oldPrice.round()} ",style:const TextStyle(color: ColorManager.grey,fontWeight: FontWeight.w900,decoration: TextDecoration.lineThrough),),
                Text("${productModel.price} EGP",style: Theme.of(context).textTheme.headlineLarge,),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container _getImage() {
    return Container(
      height: 120,
      width: 120,
      padding:const EdgeInsets.all(15),
      decoration:const BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(20),bottomStart: Radius.circular(20)),
      ),
      child:CustomCachedNetworkImage(
        imageUrl: productModel.image,
        boxFit: BoxFit.fill,
      ),
    );
  }
}