import 'package:e_commerce_app_with_payment_gateway/core/style/color_manager.dart';
import 'package:e_commerce_app_with_payment_gateway/core/widets/colored_svg_widget.dart';
import 'package:flutter/material.dart';

class CustomIconWidget extends StatelessWidget {
  const CustomIconWidget({this.diameter=26,this.colorOfIcon=ColorManager.white,required this.pathOfIconAtAssets,required this.colorOfBackGround,super.key});
  final Color colorOfBackGround;
  final Color colorOfIcon;
  final String pathOfIconAtAssets;
  final double diameter;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      padding:const EdgeInsets.all(6),
      decoration:BoxDecoration(
        shape: BoxShape.circle,
        color: colorOfBackGround,
      ),
      child: ColoredSvgPicture(color: colorOfIcon, path: pathOfIconAtAssets),
    );
  }
}