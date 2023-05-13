import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Authantication/domain/reposatory/auth_reposatory.dart';

import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/api/api_constants.dart';
import '../../../../core/network/api/api_request_model.dart';
import '../model/my_user/my_user.dart';

class SignInUsecase extends Equatable{

  final AuthanticationReposatory authanticationReposatory;
  const SignInUsecase({required this.authanticationReposatory});

  Future<Either<Failure,MyUser>> excute({required String email , required String password})async{
    return await authanticationReposatory.authanticate(
      ApiRequestModel(
        endPoint: ApiK.signInEndPoint,
        body: {
          ApiK.email:email,
          ApiK.password:password,
        },
      ),
    );
  }

  @override
  List<Object?> get props => [authanticationReposatory];

}