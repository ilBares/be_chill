import 'dart:io';

import 'package:be_chill/src/domain/entities/user_model.dart';
import 'package:be_chill/src/presentation/providers/firebase_auth_provider.dart';
import 'package:be_chill/src/presentation/providers/repository_provider.dart';
import 'package:be_chill/src/presentation/views/ask_bio_screen.dart';
import 'package:be_chill/src/presentation/views/ask_birthday_screen.dart';
import 'package:be_chill/src/presentation/views/ask_name_screen.dart';
import 'package:be_chill/src/presentation/views/upload_profile_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserInformationScreen extends StatefulWidget {
  const UserInformationScreen({super.key});

  @override
  State<UserInformationScreen> createState() => _UserInformationScreenState();
}

class _UserInformationScreenState extends State<UserInformationScreen> {
  final _controller = PageController();

  late String name;
  late String bio;
  late String birthday;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onAskNameContinue(String name) {
    this.name = name;
    nextPage();
  }

  void onAskBioContinue(String bio) {
    this.bio = bio;
    nextPage();
  }

  void onAskBirthdayContinue(String birthday) {
    this.birthday = birthday;
    nextPage();
  }

  void nextPage() {
    _controller.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void uploadUser(
    File? imageFile,
    FirebaseAuthProvider authProvider,
    RepositoryProvider repositoryProvider,
  ) async {
    DateTime bday = DateTime(
      int.parse(birthday.split(' ')[2]),
      int.parse(birthday.split(' ')[1]),
      int.parse(birthday.split(' ')[0]),
    );

    UserModel user = UserModel(
      createdAt: DateTime.now(),
      phoneNumber: authProvider.phone!,
      username: name,
      birthday: bday,
      bio: bio,
    );
    repositoryProvider.userRepository.saveUser(user);

    authProvider.saveUserDataToFirebase(
      context: context,
      user: user,
      profilePic: imageFile,
      onSuccess: (UserModel updatedUser) {
        repositoryProvider.userRepository.saveUser(updatedUser);

        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (route) => false);
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuthProvider authProvider =
        Provider.of<FirebaseAuthProvider>(context, listen: true);

    RepositoryProvider repoProvider = Provider.of<RepositoryProvider>(context);

    return authProvider.isLoading
        ? CircularProgressIndicator(
            color: Theme.of(context).colorScheme.tertiary,
          )
        : PageView(
            controller: _controller,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: [
              AskNameScreen(onContinue: onAskNameContinue),
              AskBioScreen(onContinue: onAskBioContinue),
              AskBirthdayScreen(onContinue: onAskBirthdayContinue),
              UploadProfileImageScreen(
                onConfirm: (imageFile) => uploadUser(
                  imageFile,
                  authProvider,
                  repoProvider,
                ),
              ),
            ],
          );
  }
}
