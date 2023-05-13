import 'package:e_commerce_app_with_payment_gateway/core/network/api/dio_helper.dart';
import 'package:e_commerce_app_with_payment_gateway/core/network/api/network_connection_info.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Authantication/data/data_source/auth_local_data_source.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Authantication/data/data_source/auth_remote_data_source.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Authantication/data/reposatory_impl/authantication_reposatory_impl.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Authantication/domain/reposatory/auth_reposatory.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Authantication/domain/usecases/initialize_app_usecase.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Authantication/domain/usecases/sign_in_use_case.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Authantication/domain/usecases/sign_up_usecase.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Authantication/presentation/controllers/initialize_app_cubit/initialize_app_cubit.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Authantication/presentation/controllers/sign_in_cubit/sign_in_cubit.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Authantication/presentation/controllers/sign_up_cubit/sign_up_cubit.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/data/data_sorce/home_local_data_source.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/data/data_sorce/home_remote_data_source.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/data/repo_impl/home_repo_impl.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/domain/home_repo/home_repo.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/domain/usecases/add_or_remove_favorites.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/domain/usecases/get_favorites_usecase.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/domain/usecases/get_home_data_usecase.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/domain/usecases/get_user_usecase.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/domain/usecases/initialize_favorites.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/domain/usecases/search_products_usecase.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/domain/usecases/signout_usecase.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/domain/usecases/update_user_usecase.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/add_remove_favorites_cubit/add_remove_favorites_cubit.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/get_favorites_cubit/get_favorites_cubit.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/get_home_data_cubit/get_home_data_cubit.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/get_user_cubit/get_user_cubit.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/initialize_favorites_cubit/initialize_favorites_cubit.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/profile_cubit/profile_cubit.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/search_products_cubit/search_products_cubit.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/update_user_cubit/update_user_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';



final getIt = GetIt.instance;
class ServiceLocator {
  
  void init(){
      //Home Feature
            //Cubits
            getIt.registerFactory(() => ProfileCubit(signOutUseCase: getIt()));
            getIt.registerFactory(() => GetHomeDataCubit(getHomeDataUseCase: getIt()));
            getIt.registerFactory(() => AddOrRemoveFavoritesCubit(addOrRemoveFavoritesUsecase: getIt()));
            getIt.registerFactory(() => GetFavoritesProductsCubit(getFavoritesProductsUsecase: getIt()));
            getIt.registerFactory(() => InitializeFavoritesCubit(initializeFavoritesUsecase: getIt()));
            getIt.registerFactory(() => SearchProductsCubit(searchProductsUsecase: getIt()));
            getIt.registerFactory(() => GetUserCubit(getUserUseCase: getIt()));
            getIt.registerFactory(() => UpdateUserCubit(updateUserUseCase: getIt()));
                
            //USECASES
            getIt.registerLazySingleton(() =>SignOutUseCase(homeRepo: getIt()) );
            getIt.registerLazySingleton(() =>GetHomeDataUseCase(homeRepo: getIt()) );
            getIt.registerLazySingleton(() =>AddOrRemoveFavoritesUsecase(homeRepo: getIt()) );
            getIt.registerLazySingleton(() =>GetFavoritesProductsUsecase(homeRepo: getIt()) );
            getIt.registerLazySingleton(() =>InitializeFavoritesUsecase(homeRepo: getIt()) );
            getIt.registerLazySingleton(() =>SearchProductsUsecase(homeRepo: getIt()) );
            getIt.registerLazySingleton(() =>GetUserUseCase(homeRepo: getIt()) );
            getIt.registerLazySingleton(() =>UpdateUserUseCase(homeRepo: getIt()) );

                
            //REPOSITORY
            getIt.registerLazySingleton<HomeRepo>(() => HomeReposImpl( 
              networkConnectionInfo:getIt(),homeLocaleDataSource: getIt(),homeRemoteDataSource: getIt()) );

            //DATA SOURCE
            //WHEN I CALL BASE OR NOT BASE IT WILL USE THE SAME OBJECT
            getIt.registerLazySingleton<HomeLocaleDataSource>(() => HomeLocaleDataSourceImpl());
            getIt.registerLazySingleton<HomeRemoteDataSource>(() => HomeRemoteDataSourceImpl( dioHelper: getIt()));






      //Auhantication Feature
            //Cubits
            getIt.registerFactory(() => SignInCubit(signInUsecase: getIt()));
            getIt.registerFactory(() => SignUpCubit(signUpUsecase: getIt()));
            getIt.registerFactory(() => InitializeAppCubit(initializeAppUseCase: getIt()));
                
            //USECASES
            getIt.registerLazySingleton(() =>SignInUsecase(authanticationReposatory: getIt()) );
            getIt.registerLazySingleton(() =>SignUpUsecase(authanticationReposatory: getIt()) );
            getIt.registerLazySingleton(() =>InitializeAppUseCase(authanticationReposatory: getIt()) );
                
            //REPOSITORY
            getIt.registerLazySingleton<AuthanticationReposatory>(() => AuthanticationReposatoryImpl( 
              networkConnectionInfo:getIt(),authLocalDataSource: getIt(),authRemoteDataSource: getIt()) );

            //DATA SOURCE
            //WHEN I CALL BASE OR NOT BASE IT WILL USE THE SAME OBJECT
            getIt.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSourceImpl());
            getIt.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl( dioHelper: getIt()));

            //helpers
            getIt.registerLazySingleton<DioHelper>(() => DioHelperImpl() );

            //connectiob checker
            getIt.registerLazySingleton<NetworkConnectionInfo>(() =>NetworkConnectionInfoImple(internetConnectionChecker: InternetConnectionChecker()) );


  }

}
