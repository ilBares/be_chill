import 'package:be_chill/src/data/datasources/local/local_storage.dart';
import 'package:be_chill/src/data/datasources/remote/api_service.dart';
import 'package:be_chill/src/data/repositories/user_repository_impl.dart';
import 'package:be_chill/src/domain/repositories/user_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RepositoryProvider extends ChangeNotifier {
  RepositoryProvider(this._sharedPref) {
    final ApiService apiService = ApiServiceImpl();
    final LocalStorage localStorage = LocalStorageImpl(
      sharedPreferences: _sharedPref,
    );

    _userRepository = UserRepositoryImpl(
      localStorage: localStorage,
      api: apiService,
    );
  }

  final SharedPreferences _sharedPref;
  late UserRepository _userRepository;

  UserRepository get userRepository => _userRepository;
}
