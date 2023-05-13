import 'package:e_commerce_app_with_payment_gateway/core/style/color_manager.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';


abstract class ThemeManager extends Equatable{
  
  static ThemeData getAppTheme(){
    return ThemeData(
      fontFamily: GoogleFonts.inter().fontFamily ,
      scaffoldBackgroundColor: ColorManager.white,
      iconTheme:const IconThemeData(color: ColorManager.white,opacity: 1),
      floatingActionButtonTheme:const FloatingActionButtonThemeData(
        backgroundColor: ColorManager.primaryColor,
        foregroundColor: ColorManager.white,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        color: ColorManager.transperent,
        titleTextStyle: TextStyle(
          color: ColorManager.primaryColor,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w900,
        ),
        
        systemOverlayStyle:const SystemUiOverlayStyle(
          statusBarColor: ColorManager.transperent,
          statusBarIconBrightness: Brightness.dark,
        ),  
      ),

      textTheme: const TextTheme(
        //labels 
        displayLarge:TextStyle(color: ColorManager.black,fontWeight: FontWeight.w900,fontSize: 18),
        //Desciption of product and all oredinary text
        bodyLarge:TextStyle(fontSize: 13,fontWeight: FontWeight.w600,color: ColorManager.black,),

        //For maain prices
        headlineLarge:TextStyle(fontSize: 14,fontWeight: FontWeight.w900,color: ColorManager.primaryColor,), 
        //Price word at ceck out widget
        headlineMedium:TextStyle(fontSize: 16,fontWeight: FontWeight.bold), 
        //Actual price at checkout widget
        titleMedium:TextStyle(fontSize: 17,fontWeight: FontWeight.w900,color: ColorManager.primaryColor,), 
        
        //FOR THE TITLE AT FILTER WIDGET
        bodySmall:TextStyle(
          color: Colors.grey,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
            
      ) 
    );
  }

  List<Object?> get props => [];
}