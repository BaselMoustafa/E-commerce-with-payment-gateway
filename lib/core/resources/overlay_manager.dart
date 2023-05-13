

import 'package:flutter/material.dart';

abstract class OverlayManager{
  
  static OverlayEntry? _overlayEntry;
  
  static void addFixedOverlay(BuildContext context,{
    Offset? offset,
    bool dismissOnTap=true,
    required Widget widget,
    required VoidCallback? whenDismiss,
  }){
    if(_overlayEntry==null){
      _decideCorrectBuilder(whenDismiss,widget,dismissOnTap, context, offset);
    }else{
      throw Exception("FROM BASEL==>ALREADY ONE ENTERY EXISTT");
    }
  }

  static void removeOverLay(){
    if(_overlayEntry!=null){
      _overlayEntry!.remove();
      _overlayEntry=null;
    }
    
  }

  static void _decideCorrectBuilder(VoidCallback? whenDismiss,Widget widget, bool dismissOnTap, BuildContext context, Offset? offset) {
    OverlayState overlayState=Overlay.of(context);
    _overlayEntry= OverlayEntry(
      builder: (_){
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
              children: [
                InkWell(
                  onTap: (){
                    if(dismissOnTap){
                      if(whenDismiss!=null){
                        whenDismiss.call();
                      }
                      removeOverLay();
                    }
                  },
                  child: _backGroundDesign(),
                ),
                offset==null?_centerTheGivenWidget(widget):_positinTheGivenWidget(offset, widget),
              ],
            ),          
            
        ); 
      },
    );
    overlayState.insert(_overlayEntry!);
  }

  static Container _backGroundDesign() {
    return Container(
      color: Colors.blueGrey.withOpacity(0.3),
    );
  }

  static PositionedDirectional _positinTheGivenWidget(Offset offset, Widget widget) {
    return PositionedDirectional(
      top: offset.dy,
      start: offset.dx,
      child: widget,
    );
  }

  static Center _centerTheGivenWidget(Widget widget) {
    return Center(child: widget,);
  }
  

  
}
  
  