import 'package:auto_size_text/auto_size_text.dart';
import 'package:be_chill/src/presentation/shared/bechill_form.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  List<Contact> _contacts = const [];

  Future<void> loadContacts() async {
    final contacts = await FastContacts.getAllContacts();
    setState(() {
      _contacts = contacts;
    });
  }

  @override
  void initState() {
    loadContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Friends',
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Scrollbar(
              interactive: true,
              child: ListView.builder(
                controller: null,
                itemCount: _contacts.length,
                itemBuilder: (_, index) {
                  String givenName =
                      _contacts[index].structuredName?.givenName ?? ' ';
                  String familyName =
                      _contacts[index].structuredName?.familyName ?? ' ';

                  String phone =
                      _contacts[index].phones.firstOrNull?.number ?? ' ';

                  return _ContactTile(
                    givenName: givenName,
                    familyName: familyName,
                    phone: phone,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactTile extends StatefulWidget {
  const _ContactTile({
    required this.givenName,
    required this.familyName,
    required this.phone,
  });

  final String givenName;
  final String familyName;
  final String phone;

  @override
  State<_ContactTile> createState() => __ContactTileState();
}

class __ContactTileState extends State<_ContactTile> {
  bool clicked = false;

  @override
  Widget build(BuildContext context) {
    String fst = widget.givenName.isEmpty ? '' : widget.givenName[0];
    String snd = widget.familyName.isEmpty ? '' : widget.familyName[0];

    return Container(
      margin: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(45)),
        border: Border.all(
          color: Colors.black12,
          width: 2.0,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30.0,
            backgroundColor: Colors.black87,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AutoSizeText(
                '$fst$snd',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${widget.givenName} ${widget.familyName}'),
                Text(widget.phone),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: OutlinedButton(
                  style: Theme.of(context).outlinedButtonTheme.style!.copyWith(
                        backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.secondary,
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(45.0),
                          ),
                        ),
                      ),
                  onPressed: () {
                    setState(() {
                      clicked = !clicked;
                    });
                  },
                  child: clicked
                      ? const Icon(
                          Icons.done_rounded,
                          size: 20,
                        )
                      : const Text('AGGIUNGI'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
