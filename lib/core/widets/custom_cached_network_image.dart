import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app_with_payment_gateway/core/resources/assets_manager.dart';
import 'package:e_commerce_app_with_payment_gateway/core/style/color_manager.dart';
import 'package:e_commerce_app_with_payment_gateway/core/widets/colored_svg_widget.dart';
import 'package:flutter/widgets.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({
  required this.imageUrl,
  this.boxFit=BoxFit.fill,
  this.height,
  this.width,
  super.key,
  });
  final String imageUrl;
  final BoxFit boxFit;
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl:imageUrl,
      fit: boxFit,
      height: height,
      width: width,
      errorWidget: (context, url, error) {
        return Center(
          child: ColoredSvgPicture(color: ColorManager.primaryColor, path: AssetsManager.noImage),
        );
      },
    );
  }
}