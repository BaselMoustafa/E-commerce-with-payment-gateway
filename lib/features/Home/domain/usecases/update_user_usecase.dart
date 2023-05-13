import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_with_payment_gateway/core/error/failures.dart';
import 'package:e_commerce_app_with_payment_gateway/core/network/api/api_constants.dart';
import 'package:e_commerce_app_with_payment_gateway/core/network/api/api_request_model.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/domain/home_repo/home_repo.dart';
import 'package:equatable/equatable.dart';

class UpdateUserUseCase extends Equatable{
  final HomeRepo homeRepo;
  const UpdateUserUseCase({required this.homeRepo});

  Future<Either<Failure,Unit>>excute(String token,String name,String email)async{
    return await homeRepo.updateUser(
      ApiRequestModel(
        endPoint: ApiK.updateProfileEndPoint,
        headers: {
          ApiK.authorization:token,
        },
        body: {
          ApiK.name:name,
          ApiK.email:email,
          ApiK.phone:dummyPhoneNumber(),
        },
      ),
    );
  }

  String dummyPhoneNumber(){
    String toReturn="";
    for (var i = 0; i < 8; i++) {
      toReturn+="${Random().nextInt(10)}";
    }
    return toReturn;
  }

  @override
  List<Object?> get props => [homeRepo];
}