import 'package:hive/hive.dart';
import 'package:mocketest_hive/model%20hive/models.dart';

class Dbfunction
{
  Dbfunction.internal();
  static Dbfunction instance = Dbfunction.internal();
  factory Dbfunction()
  {
    return instance;
  }
  Future<void> usersignin (usersign users)
  async {
    final db= await Hive.openBox<usersign>("users");
    db.put(users.id,users);
  }
  Future<List<usersign>>gettinguser()
  async {
    final db=await Hive.openBox<usersign>("users");
    return db.values.toList();
  }
}
