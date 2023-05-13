import 'package:flutter/material.dart';

abstract class NavigatorManager{
  
  static void navigateTo(BuildContext context,Widget widget,{VoidCallback? toExcuteAfterPop}){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:(contextOfDes) =>widget,
      ),
    ).then((value) =>toExcuteAfterPop!=null?toExcuteAfterPop.call():null);
  }

  static void nagivateToAndCloseThePreviousScreens(BuildContext context,Widget widget){
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder:(contextOfDes) =>widget,
      ),
      (route){
        return false;
      },
    );
  }

  static void navigateAndReplace(BuildContext context,Widget widget){
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(builder: ((context) => widget)),
      );
  }
  
  static void pop(BuildContext context){
    Navigator.pop(context);
  }
}