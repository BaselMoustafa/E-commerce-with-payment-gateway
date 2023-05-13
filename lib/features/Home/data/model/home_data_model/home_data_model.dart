import 'package:e_commerce_app_with_payment_gateway/core/network/api/api_constants.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/data/model/product_model/product_model.dart';
import 'package:equatable/equatable.dart';

class HomeDataModel extends Equatable{

  final List<ProductModel>products;
  final List<String>banners;
  const HomeDataModel({required this.banners,required this.products});

  factory HomeDataModel.fromMap(Map<String,dynamic>map){
    List<String>modeledBanners=[];
    List<ProductModel>modeledProducts=[];
    for (var i = 0; i < map[ApiK.banners].length; i++) {
      modeledBanners.add(map[ApiK.banners][i][ApiK.image]);
    }
    for (var i = 0; i < map[ApiK.productsssss].length; i++) {
      modeledProducts.add(ProductModel.fromMap(map[ApiK.productsssss][i]));
    }

    return HomeDataModel(
      banners: modeledBanners, 
      products: modeledProducts,
      );
  }
  @override
  List<Object?> get props => [products,banners];
}