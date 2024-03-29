import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_chill/data/default_country.dart';
import 'package:be_chill/src/presentation/providers/firebase_auth_provider.dart';
import 'package:be_chill/src/presentation/providers/user_provider.dart';
import 'package:be_chill/src/utils/resources/utils.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  Country _selectedCountry = defaultCountry;

  void onSelectCountry(Country country) {
    setState(() {
      _selectedCountry = country;
    });
  }

  void onSendCode(
    BuildContext context,
    FirebaseAuthProvider authProvider,
    UserProvider userProvider,
  ) {
    final phoneNumber = _phoneController.text.trim().replaceAll(' ', '');

    if (phoneNumber.length == 9 || phoneNumber.length == 10) {
      final countryCode = '+${_selectedCountry.phoneCode}';

      // void onCodeSent(String verificationId, int? resendToken) async {
      //   final SharedPreferences s = await SharedPreferences.getInstance();
      //   s.setString('verification_id', verificationId);
      //   s.setInt('resend_token', resendToken ?? 0);
      //   s.setString('country_code', countryCode);
      //   s.setString('phone_number', phoneNumber);

      //   Navigator.pushNamed(context, '/verify');
      // }

      authProvider.signInWithPhone(
        context: context,
        countryCode: countryCode,
        phoneNumber: phoneNumber,
        codeSentCallback: (String vid) {
          userProvider.setPhoneNumber('$countryCode $phoneNumber');
          userProvider.setVerificationId(vid);

          Navigator.of(context).pushNamed('/otp');
        },
      );
    } else {
      showSnackBar(context: context, content: 'Numero di telefono non valido.');
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<FirebaseAuthProvider>(
      context,
      listen: true,
    );

    final userProvider = Provider.of<UserProvider>(
      context,
      listen: false,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BeChill.',
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const TextAskPhoneNumber(),
            Row(
              children: [
                BeChillCountryPicker(
                  selectedCountry: _selectedCountry,
                  onSelectCountry: onSelectCountry,
                ),
                TextPhoneInput(
                  phoneController: _phoneController,
                ),
              ],
            ),
            const TextPrivacy(),
            SendCodeButton(
              isLoading: authProvider.isLoading,
              onSendCode: () => onSendCode(context, authProvider, userProvider),
            ),
          ],
        ),
      ),
    );
  }
}

class TextAskPhoneNumber extends StatelessWidget {
  const TextAskPhoneNumber({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: AutoSizeText(
        "Qual è il tuo numero di telefono?",
        style: Theme.of(context)
            .textTheme
            .titleSmall!
            .copyWith(color: Colors.black87),
        maxLines: 1,
      ),
    );
  }
}

class BeChillCountryPicker extends StatefulWidget {
  const BeChillCountryPicker({
    super.key,
    required this.selectedCountry,
    required this.onSelectCountry,
  });

  final Country selectedCountry;
  final Function(Country country) onSelectCountry;

  @override
  State<BeChillCountryPicker> createState() => _BeChillCountryPickerState();
}

class _BeChillCountryPickerState extends State<BeChillCountryPicker> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: InkWell(
        splashColor: Theme.of(context).colorScheme.secondary,
        onTap: () {
          showCountryPicker(
            favorite: ['IT', 'US', 'FR', 'DE', 'ES'],
            context: context,
            onSelect: widget.onSelectCountry,
          );
        },
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.black87,
              width: 2.0,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${widget.selectedCountry.flagEmoji} +${widget.selectedCountry.phoneCode}',
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 18.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TextPhoneInput extends StatefulWidget {
  const TextPhoneInput({super.key, required this.phoneController});

  final TextEditingController phoneController;

  @override
  State<TextPhoneInput> createState() => _TextPhoneInputState();
}

class _TextPhoneInputState extends State<TextPhoneInput> {
  final maskFormatter = MaskTextInputFormatter.eager(
    mask: '### ### ####',
    filter: {
      '#': RegExp(r'[0-9]'),
    },
  );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: TextField(
          inputFormatters: [maskFormatter],
          controller: widget.phoneController,
          enableSuggestions: false,
          autofocus: true,
          keyboardType: TextInputType.phone,
          maxLines: 1,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Colors.black87, height: 1.0),
          decoration: const InputDecoration(
            counter: SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}

class TextPrivacy extends StatelessWidget {
  const TextPrivacy({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 10.0,
      ),
      child: Text(
        "Continuando, acconsenti alla nostra Informativa sulla Privacy e Termini di Servizio.",
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: Colors.black38),
      ),
    );
  }
}

class SendCodeButton extends StatelessWidget {
  const SendCodeButton({
    super.key,
    required this.isLoading,
    required this.onSendCode,
  });

  final bool isLoading;
  final VoidCallback onSendCode;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: onSendCode,
              child: isLoading
                  ? SizedBox(
                      height: 18.0,
                      width: 18.0,
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.secondary,
                        strokeCap: StrokeCap.round,
                      ),
                    )
                  : const Text(
                      "Invia messaggio di verifica",
                      style: TextStyle(color: Colors.black87),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
