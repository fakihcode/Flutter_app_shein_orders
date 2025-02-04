import 'package:hive_flutter/hive_flutter.dart';

class Userdata {
  Userdata() {
    initHive();
  }

  Future<void> initHive() async {
    await Hive.initFlutter();
    await Hive.openBox('user_data');
  }

  Future<void> ensureListExists(int personId) async {
    var box = Hive.box("user_data");
    if (!box.containsKey(personId.toString())) {
      await box.put(personId.toString(), []); // Initialize with an empty list
    }
  }

  Future<void> ClearBoxList(int personId) async {
    var box = Hive.box("user_data");
    await box.delete(personId.toString());
  }

  List<String> GetFile(int personId) {
    var box = Hive.box("user_data");
    List<String>? filePaths = box.get(personId.toString());
    return filePaths ?? []; // Return an empty list if no paths exist
  }

  Future<void> ClearBoxEmail() async {
    var box = Hive.box("user_data");
    await box.delete("email");
    await box.delete("password");
    print("Data Deleted successfully for new insertion");
  }

  Future<void> SetEmail(String email) async {
    var box = Hive.box("user_data");
    await box.put('email', email);
  }

  String GetEmail() {
    var box = Hive.box("user_data");
    return box.get('email', defaultValue: '');
  }

  Future<void> SetPassword(String password) async {
    var box = Hive.box("user_data");
    await box.put('password', password);
  }

  String GetPassword() {
    var box = Hive.box('user_data');
    return box.get("password", defaultValue: '');
  }

  Future<void> SetId(int userId) async {
    var box = Hive.box('user_data');
    await box.put('user_id', userId);
  }

  int GetId() {
    var box = Hive.box("user_data");
    return box.get("user_id", defaultValue: 0);
  }

  Future<void> SetaList(int personId, List<String> list) async {
    var box = Hive.box("user_data");
    await box.put(personId.toString(), list);
  }
}
