import 'package:be_chill/src/data/datasources/remote/api_service.dart';
import 'package:be_chill/src/domain/entities/user_model.dart';
import 'package:be_chill/src/domain/repositories/user_repository.dart';

import '../datasources/local/local_storage.dart';

class UserRepositoryImpl implements UserRepository {
  final ApiService _api;
  final LocalStorage _localStorage;

  UserRepositoryImpl({
    required ApiService api,
    required LocalStorage localStorage,
  })  : _api = api,
        _localStorage = localStorage;

  @override
  bool isSignedIn() {
    return _localStorage.loadUser() != null;
  }

  @override
  Future<UserModel> getUser() async {
    final cachedUser = _localStorage.loadUser();

    if (cachedUser?.uid != null) {
      // TODO
      // final localVersion = cachedUser!.version;
      // final remoteVersion = await _api.getUserVersion(cachedUser.uid!);

      // if (localVersion == remoteVersion) {
      return _localStorage.loadUser()!;
      // }

      // final fetchedUser = await _api.getUser(cachedUser.uid!);
      // await _localStorage.saveUser(fetchedUser);
      // return fetchedUser;
    }

    throw Error();
  }

  @override
  Future<void> removeUser() async {
    final cachedUser = _localStorage.loadUser();

    await _api.removeUser(cachedUser!);
    _localStorage.removeStoredUser();
  }

  @override
  Future<void> saveUser(UserModel user) async {
    _localStorage.saveUser(user);
    await _api.saveUser(user);
  }

  @override
  Future<void> updateUser(UserModel user) async {
    _localStorage.saveUser(user);
    await _api.saveUser(user);
  }
}
