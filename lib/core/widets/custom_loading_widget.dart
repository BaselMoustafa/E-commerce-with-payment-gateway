import 'dart:async';

import 'package:e_commerce_app_with_payment_gateway/core/style/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CustomLoadinWidget extends StatefulWidget {
  const CustomLoadinWidget({super.key});

  @override
  State<CustomLoadinWidget> createState() => _CustomLoadinWidgetState();
}

class _CustomLoadinWidgetState extends State<CustomLoadinWidget> {

  late Timer _timer;
  int _activeIndex=0;

  @override
  void initState() {
    super.initState();
    _timer=Timer.periodic(
      const Duration(milliseconds: 500), 
      (timer) {
        _activeIndex==4?_activeIndex=0:_activeIndex++;
        setState(() {});
      },
      );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        spacing: 5,
        children: [
          for (int i=0;i<5;i++)
          SizedBox(
            height: 40,
            child: AnimatedContainer(
              duration:const Duration(milliseconds: 350),
              width: _getCorrectDiameter(i),
              height: _getCorrectDiameter(i),
              decoration:BoxDecoration(
                shape: BoxShape.circle,
                color: _getCorrectColor(i),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _getCorrectDiameter(int currentIndex){
    if(currentIndex-_activeIndex==1||currentIndex-_activeIndex==-1||currentIndex-_activeIndex==4||currentIndex-_activeIndex==-4){
      return 25;
    }
    if(currentIndex-_activeIndex==2||currentIndex-_activeIndex==-2||currentIndex-_activeIndex==3||currentIndex-_activeIndex==-3){
      return 10;
    }
    return 40;
  }
  Color _getCorrectColor(int currentIndex){
    if(currentIndex-_activeIndex==1||currentIndex-_activeIndex==-1||currentIndex-_activeIndex==4||currentIndex-_activeIndex==-4){
      return ColorManager.primaryColor.withOpacity(0.4);
    }
    if(currentIndex-_activeIndex==2||currentIndex-_activeIndex==-2||currentIndex-_activeIndex==3||currentIndex-_activeIndex==-3){
      return ColorManager.primaryColor.withOpacity(0.2);
    }
    return ColorManager.primaryColor;
  }


}