import 'dart:ffi';

import 'package:e_commerce_app_with_payment_gateway/core/network/api/api_constants.dart';
import 'package:equatable/equatable.dart';

class ProductModel extends Equatable{
  final int id;
  final double price;
  final double oldPrice;
  final double discount;
  final String name;
  final String description;
  final String image;
  final List<String>images;
  bool inFav;

  ProductModel({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.name,
    required this.description,
    required this.image,
    required this.images,
    required this.inFav,
  });

  factory ProductModel.copy(ProductModel productModel){
    return ProductModel(
      id: productModel.id, 
      price: productModel.price, 
      oldPrice: productModel.oldPrice, 
      discount: productModel.discount, 
      name: productModel.name, 
      description: productModel.description, 
      image: productModel.image, 
      images: productModel.images, 
      inFav: productModel.inFav,
      );
  }

  factory ProductModel.fromMap(Map<String,dynamic>map,{bool favoriteProduct=false,bool searchProduct=false}){
    List<String> mappedImages=[];
    if(! favoriteProduct){
      for (var i = 0; i < map[ApiK.imagessssss].length; i++) {
        mappedImages.add(map[ApiK.imagessssss][i] as String);
      }
    }
    return ProductModel(
      id: int.parse(map[ApiK.id].toString()), 
      price: double.parse("${map[ApiK.price]}"), 
      oldPrice:searchProduct? double.parse("${map[ApiK.price]}"):double.parse("${map[ApiK.oldPrice]}"), 
      discount:searchProduct? 0:double.parse("${map[ApiK.discount]}"), 
      name: map[ApiK.name], 
      description: map[ApiK.description], 
      image: map[ApiK.image], 
      images: mappedImages, 
      inFav: favoriteProduct? true:map[ApiK.inFav],
    ); 
  }
  
  @override
  List<Object?> get props => [
    id,
    price,
    oldPrice,
    discount,
    name,
    description,
    image,
    images,
    inFav,
  ];
}