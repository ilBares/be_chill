import '../../../domain/entities/user_model.dart';

abstract class ApiService {
  Future<UserModel> getUser(String uid);
  Future<int> getUserVersion(String uid);
  Future<void> saveUser(UserModel user);
  Future<void> updateUser(UserModel user);
  Future<void> removeUser(UserModel user);
}

class ApiServiceImpl implements ApiService {
  @override
  Future<UserModel> getUser(String uid) {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<int> getUserVersion(String uid) {
    // TODO: implement getUserVersion
    throw UnimplementedError();
  }

  @override
  Future<void> removeUser(UserModel user) {
    // TODO: implement removeUser
    throw UnimplementedError();
  }

  @override
  Future<void> saveUser(UserModel user) {
    // TODO: implement saveUser
    throw UnimplementedError();
  }

  @override
  Future<void> updateUser(UserModel user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
