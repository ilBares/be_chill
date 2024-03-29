import 'package:be_chill/src/domain/entities/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const cachedUserKey = 'CACHED_USER';

abstract class LocalStorage {
  Future<bool> saveUser(UserModel user);
  Future<bool> removeStoredUser();
  UserModel? loadUser();
}

class LocalStorageImpl extends LocalStorage {
  final SharedPreferences _sharedPref;

  LocalStorageImpl({
    required SharedPreferences sharedPreferences,
  }) : _sharedPref = sharedPreferences;

  @override
  Future<bool> saveUser(UserModel user) {
    final key = getKeyToUser();
    final jsonUser = user.toJson();

    return _sharedPref.setString(key, jsonUser);
  }

  @override
  Future<bool> removeStoredUser() {
    final key = getKeyToUser();
    return _sharedPref.remove(key);
  }

  @override
  UserModel? loadUser() {
    final key = getKeyToUser();
    final json = _sharedPref.getString(key);

    return json != null ? UserModel.fromJson(json) : null;
  }

  static String getKeyToUser() {
    return cachedUserKey;
  }
}
