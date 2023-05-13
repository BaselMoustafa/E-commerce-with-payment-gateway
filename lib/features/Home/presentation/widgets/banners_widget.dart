import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app_with_payment_gateway/core/style/color_manager.dart';
import 'package:e_commerce_app_with_payment_gateway/core/widets/custom_cached_network_image.dart';
import 'package:e_commerce_app_with_payment_gateway/core/widets/error_image_widget.dart';
import 'package:flutter/material.dart';

class BannersWidget extends StatefulWidget {
  const BannersWidget({required this.banners,this.height=150,super.key});
  final List<String>banners;
  final double height;
  @override
  State<BannersWidget> createState() => _BannersWidgetState();
}

class _BannersWidgetState extends State<BannersWidget> {
  Timer? _timer;
  Timer? _afterUserTapTimer;
  final PageController _pageController=PageController();
  int _pageIndex=0;
  @override
  void initState() {
    super.initState();
    _intializeTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer!=null?_timer!.cancel():null;
  }

  void _intializeTimer(){
    _timer=Timer.periodic(
      const Duration(seconds: 3), 
      (timer) {
        _pageIndex==widget.banners.length-1?_pageIndex=0:_pageIndex++;
        _pageIndex==0? 
        _pageController.jumpToPage(_pageIndex,)
        :_pageController.animateToPage(_pageIndex, duration: Duration(milliseconds: 1000), curve: Curves.fastOutSlowIn);
        
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      
      onHorizontalDragCancel: () async{
        if (_timer!=null) {
          _timer!.cancel();
          _timer=null;
        }
        if(_afterUserTapTimer!=null){
          _afterUserTapTimer!.cancel();
          _afterUserTapTimer=null;
        }
        
        _afterUserTapTimer=Timer(
          const Duration(seconds: 5),
          () {
            _intializeTimer();
          }
          );
      },
      child: SizedBox(
        height: 150,
        child: PageView.builder(
          controller: _pageController,
          itemCount: widget.banners.length,
          scrollDirection: Axis.horizontal,
          onPageChanged: (value) {
            _pageIndex=value;
          },
          itemBuilder: (context, index) {
            return Align(
              alignment: AlignmentDirectional.center,
              child: Container(
                height: widget.height,
                width: double.infinity,   
                clipBehavior: Clip.antiAliasWithSaveLayer,             
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: CustomCachedNetworkImage(
                    imageUrl: widget.banners[index],
                    boxFit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}