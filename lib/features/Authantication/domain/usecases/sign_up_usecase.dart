import 'dart:math';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Authantication/domain/reposatory/auth_reposatory.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/api/api_constants.dart';
import '../../../../core/network/api/api_request_model.dart';
import '../model/my_user/my_user.dart';


class SignUpUsecase extends Equatable{
  
  final AuthanticationReposatory authanticationReposatory;
  const SignUpUsecase({required this.authanticationReposatory});

  Future<Either<Failure,MyUser>> excute({
    required String email , 
    required String password,
    required String name,
    })async{
    return await authanticationReposatory.authanticate(
      ApiRequestModel(
        endPoint: ApiK.signUpEndPoint,
        body: {
          ApiK.name:name,
          ApiK.email:email,
          ApiK.password:password,
          ApiK.image:null,
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

  List<Object?> get props =>[authanticationReposatory];
}
