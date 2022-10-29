part of api;

class Pref {
  Pref._internal();
  static final Pref _getInstance = Pref._internal();
  static SharedPreferences? _preferences;
  Future<void> init() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  static void dispose() {
    // _prefs = null;
    // _preferences = null;
  }

  static Future<bool> getBoolF(String key) async {
    bool value;
    await Pref._getInstance.init();
    value = _preferences!.getBool(key) ?? false;
    return value;
  }

  static Future<int?> getIntF(String key) async {
    int? value;
    await Pref._getInstance.init();
    value = _preferences!.getInt(key);
    return value;
  }

  static Future<double?> getDoubleF(String key) async {
    double? value;
    await Pref._getInstance.init();
    value = _preferences!.getDouble(key);
    return value;
  }

  static Future<String?> getStringF(String key) async {
    String? value;
    await Pref._getInstance.init();
    value = _preferences!.getString(key);
    return value;
  }

  static Future<List<String>?> getStringListF(String key) async {
    List<String>? value;
    await Pref._getInstance.init();
    value = _preferences!.getStringList(key);
    return value;
  }

  static Future<bool> setBool(String key, bool value) async {
    await Pref._getInstance.init();
    return _preferences!.setBool(key, value);
  }

  static Future<bool> setInt(String key, int value) async {
    await Pref._getInstance.init();
    return _preferences!.setInt(key, value);
  }

  static Future<bool> setDouble(String key, double value) async {
    await Pref._getInstance.init();
    return _preferences!.setDouble(key, value);
  }

  static Future<bool> setString(String key, String value) async {
    await Pref._getInstance.init();
    return _preferences!.setString(key, value);
  }

  static Future<bool> setStringList(String key, List<String> value) async {
    await Pref._getInstance.init();
    return _preferences!.setStringList(key, value);
  }

  static Future<bool> remove(String key) async {
    await Pref._getInstance.init();
    return _preferences!.remove(key);
  }

  static Future<bool> clear() async {
    await Pref._getInstance.init();
    return _preferences!.clear();
  }
}
