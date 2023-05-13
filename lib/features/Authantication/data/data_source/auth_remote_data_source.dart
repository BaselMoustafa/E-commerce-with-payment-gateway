import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure_messages.dart';
import '../../../../core/network/api/api_constants.dart';
import '../../../../core/network/api/api_request_model.dart';
import '../../../../core/network/api/dio_helper.dart';
import '../../domain/model/my_user/my_user.dart';


abstract class AuthRemoteDataSource extends Equatable{
  Future<MyUser>getRequest(ApiRequestModel apiRequestModel);
  @override
  List<Object?> get props => [];
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource{
  final DioHelper dioHelper;
  AuthRemoteDataSourceImpl({required this.dioHelper});


  @override
  Future<MyUser> getRequest(ApiRequestModel apiRequestModel)async{
    Response response=await dioHelper.postData(apiRequestModel);
    if(response.statusCode==200){
      if(response.data[ApiK.status]==true){
        return MyUser.fromMap(response.data[ApiK.data]);
      }
      throw ServerException(message: response.data[ApiK.message]);
    }
    throw ServerException(message: FailureMessages.serverFailure);
  }

  
     
}