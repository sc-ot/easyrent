import 'package:easyrent/core/application.dart';
import 'package:flutter/material.dart';

class SettingsEntry extends StatefulWidget {
  final String text;
  final bool isActive;
  Function onTap;
  SettingsEntry(this.text, this.isActive, this.onTap, {Key? key})
      : super(key: key);

  @override
  _SettingsEntryState createState() => _SettingsEntryState();
}

class _SettingsEntryState extends State<SettingsEntry> {
  late bool settingsSelected;

  late Application application;

  @override
  void initState() {
    settingsSelected = widget.isActive;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColorLight,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.text,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            Switch(
              activeColor: Theme.of(context).colorScheme.secondary,
              inactiveThumbColor: Theme.of(context).colorScheme.secondary,
              inactiveTrackColor:
                  Theme.of(context).colorScheme.secondary.withOpacity(0.5),
              activeTrackColor: Theme.of(context).colorScheme.secondary,
              onChanged: (bool value) {
                setState(
                  () {
                    settingsSelected = value;
                  },
                );
                widget.onTap.call(value);
              },
              value: settingsSelected,
            ),
          ],
        ),
      ),
    );
  }
}
