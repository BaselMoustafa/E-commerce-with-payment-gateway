import 'package:dio/dio.dart';
import 'package:e_commerce_app_with_payment_gateway/core/network/api/api_constants.dart';
import 'package:e_commerce_app_with_payment_gateway/core/network/api/api_request_model.dart';

abstract class DioHelper{
  Future<Response> getData(ApiRequestModel apiRequestModel);
  Future<Response> postData(ApiRequestModel apiRequestModel);
  Future<Response> deleteData(ApiRequestModel apiRequestModel);
  Future<Response> updateData(ApiRequestModel apiRequestModel);
} 

class DioHelperImpl implements DioHelper{
  static late Dio dio;

  void init(){
    dio=Dio(
      BaseOptions(
        baseUrl: ApiK.baseUrl,
        receiveDataWhenStatusError: true,       
      ),
    );
  }

  @override
  Future<Response> getData(ApiRequestModel apiRequestModel)async{
    Response response =await dio.get(
      apiRequestModel.endPoint,
      queryParameters: apiRequestModel.queries,
      data:apiRequestModel.body,
      options: Options(
        headers: apiRequestModel.headers,
      )
    );
    return response;
  }

  @override
  Future<Response> postData(ApiRequestModel apiRequestModel)async{
    Response response =await dio.post(
      apiRequestModel.endPoint,
      queryParameters: apiRequestModel.queries,
      data:apiRequestModel.body,
      options: Options(
        headers: apiRequestModel.headers,
      )
    );
    return response;
  }

  @override
  Future<Response> deleteData(ApiRequestModel apiRequestModel)async{
    Response response =await dio.delete(
      apiRequestModel.endPoint,
      queryParameters: apiRequestModel.queries,
      data:apiRequestModel.body,
      options: Options(
        headers: apiRequestModel.headers,
      )
    );
    return response;
  }

  @override
  Future<Response> updateData(ApiRequestModel apiRequestModel)async{
    Response response =await dio.put(
      apiRequestModel.endPoint,
      queryParameters: apiRequestModel.queries,
      data:apiRequestModel.body,
      options: Options(
        headers: apiRequestModel.headers,
      )
    );
    return response;
  }
  
}