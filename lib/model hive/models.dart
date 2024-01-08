
import 'package:hive/hive.dart';
part 'models.g.dart';
@HiveType(typeId : 1)
class usersign
{
  @HiveField(0)
  late final String email;
  @HiveField(1)
  late final String password;
  @HiveField(2)
  String ? id;
  usersign({required this.password,required this.email})
  {
    id=DateTime.now().microsecondsSinceEpoch.toString();
  }

}