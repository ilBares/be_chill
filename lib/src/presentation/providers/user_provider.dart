import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  String? _name;
  String? get name => _name;

  String? _bio;
  String? get bio => _bio;

  DateTime? _birthday;
  DateTime? get birthday => _birthday;

  String? _profileImageUrl;
  String? get profileImageUrl => _profileImageUrl;

  String? _phoneNumber;
  String? get phoneNumber => _phoneNumber;

  String? _verificationId;
  String? get verificationId => _verificationId;

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setBio(String bio) {
    _name = name;
    notifyListeners();
  }

  void setBirthday(DateTime birthday) {
    _birthday = birthday;
    notifyListeners();
  }

  void setProfileImageUrl(String profileImageUrl) {
    _profileImageUrl = profileImageUrl;
    notifyListeners();
  }

  void setPhoneNumber(String phoneNumber) {
    _phoneNumber = phoneNumber;
    notifyListeners();
  }

  void setVerificationId(String verificationId) {
    _verificationId = verificationId;
    notifyListeners();
  }
}
