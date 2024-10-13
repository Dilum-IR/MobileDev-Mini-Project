import 'package:shared_preferences/shared_preferences.dart';

class SharedAuthUser {
  static late final SharedPreferences prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static void saveAuthUser(value) {
    prefs.setStringList('user', value);
  }
  static dynamic getAuthUser() {
    return prefs.get("user");
  }
  static dynamic removeUser() {
    return prefs.remove("user");
  }

  static void saveAuthInfoUser(value) => prefs.setStringList('aboutme', value);
  static dynamic getAuthInfoUser() => prefs.get("aboutme");
  static dynamic removeInfoUser() {
    return prefs.remove("aboutme");
  }

  static void saveOtherInfoUser(value) => prefs.setStringList('addmore', value);
  static dynamic getOtherInfoUser() => prefs.get("addmore");
  static dynamic removeOtherInfoUser() {
    return prefs.remove("addmore");
  }

  static void saveimageUrl(value) => prefs.setString('image', value);
  static dynamic getimageUrl() => prefs.getString("image");
  static dynamic removeimageUrl() => prefs.remove("image");

  static void saveOnBoard(bool value) => prefs.setBool('onboard', value);
  static dynamic getOnBoard() => prefs.getBool("onboard");
  static dynamic removeOnBoard() => prefs.remove("onboard");

  static void saveOnMoreData(bool value) => prefs.setBool('onMoreData', value);
  static dynamic getOnMoreData() => prefs.getBool("onMoreData");
  static dynamic removeOnMoreData() => prefs.remove("onMoreData");

}
