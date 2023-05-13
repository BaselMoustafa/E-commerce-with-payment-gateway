import 'package:dio/dio.dart';
import 'package:e_commerce_app_with_payment_gateway/core/error/failure_messages.dart';
import 'package:e_commerce_app_with_payment_gateway/core/payment_gateway/env_constants.dart';
import 'package:e_commerce_app_with_payment_gateway/core/style/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class FlutterStripePayment{
  static  Map<String,dynamic>? _paymentIntent;
  
  static String _calculateAmount(String amount) =>((int.parse(amount)) * 100).toString();

  static Future<void> makePayment(String amount,String currency,BuildContext context) async {
    if(await InternetConnectionChecker().hasConnection){
      
      try{
        _paymentIntent = await _createPaymentIntent(amount, currency,context);
        await _initializePaymentSheet(_paymentIntent);
        await _displayPaymentSheet(context);
      }catch(ex){
        rethrow ;
      }
      
    }else{
      _showDialog(context, message: FailureMessages.offline);
    }
    
  }

  static Future _createPaymentIntent(String amount, String currency,BuildContext context) async {
    Dio dio=Dio();
    try {
      var response = await dio.post(
        'https://api.stripe.com/v1/payment_intents',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${dotenv.env[EnvK.stripeSecretKey]}',
            'Content-Type': 'application/x-www-form-urlencoded'
          },
        ),
        data: {
          'amount': _calculateAmount(amount),
          'currency': currency,
        },
      );
      return response.data as Map<String,dynamic>;
    } catch (err) {
      _showDialog(context, message: err.toString());
      throw Exception();
    }
  }

  static Future  _initializePaymentSheet(paymentIntent) async {
    return await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntent!['client_secret'],
        style: ThemeMode.dark,
        merchantDisplayName: 'Ikay'),
        );
  }

  static Future _displayPaymentSheet(BuildContext context) async {

    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        _paymentIntent = null;
        _showDialog(context, message:AppLocalizations.of(context)!.completed,color: ColorManager.green);
      }).onError((error, stackTrace){
        if(error is StripeException){
          _handleStripeEception(error, context);
        }else{
          _showDialog(context, message: error.toString());
        }
        throw Exception();
      });
    } on StripeException catch (e) {
      _handleStripeEception(e, context);
      throw Exception();
    } catch (e) {
      //If it closed with out complete will be hereee
      throw Exception();
    }
  }

  static void _handleStripeEception(StripeException stripeException,BuildContext context){
    if(stripeException.error.code==FailureCode.Failed){
      _showDialog(context, message:AppLocalizations.of(context)!.failedToPay);
    }
    if(stripeException.error.code==FailureCode.Timeout){
      _showDialog(context, message: AppLocalizations.of(context)!.timeoutBeforeCompleteProcess);
    }
  }
  
  static void _showDialog(BuildContext context,{required String message,Color color=ColorManager.red}){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                color==ColorManager.red? Icons.error:Icons.check_circle,
                color: color,
                size: 80.0,
              ),
              const SizedBox(height: 10.0),
              Text(
                message,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
  

}