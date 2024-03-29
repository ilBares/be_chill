import 'package:be_chill/src/presentation/shared/bechill_form.dart';
import 'package:flutter/cupertino.dart';

class AskBioScreen extends StatefulWidget {
  const AskBioScreen({super.key, required this.onContinue});

  final Function(String) onContinue;

  @override
  State<AskBioScreen> createState() => _AskBioScreenState();
}

class _AskBioScreenState extends State<AskBioScreen> {
  final _controller = TextEditingController();
  final focusNode = FocusNode();

  void _onContinue() {
    String bio = _controller.text.trim();

    focusNode.unfocus();
    widget.onContinue(bio);
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
        const BeChillQuestion(text: "Inserisci una breve biografia"),
        BeChillTextForm(
          controller: _controller,
          focusNode: focusNode,
        ),
      ],
    );
  }
}
