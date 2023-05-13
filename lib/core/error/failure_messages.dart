import 'dart:ui' as ui;
abstract class FailureMessages{
  static String localDataBaseFailure=ui.window.locale.languageCode=="en"?
  "We face proplems when we deal with your files":"نواجه مشاكل في الملفات الخاصة بك";
  static  String serverFailure=ui.window.locale.languageCode=="en"?
  "We have some problems when connect with server":"هناك مشاكل في الاتصال مع الخادم";
  static  String offline=ui.window.locale.languageCode=="en"?
  "Please check your network connection":"برجاء التاكد من الاتصال بالانترنت";
}