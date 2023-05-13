import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Authantication/domain/reposatory/auth_reposatory.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure_messages.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/api/api_request_model.dart';
import '../../../../core/network/api/network_connection_info.dart';
import '../../domain/model/my_user/my_user.dart';
import '../data_source/auth_local_data_source.dart';
import '../data_source/auth_remote_data_source.dart';



class AuthanticationReposatoryImpl extends AuthanticationReposatory{
  final NetworkConnectionInfo networkConnectionInfo;
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;
  AuthanticationReposatoryImpl({required this.networkConnectionInfo,required this.authRemoteDataSource,required this.authLocalDataSource});
  
  @override
  Future<Either<Failure, MyUser>> authanticate(ApiRequestModel apiRequestModel) async{
    if(await networkConnectionInfo.isConnected){
      try{
        MyUser myUser= await authRemoteDataSource.getRequest(apiRequestModel);
        await  authLocalDataSource.setUser(myUser);
        return Right(myUser);
      }on ServerException catch(ex){
        return Left(ServerFailure(message: ex.message));
      }on SafetyLocalDataBaseException catch(ex){
        return Left(SafetyLocalDataBaseFailure(message: ex.message));
      }
    }else{
      return Left(OfflineFailure(message:FailureMessages.offline));
    }
  }
  
  @override
  Either<MyUser,bool>startApplication(){
    try{
      return Left(authLocalDataSource.getUser());
    }catch(ex){
      return Right(authLocalDataSource.getUserPassOnBoarding());
    }
  }
}