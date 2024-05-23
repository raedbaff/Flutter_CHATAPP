import 'package:shared_preferences/shared_preferences.dart';
class helperfunction {
  static String sharedPreferenceUser = "ISLOGGEDIN";
  static String sharedPreferenceUserNameKey = "USERNAMEKEY";
  static String sharedPreferenceUserEMailKey = "USEREMAILKEY";

  static Future <bool> saveuserloggedInsharedPreference(
      bool isUserLoggedIn) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.setBool(sharedPreferenceUser, isUserLoggedIn);
  }

  static Future <bool> saveusernamesharedpreference(String username) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.setString(sharedPreferenceUserNameKey, username);
  }

  static Future<bool> saveuseremail(String userEmail) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.setString(sharedPreferenceUserEMailKey, userEmail);
  }

  static Future<bool?> getuserloggedin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.getBool(sharedPreferenceUser);
  }

  static Future<String?> getusernamekey() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print("inside getusernamekey ${sharedPreferenceUserNameKey}");
    return await pref.getString(sharedPreferenceUserNameKey);
  }

  static Future<String?> getuseremailkey() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.getString(sharedPreferenceUserEMailKey);
  }
}