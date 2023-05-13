import 'package:e_commerce_app_with_payment_gateway/core/network/api/api_constants.dart';
import 'package:e_commerce_app_with_payment_gateway/l10n/l10n.dart';
import 'package:equatable/equatable.dart';

class ApiRequestModel extends Equatable{
  final String endPoint;
  Map<String,dynamic>? headers;
  final Map<String,dynamic>? body;
  final Map<String,dynamic>? queries;

   ApiRequestModel({
    required this.endPoint,
    this.headers,
    this.body,
    this.queries,
  }){
    if(headers==null){
      headers={
        ApiK.contentType:ApiK.applicationOverJson,
        ApiK.lang:L10n.getLanguageCode(),
      };
    }else{
      headers![ApiK.contentType]=ApiK.applicationOverJson;
      headers![ApiK.lang]=L10n.getLanguageCode();
    }
    return ;
  }

  @override
  List<Object?> get props => [endPoint,headers,body,queries];
}