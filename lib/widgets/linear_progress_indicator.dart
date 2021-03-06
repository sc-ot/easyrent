import 'package:flutter/material.dart';

class ERLinearProgressIndicator extends StatelessWidget {
  const ERLinearProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      color: Theme.of(context).accentColor,
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
