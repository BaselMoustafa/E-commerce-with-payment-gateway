import 'package:e_commerce_app_with_payment_gateway/core/style/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showMyToast({required String message , Color color=ColorManager.red}){

  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 3,
    backgroundColor:color,
    textColor: ColorManager.white,
    fontSize: 16.0
  );

}