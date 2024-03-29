import 'package:be_chill/src/utils/resources/utils.dart';
import 'package:be_chill/src/presentation/shared/bechill_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AskNameScreen extends StatefulWidget {
  const AskNameScreen({super.key, required this.onContinue});

  final Function(String) onContinue;

  @override
  State<AskNameScreen> createState() => _AskNameScreenState();
}

class _AskNameScreenState extends State<AskNameScreen> {
  final _controller = TextEditingController();
  final focusNode = FocusNode();

  void _onContinue() {
    String name = _controller.text.trim();

    if (name.length > 2) {
      focusNode.unfocus();
      widget.onContinue(name);
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
        const BeChillQuestion(text: "Come ti chiami?"),
        BeChillTextField(
          controller: _controller,
          focusNode: focusNode,
          hintText: "Nome",
        ),
      ],
    );
  }
}
