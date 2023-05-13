import 'package:e_commerce_app_with_payment_gateway/core/network/api/dio_helper.dart';
import 'package:e_commerce_app_with_payment_gateway/core/network/hive/hive_helper.dart';
import 'package:e_commerce_app_with_payment_gateway/core/payment_gateway/env_constants.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/card_cubit/card_cubit.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/get_user_cubit/get_user_cubit.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/search_products_cubit/search_products_cubit.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/update_user_cubit/update_user_cubit.dart';
import 'package:e_commerce_app_with_payment_gateway/l10n/language_cubit/language_cubit.dart';
import 'package:e_commerce_app_with_payment_gateway/l10n/language_cubit/language_cubit_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/service_locatot/service_locator.dart';
import 'core/style/theme_maager.dart';
import 'features/Authantication/presentation/controllers/initialize_app_cubit/initialize_app_cubit.dart';
import 'features/Authantication/presentation/controllers/sign_in_cubit/sign_in_cubit.dart';
import 'features/Authantication/presentation/controllers/sign_up_cubit/sign_up_cubit.dart';
import 'features/Home/presentation/controllers/add_remove_favorites_cubit/add_remove_favorites_cubit.dart';
import 'features/Home/presentation/controllers/get_favorites_cubit/get_favorites_cubit.dart';
import 'features/Home/presentation/controllers/get_home_data_cubit/get_home_data_cubit.dart';
import 'features/Home/presentation/controllers/initialize_favorites_cubit/initialize_favorites_cubit.dart';
import 'features/Home/presentation/controllers/profile_cubit/profile_cubit.dart';
import 'l10n/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:ui' as ui;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await HiveHelper.init(); 

  await Hive.openBox("test");

  DioHelperImpl().init();
  ServiceLocator().init();
  await dotenv.load(fileName: EnvK.fileName);
  Stripe.publishableKey=dotenv.get(EnvK.stripePublishableKey);
  await Stripe.instance.applySettings();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>SignUpCubit(signUpUsecase: getIt())),
        BlocProvider(create: (context)=>SignInCubit(signInUsecase: getIt())),
        BlocProvider(create: (context)=>ProfileCubit(signOutUseCase: getIt())),
        BlocProvider(create: (context)=>InitializeAppCubit(initializeAppUseCase: getIt())),
        BlocProvider(create: (context)=>GetHomeDataCubit(getHomeDataUseCase: getIt())),
        BlocProvider(create: (context)=>AddOrRemoveFavoritesCubit(addOrRemoveFavoritesUsecase: getIt())),
        BlocProvider(create: (context)=>GetFavoritesProductsCubit(getFavoritesProductsUsecase: getIt())),
        BlocProvider(create: (context)=>InitializeFavoritesCubit(initializeFavoritesUsecase: getIt())),
        BlocProvider(create: (context)=>CartCubit()),
        BlocProvider(create: (context)=>SearchProductsCubit(searchProductsUsecase: getIt())),
        BlocProvider(create: (context)=>GetUserCubit(getUserUseCase: getIt())),
        BlocProvider(create: (context)=>UpdateUserCubit(updateUserUseCase: getIt())),
        BlocProvider(create: (context)=>LanguageCubit()),
      ], 
      child:const MyApplicationWidget(),
    );
  }

}

class MyApplicationWidget extends StatelessWidget {
  const MyApplicationWidget({super.key,});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit,LanguageCubitStates>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeManager.getAppTheme(),
          supportedLocales: L10n.all,
          locale: L10n.getTheCorrectLanguage(ui.window.locale),
          localizationsDelegates:const [
            AppLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
          home: InitializeAppCubit.get(context).getStartScreen(context),
        );  
      },
    );
  }
}