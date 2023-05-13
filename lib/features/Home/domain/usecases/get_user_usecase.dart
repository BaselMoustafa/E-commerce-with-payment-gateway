import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_with_payment_gateway/core/error/failures.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Authantication/domain/model/my_user/my_user.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/domain/home_repo/home_repo.dart';
import 'package:equatable/equatable.dart';

class GetUserUseCase extends Equatable{
  final HomeRepo homeRepo;
  const GetUserUseCase({required this.homeRepo});

  Either<Failure,MyUser>excute(){
    return homeRepo.getUser();
  }
  @override
  List<Object?> get props => [homeRepo];
}