import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class ERLoadingIndicator extends StatelessWidget {
  const ERLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: 50,
        height: 50,
        child: LoadingIndicator(
          indicatorType: Indicator.circleStrokeSpin,
          colors: [
            Theme.of(context).colorScheme.secondary,
          ],
        ),
      ),
    );
  }
}
