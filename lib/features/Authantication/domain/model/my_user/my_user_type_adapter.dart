import 'package:hive/hive.dart';

import 'my_user.dart';

class MyUserAdabter extends TypeAdapter<MyUser> {
  @override
  final typeId = 0;

  @override
  MyUser read(BinaryReader reader) {
    final id = reader.readInt();
    final name = reader.readString();
    final email = reader.readString();
    final image = reader.read();
    final token = reader.readString();
    return MyUser(id: id, name: name, email: email, image: image, token: token);
    
  }

  @override
  void write(BinaryWriter writer, MyUser obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.name);
    writer.writeString(obj.email);
    writer.write(obj.image);
    writer.writeString(obj.token);
  }
}