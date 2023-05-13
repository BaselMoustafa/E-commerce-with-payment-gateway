
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/card_cubit/card_cubit.dart';

abstract class CartCubitStates{}

class CartCubitInitialState extends CartCubitStates{}
class CartCubitSuccessState extends CartCubitStates{}
class CartCubitFailedState extends CartCubitStates{}
class CartCubitInterActiveState extends CartCubitStates{
  List<CartProduct>cardProducts=[];
  double totalPric;
  CartCubitInterActiveState({required this.cardProducts,required this.totalPric});
}