import 'package:e_commerce_app_with_payment_gateway/core/style/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmerWidget extends StatelessWidget {

  final double height;
  final double? width;
  double? borderRadius;
  late final BoxShape shape;


  CustomShimmerWidget.rectangle({required this.height,this.borderRadius,this.width=double.infinity,super.key}){
    shape=BoxShape.rectangle; 
  }
  CustomShimmerWidget.circular({required this.height,this.width,super.key}){
    
    shape=BoxShape.circle; 
  }

  @override
  Widget build(BuildContext context)=>Shimmer.fromColors(
    baseColor: Colors.grey[400]!, 
    highlightColor: Colors.grey[300]!,
    child: Container(
        height: height,
        width: width,
        decoration:BoxDecoration(
          color: Colors.grey,
          borderRadius:borderRadius!=null?BorderRadius.circular(borderRadius!):null,
          shape:shape, 
        ),
      ) 
    );
}