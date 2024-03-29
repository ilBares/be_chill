import 'package:be_chill/src/presentation/views/home_screen.dart';
import 'package:be_chill/src/presentation/views/login_screen.dart';
import 'package:be_chill/src/presentation/views/otp_screen.dart';
import 'package:be_chill/src/presentation/views/splash_screen.dart';
import 'package:be_chill/src/presentation/views/user_information_screen.dart';
import 'package:flutter/material.dart';

const String bechillInitialRoute = '/';

final Map<String, WidgetBuilder> bechillRoutes = {
  '/': (context) => const SplashScreen(),
  '/login': (context) => const LoginScreen(),
  '/otp': (context) => const OtpScreen(),
  '/user_information': (context) => const UserInformationScreen(),
  '/home': (context) => const HomeScreen(),
};
