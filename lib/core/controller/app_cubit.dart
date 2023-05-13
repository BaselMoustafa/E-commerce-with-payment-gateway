// import 'package:e_commerce_app/core/controller/app_cubit_states.dart';
// import 'package:e_commerce_app/core/network/shared_preferencies/cache_helper.dart';
// import 'package:e_commerce_app/core/network/shared_preferencies/cahceConstants.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';


// class ApplicationCubit extends Cubit<ApplicationCubitStates>{
//   ApplicationCubit():super(ApplicationCubitInitialState());
//   static ApplicationCubit get(context)=>BlocProvider.of(context);

//   Locale? _locale;

//   Locale getAppLocale(){
//     if(_locale==null){
//       String? savedLocal=CacheHelper.getData(key: CacheConstants.appLocale);
//       if(savedLocal==null){
//         _locale=const Locale(CacheConstants.en);
//       }else{
//         _locale=Locale(savedLocal);
//       }
//     }
//     return _locale!;
//   }

//   void setLocale({required String langCode}){
//     _locale=Locale(langCode);
//     CacheHelper.setData(key: CacheConstants.appLocale, value: langCode);
//     emit(ApplicationCubitInitialState());
//   }

// }