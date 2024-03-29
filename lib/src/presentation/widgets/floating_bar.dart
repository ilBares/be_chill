import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ProfileOption {
  profile,
  friends,
  settings,
}

class FloatingBar extends StatefulWidget {
  const FloatingBar({super.key});

  @override
  State<FloatingBar> createState() => _FloatingBarState();
}

class _FloatingBarState extends State<FloatingBar> {
  var _selectedOption = ProfileOption.profile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0),
      child: CupertinoSlidingSegmentedControl<ProfileOption>(
        backgroundColor: Colors.grey.shade200.withAlpha(245),
        groupValue: _selectedOption,
        onValueChanged: (option) {
          setState(() {
            _selectedOption = option!;
          });
        },
        children: const <ProfileOption, Widget>{
          ProfileOption.profile: OptionItem('profile'),
          ProfileOption.friends: OptionItem('friends'),
          ProfileOption.settings: OptionItem('settings'),
        },
      ),
    );
  }
}

class OptionItem extends StatelessWidget {
  const OptionItem(this._text, {super.key});

  final String _text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        _text,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
