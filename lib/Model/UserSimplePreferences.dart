import 'package:shared_preferences/shared_preferences.dart';
List<String> timer_Pray =["00:00","00:00","00:00","00:00","00:00","00:00"]; //["05:06", "06:30", "12:09", "15:30", "17:46", "19:04"];
class UserSimplePreferences {
  static SharedPreferences _preferences;

  static const Fajr = 'Fajr';
  static const Shrouk = 'shrouk';
  static const duhr = 'duhr';
  static const Asr = 'Asr';
  static const Magrib = 'magrib';
  static const Asha = 'Asha';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setFajr(String fajr) async =>
      await _preferences.setString(Fajr, fajr);

  static String getFajr() => _preferences.getString(Fajr);


  static Future setshrouk(String shrouk) async =>
      await _preferences.setString(Shrouk, shrouk);

  static String getshrouk() => _preferences.getString(Shrouk);


  static Future setduher(String duher) async =>
      await _preferences.setString(duhr, duher);

  static String getduher() => _preferences.getString(duhr);


  static Future setAsr(String Asr1) async =>
      await _preferences.setString(Asr, Asr1);

  static String getAsr() => _preferences.getString(Asr);

  static Future setmagrib(String magrib) async =>
      await _preferences.setString(Magrib, magrib);

  static String getmagrib() => _preferences.getString(Magrib);

  static Future setAsha(String asha) async =>
        await _preferences.setString(Asha, asha);

  static String getmAsha() => _preferences.getString(Asha);
}