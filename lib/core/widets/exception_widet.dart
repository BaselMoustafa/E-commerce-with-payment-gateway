import 'package:e_commerce_app_with_payment_gateway/core/resources/assets_manager.dart';
import 'package:e_commerce_app_with_payment_gateway/core/style/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui'as ui;
class ExceptionWidget extends StatelessWidget {
  const ExceptionWidget({
    super.key,
    required this.text,
    });
  final String text;
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height*0.3,
            child: SvgPicture.asset(AssetsManager.notFound),
          ),
          const SizedBox(height: 20,),
          Text(
            text,
            textAlign: TextAlign.center,
            style:const TextStyle(color: ColorManager.grey,fontSize: 18,fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}