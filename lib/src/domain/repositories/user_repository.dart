import '../entities/user_model.dart';

abstract class UserRepository {
  bool isSignedIn();
  Future<UserModel> getUser();
  Future<void> saveUser(UserModel user);
  Future<void> updateUser(UserModel user);
  Future<void> removeUser();
}
