import 'package:be_chill/src/utils/resources/utils.dart';
import 'package:be_chill/src/presentation/shared/bechill_form.dart';
import 'package:flutter/cupertino.dart';

class AskBirthdayScreen extends StatefulWidget {
  const AskBirthdayScreen({
    super.key,
    required this.onContinue,
  });

  final Function(String) onContinue;

  @override
  State<AskBirthdayScreen> createState() => _AskBirthdayScreenState();
}

class _AskBirthdayScreenState extends State<AskBirthdayScreen> {
  final _controller = TextEditingController();
  final focusNode = FocusNode();

  void _onContinue() {
    String birthday = _controller.text.trim();
    if (birthday.isNotEmpty) {
      focusNode.unfocus();
      widget.onContinue(_controller.text.trim());
    } else {
      showSnackBar(
        context: context,
        content: 'Il nome deve contenere almeno 3 caratteri',
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    focusNode.unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BeChillForm(
      onBtnPressed: _onContinue,
      children: [
        const BeChillQuestion(text: "Quando sei nato?"),
        BeChillBirthdayField(
          controller: _controller,
          focusNode: focusNode,
        ),
      ],
    );
  }
}
