import 'package:be_chill/src/presentation/providers/repository_provider.dart';
import 'package:be_chill/src/presentation/providers/user_provider.dart';
import 'package:be_chill/src/config/themes/bechill_theme.dart';
import 'package:be_chill/src/config/routes/routes.dart';
import 'package:be_chill/src/config/firebase/firebase_options.dart';
import 'package:be_chill/src/presentation/providers/firebase_auth_provider.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  sharedPref = await SharedPreferences.getInstance();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const BeChillApp());
}

class BeChillApp extends StatelessWidget {
  const BeChillApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = FirebaseAuthProvider();
    final userProvider = UserProvider();
    final repositoryProvider = RepositoryProvider(sharedPref);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => authProvider),
        ChangeNotifierProvider(create: (_) => userProvider),
        ChangeNotifierProvider(create: (_) => repositoryProvider),
      ],
      child: MaterialApp(
        initialRoute: bechillInitialRoute,
        routes: bechillRoutes,
        onGenerateRoute: (settings) {
          return CupertinoPageRoute(
            settings: settings,
            maintainState: false,
            builder: (context) => bechillRoutes[settings.name]!(context),
          );
        },
        debugShowCheckedModeBanner: false,
        supportedLocales: const [
          Locale('en'),
          Locale('it'),
        ],
        localizationsDelegates: const [
          CountryLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        theme: BeChillTheme.lightTheme,
      ),
    );
  }
}
