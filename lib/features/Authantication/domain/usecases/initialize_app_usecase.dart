import 'package:dartz/dartz.dart';
import '../../domain/model/my_user/my_user.dart';
import 'package:equatable/equatable.dart';

import '../reposatory/auth_reposatory.dart';

class InitializeAppUseCase extends Equatable{
  final AuthanticationReposatory authanticationReposatory;
  const InitializeAppUseCase({required this.authanticationReposatory});

  Either<MyUser,bool>excute(){
    return authanticationReposatory.startApplication();
  }

  @override
  List<Object?> get props => [authanticationReposatory];
}