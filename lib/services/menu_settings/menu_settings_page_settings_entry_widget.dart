import 'package:easyrent/core/application.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
