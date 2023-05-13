import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_with_payment_gateway/core/error/failures.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/domain/usecases/update_user_usecase.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/update_user_cubit/update_user_cubit_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../core/network/hive/hive_constants.dart';
import 'language_cubit_states.dart';

class LanguageCubit extends Cubit<LanguageCubitStates>{
  LanguageCubit():super(LanguageInitialState());
  static LanguageCubit get(context)=>BlocProvider.of(context);
  void toggleLanugae(){
    final Box languageBox=Hive.box<String>(HiveK.languageBoxName);
    final String currentLanguageCode=languageBox.get(HiveK.languageKey);
    languageBox.put(HiveK.languageKey,currentLanguageCode=="en"?"ar":"en");
    emit(LanguageSuccessState());
  }

}