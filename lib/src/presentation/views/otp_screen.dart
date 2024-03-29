import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_chill/src/presentation/providers/firebase_auth_provider.dart';
import 'package:be_chill/src/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late String phoneNumber;
  late String verificationId;

  int _timeLeft = 45;
  Timer? _timer;

  bool get canResend => _timer != null ? !_timer!.isActive : true;

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft == 0) {
        timer.cancel();
        setState(() => _timeLeft = 45);
      } else {
        setState(() => _timeLeft--);
      }
    });
  }

  void _verifyOtp(BuildContext context, String otp) async {
    FirebaseAuthProvider authProvider = Provider.of<FirebaseAuthProvider>(
      context,
      listen: false,
    );

    authProvider.verifyOtp(
      context: context,
      verificationId: verificationId,
      userOtp: otp,
      onSuccess: () {
        authProvider.checkExistingUser().then((isExistingUser) async {
          if (isExistingUser) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/home',
              (_) => false,
            );
          } else {
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/user_information',
              (_) => false,
            );
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );

    phoneNumber = userProvider.phoneNumber ?? '';
    verificationId = userProvider.verificationId ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BeChill.',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
            child: AutoSizeText(
              "Verifica il tuo numero",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.black87),
              maxLines: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 54, vertical: 10),
            child: Pinput(
              autofocus: true,
              length: 6,
              showCursor: false,
              pinAnimationType: PinAnimationType.slide,
              pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
              onCompleted: (value) => _verifyOtp(context, value),
              defaultPinTheme: PinTheme(
                width: 64,
                height: 64,
                textStyle: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.black87),
                decoration: BoxDecoration(
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 10.0,
            ),
            child: Text(
              "Codice di verifica inviato a $phoneNumber",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.black38),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: canResend
                        ? null
                        : Theme.of(context).outlinedButtonTheme.style!.copyWith(
                              overlayColor: MaterialStateProperty.all(
                                Colors.transparent,
                              ),
                              side: MaterialStateProperty.all(
                                BorderSide(
                                  width: 2.0,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ),
                    onPressed: canResend ? _startTimer : () {},
                    child: Text(
                      canResend
                          ? "Invia nuovo codice"
                          : "Rinvia tra ${_timeLeft}s",
                      style: TextStyle(
                        color: canResend
                            ? Colors.black87
                            : Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
