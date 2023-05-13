import 'package:dartz/dartz.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Authantication/domain/model/my_user/my_user.dart';
import 'package:hive/hive.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failure_messages.dart';
import '../../../../core/network/hive/hive_constants.dart';

abstract class AuthLocalDataSource{
  Future<Unit>setUser(MyUser myUser);
  MyUser getUser();
  bool getUserPassOnBoarding();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource{

  Box userBox=Hive.box<MyUser>(HiveK.myUserBoxName);
  Box userPassOnBoardingBox=Hive.box<bool>(HiveK.userPassOnBoardingBoxName);
  @override
  Future<Unit>setUser(MyUser myUser)async{
    try{
      userBox.put(
        HiveK.myUserInfoKey, 
        myUser,
      );
      return unit;
    }catch(ex){
      throw SafetyLocalDataBaseException(message: FailureMessages.localDataBaseFailure);
    }
  }

  @override
  MyUser getUser(){
    try{
      MyUser? myUser= userBox.get(HiveK.myUserInfoKey,);
      if(myUser!=null){return myUser;}
      throw NoUserException();
    }catch(ex){
      throw SafetyLocalDataBaseException(message: FailureMessages.localDataBaseFailure);
    }
  }
  
  @override
  bool getUserPassOnBoarding() {
    try{
      bool? userPassOnBoarding= userPassOnBoardingBox.get(HiveK.userPassOnBoardingStatus);
      if(userPassOnBoarding==null){
        userPassOnBoardingBox.put(HiveK.userPassOnBoardingStatus, true);
        return false;
      }
      return true;
    }catch(ex){
      throw SafetyLocalDataBaseException(message: FailureMessages.localDataBaseFailure);
    }
  }


}