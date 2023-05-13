import 'package:e_commerce_app_with_payment_gateway/features/Authantication/domain/model/my_user/my_user.dart';
import 'package:e_commerce_app_with_payment_gateway/features/Home/data/model/product_model/product_model.dart';
import 'package:hive/hive.dart';

class ProductModelAdabter extends TypeAdapter<ProductModel> {
  @override
  final typeId = 1;

  @override
  ProductModel read(BinaryReader reader) {
    final id = reader.readInt();
    final price = reader.readDouble();
    final oldPrice = reader.readDouble();
    final discount = reader.readDouble();
    final name = reader.readString();
    final description = reader.readString();
    final image = reader.readString();
    final images = reader.readStringList();
    final inFav = reader.readBool();
    return ProductModel(id: id, price: price, oldPrice: oldPrice, discount: discount, name: name, description: description, image: image, images: images, inFav: inFav);
    
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer.writeInt(obj.id);
    writer.writeDouble(obj.price);
    writer.writeDouble(obj.oldPrice);
    writer.writeDouble(obj.discount);
    writer.writeString(obj.name);
    writer.writeString(obj.description);
    writer.writeString(obj.image);
    writer.writeStringList(obj.images);
    writer.writeBool(obj.inFav);
  }
}