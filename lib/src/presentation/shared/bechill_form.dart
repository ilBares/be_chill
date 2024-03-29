import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_chill/src/utils/constants/nums.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class BeChillForm extends StatefulWidget {
  const BeChillForm({
    super.key,
    required this.onBtnPressed,
    required this.children,
    this.centered = false,
    this.buttonText = "Continua",
  });

  final VoidCallback onBtnPressed;
  final List<Widget> children;
  final bool centered;
  final String buttonText;

  @override
  State<BeChillForm> createState() => _BeChillFormState();
}

class _BeChillFormState extends State<BeChillForm> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BeChill.',
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: widget.centered
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              ...widget.children,
              if (widget.centered)
                Padding(
                  padding: const EdgeInsets.only(bottom: 48.0),
                  child: BeChillButton(
                    text: widget.buttonText,
                    onPressed: widget.onBtnPressed,
                  ),
                )
              else
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: BeChillButton(
                      text: widget.buttonText,
                      onPressed: widget.onBtnPressed,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class BeChillButton extends StatelessWidget {
  const BeChillButton({super.key, required this.onPressed, required this.text});

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: Theme.of(context).outlinedButtonTheme.style!.copyWith(
            fixedSize: MaterialStatePropertyAll(
              Size(MediaQuery.of(context).size.width, 50),
            ),
          ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}

///
/// QUESTION
///
class BeChillQuestion extends StatelessWidget {
  const BeChillQuestion({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: Theme.of(context)
          .textTheme
          .titleSmall!
          .copyWith(color: Colors.black87),
      maxLines: 1,
    );
  }
}

///
/// TEXT FIELD
///
class BeChillTextField extends StatefulWidget {
  const BeChillTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;

  @override
  State<BeChillTextField> createState() => _BeChillTextFieldState();
}

class _BeChillTextFieldState extends State<BeChillTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      autofocus: true,
      focusNode: widget.focusNode,
      keyboardType: TextInputType.name,
      maxLength: maxNameLength,
      maxLines: 1,
      showCursor: false,
      style: Theme.of(context)
          .textTheme
          .titleMedium!
          .copyWith(color: Colors.black87),
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: Colors.black12),
        counter: const SizedBox.shrink(),
      ),
    );
  }
}

///
/// BIRTHDAY FIELD
///
class BeChillBirthdayField extends StatefulWidget {
  const BeChillBirthdayField({super.key, this.controller, this.focusNode});

  final FocusNode? focusNode;

  final TextEditingController? controller;

  @override
  State<BeChillBirthdayField> createState() => _BeChillBirthdayFieldState();
}

class _BeChillBirthdayFieldState extends State<BeChillBirthdayField> {
  @override
  Widget build(BuildContext context) {
    final maskFormatter = MaskTextInputFormatter.eager(
      mask: 'd# m# a###',
      filter: {
        'd': RegExp(r'[0-3]'),
        '#': RegExp(r'[0-9]'),
        'm': RegExp(r'[0-1]'),
        'a': RegExp(r'[1-2]'),
      },
    );

    return TextField(
      controller: widget.controller,
      autofocus: true,
      focusNode: widget.focusNode,
      inputFormatters: [maskFormatter],
      keyboardType: TextInputType.number,
      showCursor: false,
      style: Theme.of(context)
          .textTheme
          .titleMedium!
          .copyWith(color: Colors.black87),
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: 'GG MM AAAA',
        hintStyle: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: Colors.black12),
      ),
    );
  }
}

///
/// TEXT FORM
///
class BeChillTextForm extends StatefulWidget {
  const BeChillTextForm({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;

  @override
  State<BeChillTextForm> createState() => _BeChillTextFormState();
}

class _BeChillTextFormState extends State<BeChillTextForm> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      strutStyle: StrutStyle.fromTextStyle(
        Theme.of(context).textTheme.labelMedium!,
      ),
      controller: widget.controller,
      autofocus: true,
      focusNode: widget.focusNode,
      keyboardType: TextInputType.text,
      minLines: 4,
      maxLines: 4,
      maxLength: maxBioLength,
      showCursor: true,
      cursorHeight: Theme.of(context).textTheme.labelMedium!.fontSize,
      cursorColor: Colors.black,
      style: Theme.of(context).textTheme.labelMedium!.copyWith(
            color: Colors.black87,
            fontWeight: FontWeight.w400,
          ),
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 3),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        contentPadding: const EdgeInsets.all(16.0),
        hintText: widget.hintText,
        hintStyle: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: Colors.black12),
      ),
    );
  }
}
