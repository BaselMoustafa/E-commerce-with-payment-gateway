import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_with_payment_gateway/core/error/failures.dart';
import 'package:e_commerce_app_with_payment_gateway/core/network/api/api_constants.dart';
import 'package:e_commerce_app_with_payment_gateway/core/network/api/api_request_model.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/domain/home_repo/home_repo.dart';
import 'package:equatable/equatable.dart';

class SignOutUseCase extends Equatable{
  final HomeRepo homeRepo;
  const SignOutUseCase({required this.homeRepo});
  Future<Either<Failure,Unit>>excute(String token)async{
    return await homeRepo.signOut(
      ApiRequestModel(
        endPoint: ApiK.signOutEndPoint,
        headers: {
          ApiK.authorization:token,
        }
      ),
    );
  }

  @override
  List<Object?> get props => [homeRepo];

}