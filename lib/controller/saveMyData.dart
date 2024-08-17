import 'package:shared_preferences/shared_preferences.dart';

class SaveMyData {
  static const String newkey = "MEMEKEY";

  static Future<bool> saveData(int val) async {
    final inst = await SharedPreferences.getInstance();
    bool result = await inst.setInt(newkey, val);
    print("Data saved: $result with value $val");
    return result;
  }

  static Future<int?> fetchData() async {
    final inst = await SharedPreferences.getInstance();
    int? value = inst.getInt(newkey);
    print("Data fetched: $value");
    return value;
  }
}
