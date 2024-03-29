import 'dart:io';

import 'package:be_chill/src/domain/entities/user_model.dart';
import 'package:be_chill/src/utils/resources/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseAuthProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _uid;
  String get uid => _uid!;

  String? get phone => _firebaseAuth.currentUser?.phoneNumber;

  void _startLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void _stopLoading() {
    _isLoading = false;
    notifyListeners();
  }

  FirebaseAuthProvider() {
    checkSignIn();
  }

  void checkSignIn() async {
    _startLoading();
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("is_signed_in") ?? false;
    _stopLoading();
  }

  void _onVerificationCompleted(PhoneAuthCredential credential) async {
    _stopLoading();

    print('VERIFICATION COMPLETED');
    await _firebaseAuth.signInWithCredential(credential);
  }

  void _onVerificationFailed(FirebaseAuthException authException) async {
    _stopLoading();

    print('VERIFICATION FAILED');
    print(authException.message);
  }

  void _onCodeSent(String verificationId, Function(String) codeSentCallback) {
    _stopLoading();

    codeSentCallback(verificationId);
  }

  void _onCodeAutoRetrievalTimeout(_) {
    _stopLoading();

    print('CODE AUTO RETRIEVAL TIMEOUT');
  }

  void signInWithPhone({
    required BuildContext context,
    required String countryCode,
    required String phoneNumber,
    required Function(String) codeSentCallback,
  }) async {
    _startLoading();

    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: '$countryCode $phoneNumber',
      verificationCompleted: _onVerificationCompleted,
      verificationFailed: _onVerificationFailed,
      codeSent: (String vid, _) => _onCodeSent(vid, codeSentCallback),
      codeAutoRetrievalTimeout: _onCodeAutoRetrievalTimeout,
    );
  }

  void verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
    required VoidCallback onSuccess,
  }) async {
    _startLoading();

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: userOtp,
    );

    try {
      User? user = (await _firebaseAuth.signInWithCredential(credential)).user;

      if (user != null) {
        print("USER $user");
        _uid = user.uid;
        onSuccess();
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      showSnackBar(context: context, content: 'Codice OTP errato!');
    } finally {
      _stopLoading();
    }
  }

  // DATABASE OPERATIONS
  Future<bool> checkExistingUser() async {
    DocumentSnapshot snapshot =
        await _firebaseFirestore.collection('users').doc(_uid).get();

    print('Snapshot: ${snapshot.data().toString()}');

    return snapshot.exists;
  }

  void saveUserDataToFirebase({
    required BuildContext context,
    required UserModel user,
    required File? profilePic,
    required Function(UserModel) onSuccess,
  }) async {
    _isLoading = true;
    notifyListeners();

    user.setUid = uid;

    try {
      // uploading image to firebase storage
      if (profilePic != null) {
        await storeFileToStorage('profilePic/$_uid', profilePic).then((value) {
          user.profilePicUrl = value;
        });
      }

      // uploading to database
      await _firebaseFirestore
          .collection('users')
          .doc(_uid)
          .set(user.toMap())
          .then((_) => onSuccess(user));
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        showSnackBar(
          context: context,
          content: "Registrazione non riuscita: ${e.message}",
        );
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String> storeFileToStorage(String ref, File file) async {
    UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }
}
