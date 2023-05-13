import 'package:equatable/equatable.dart';

import '../../../../../core/network/api/api_constants.dart';


class MyUser extends Equatable{
  final int id;
  final String name;
  final String email;
  final String? image;
  final String token;
  const MyUser({required this.id, required this.name,required this.email,this.image=null,required this.token,});



  factory MyUser.fromMap(Map map){ 
    return MyUser(
      id: map[ApiK.id], 
      name: map[ApiK.name], 
      email: map[ApiK.email],
      image: map[ApiK.image],
      token: map[ApiK.token],  
      );
  } 

  Map<String,dynamic>toMap(){  
    return {
      ApiK.id:id,
      ApiK.name:name,
      ApiK.email:email,
      ApiK.image:image,
      ApiK.token:token,
    };
  }

  @override
  List<Object?> get props => [id ,name,email,image,token];
}