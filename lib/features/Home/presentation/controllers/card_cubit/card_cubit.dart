import 'package:e_commerce_app_with_payment_gateway/core/payment_gateway/stripe_gateway.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/data/model/product_model/product_model.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/card_cubit/card_cubit_states.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/presentation/controllers/get_home_data_cubit/get_home_data_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartCubitStates>{
  CartCubit():super(CartCubitInitialState());
  static CartCubit get(context)=> BlocProvider.of(context);
  List<CartProduct>_cartProducts=[];
  double _totalPrice=0;

  bool thisProductIsAtCart(int id){
    for (var i = 0; i < _cartProducts.length; i++) {
      if(_cartProducts[i].productModel.id==id){
        return true;
      }
    } 
    return false;
  }

  void increaseCount(int index){
    _totalPrice+=_cartProducts[index].productModel.price;
    _cartProducts[index].count=_cartProducts[index].count+1;
    emit(CartCubitInterActiveState(cardProducts: _cartProducts,totalPric: _totalPrice));
  }

  void decreaseCount(int index){
    if(_cartProducts[index].count!=0){
      _totalPrice-=_cartProducts[index].productModel.price;
      _cartProducts[index].count=_cartProducts[index].count-1;
      emit(CartCubitInterActiveState(cardProducts: _cartProducts,totalPric: _totalPrice));
    }
  }

  void addOrRemoveToCart(ProductModel productModel,BuildContext context){
    int index =_cartProducts.indexWhere((element) => element.productModel.id==productModel.id);
    if(index==-1){
      _addToCart(productModel);
    }else{
      _removeFromCart(index);
    }
  }

  void _addToCart(ProductModel productModel){
    _cartProducts.add(CartProduct(count: 1, productModel: productModel));
    _totalPrice+=productModel.price;
    emit(CartCubitInterActiveState(cardProducts: _cartProducts,totalPric: _totalPrice));
  }
  
  void _removeFromCart(int index){
    _totalPrice-=(_cartProducts[index].count)*(_cartProducts[index].productModel.price);
    _cartProducts.removeAt(index);
    emit(CartCubitInterActiveState(cardProducts: _cartProducts,totalPric: _totalPrice));
  }

  Future<void>checkOut(String totalPrice,BuildContext context)async{
    try{
      await FlutterStripePayment.makePayment(totalPrice,"EGP", context).then((value){
        _cartProducts=[];
      _totalPrice=0;
      emit(CartCubitInterActiveState(cardProducts: _cartProducts,totalPric: _totalPrice));
      });
      
    }catch(ex){
      emit(CartCubitInterActiveState(cardProducts: _cartProducts, totalPric: _totalPrice));
    }
  }

}

class CartProduct extends Equatable{
  ProductModel productModel;
  int count;
  CartProduct({required this.count,required this.productModel});
  @override
  List<Object?> get props => [productModel,count];
}

 
  
  
  

