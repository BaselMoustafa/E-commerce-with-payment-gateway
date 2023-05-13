import 'package:e_commerce_app_with_payment_gateway/features/Home/data/model/product_model/product_model.dart';
import 'package:hive/hive.dart';

import 'home_data_model.dart';

class HomeDataModelAdabter extends TypeAdapter<HomeDataModel> {
  @override
  final typeId = 2;

  @override
  HomeDataModel read(BinaryReader reader) {
    final banners = reader.readStringList();
    final products = reader.readList();
    return HomeDataModel(
      banners: banners,
      products:products.cast<ProductModel>(),
    );
    
  }

  @override
  void write(BinaryWriter writer, HomeDataModel obj) {
    writer.writeStringList(obj.banners);
    writer.writeList(obj.products);
    
  }
}