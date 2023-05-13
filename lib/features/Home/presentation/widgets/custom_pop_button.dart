import 'package:e_commerce_app_with_payment_gateway/core/resources/navigator_manager.dart';
import 'package:flutter/material.dart';
import '../../../../core/style/color_manager.dart';

class CustomPopButton extends StatelessWidget {
  const CustomPopButton({super.key});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>NavigatorManager.pop(context),
      child: const CircleAvatar(backgroundColor: ColorManager.transperent,child: Icon(Icons.arrow_back_rounded,size: 30,color: ColorManager.black,),),
    );
  }
}