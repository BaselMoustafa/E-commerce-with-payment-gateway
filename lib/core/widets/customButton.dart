import 'package:e_commerce_app_with_payment_gateway/core/style/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({this.buttonColor=ColorManager.primaryColor,this.padding,this.contentColor=ColorManager.white,required this.onTap,required this.content,this.height=60,this.width=double.infinity});
  final VoidCallback? onTap;
  final String? content;
  final double height;
  final double? width;
  final Color buttonColor;
  final Color contentColor;
  final EdgeInsets? padding;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: content!=null? 
            Text(content!,style: TextStyle(color: contentColor,fontWeight: FontWeight.bold,fontSize: 15)):const CircularProgressIndicator(color: ColorManager.white,),
        ),
      ),
    );
  }
}