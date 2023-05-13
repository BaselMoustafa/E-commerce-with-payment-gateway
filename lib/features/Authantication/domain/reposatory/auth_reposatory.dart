import 'package:dartz/dartz.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure_messages.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/api/api_request_model.dart';
import '../../../../core/network/api/network_connection_info.dart';
import '../../domain/model/my_user/my_user.dart';
import 'package:equatable/equatable.dart';


abstract class AuthanticationReposatory extends Equatable{
  Future<Either<Failure,MyUser>>authanticate(ApiRequestModel apiRequestModel);
  Either<MyUser,bool>startApplication();
  @override
  List<Object?> get props => [];
}