import 'dart:async';
import 'dart:math';

import 'package:be_chill/src/presentation/providers/repository_provider.dart';
import 'package:be_chill/src/presentation/shared/bechill_painter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  Stopwatch? _stopwatch;
  NavigatorState? _navigatorState;
  double _time = 0.0;

  String? _routeName;

  void _updateLogo() {
    setState(() {
      _time = min(1, _stopwatch!.elapsedMilliseconds / 2500.0);
    });
  }

  @override
  void initState() {
    const timeOffset = Duration(milliseconds: 100);
    const interval = Duration(milliseconds: 1);

    Future.delayed(timeOffset, () {
      _stopwatch = Stopwatch()..start();
      _timer = Timer.periodic(interval, (timer) {
        _updateLogo();

        if (_time == 1) {
          if (_routeName != null && _navigatorState != null) {
            _timer!.cancel();
            _navigatorState!.pushReplacementNamed(_routeName!);
          } else {
            _stopwatch!.reset();
          }
        }
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _stopwatch?.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // FirebaseAuthProvider authProvider =
    //     Provider.of<FirebaseAuthProvider>(context);

    RepositoryProvider repoProvider = Provider.of<RepositoryProvider>(context);

    _routeName = repoProvider.userRepository.isSignedIn() ? '/home' : '/login';

    _navigatorState = Navigator.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: CustomPaint(
        painter: BeChillPainter(
          rating: _time,
          center: Offset(
            MediaQuery.of(context).size.width / 2,
            MediaQuery.of(context).size.height / 2,
          ),
          fixedSize: const Size.fromRadius(50.0),
        ),
      ),
    );
  }
}
