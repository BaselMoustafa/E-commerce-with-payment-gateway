import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_with_payment_gateway/core/error/failures.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/data/model/home_data_model/home_data_model.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/data/model/product_model/product_model.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/domain/usecases/get_home_data_usecase.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/get_home_data_cubit/get_home_data_cubit_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetHomeDataCubit extends Cubit<GetHomeDataCubitStates>{
  final GetHomeDataUseCase getHomeDataUseCase;
  GetHomeDataCubit({required this.getHomeDataUseCase}):super(GetHomeDataInitialState());
  static GetHomeDataCubit get(context)=> BlocProvider.of(context);
  late HomeDataModel _homeDataModel;
  Future<void>getHomeData(String token)async{
    emit(GetHomeDataLoadingState());
    Either<Failure , HomeDataModel>homeDataOrFailure = await getHomeDataUseCase.excute(token);
    homeDataOrFailure.fold(
      (failure){
        emit(GetHomeDataFailedState(message: failure.message));
      },
      (homeDataModel){
        _homeDataModel=homeDataModel;
        emit(GetHomeDataSuccessState(homeDataModel: homeDataModel));
      },
    );
  }

  void refresh(){
    emit(GetHomeDataSuccessState(homeDataModel: _homeDataModel));
  }

  void updateDisplayedList(ProductModel productModel){
    int index= _homeDataModel.products.indexWhere((element) => element.id==productModel.id);
    _homeDataModel.products[index].inFav=!_homeDataModel.products[index].inFav;
    refresh();
  }

}