import 'package:easyrent/core/constants.dart';
import 'package:flutter/material.dart';

class SettingsEntry extends StatelessWidget {
  final String text;
  const SettingsEntry(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColorLight,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(text),
            Spacer(),
            Switch(
              onChanged: (bool value) {
                Navigator.pushNamed(context, Constants.ROUTE_LOGIN);
              },
              value: true,
            ),
          ],
        ),
      ),
    );
  }
}
