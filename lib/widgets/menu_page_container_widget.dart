import 'package:easyrent/core/utils.dart';
import 'package:flutter/material.dart';

class MenuPageContainer extends StatelessWidget {
  final String title;
  final String subTitle;
  final Widget child;
  final double paddingBottom;
  MenuPageContainer(
    this.title,
    this.subTitle,
    this.child, {
    Key? key,
    this.paddingBottom = 4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, paddingBottom),
        child: Column(
          children: [
            Flexible(
              child: Container(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      child: Text(title,
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary)),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    FittedBox(
                      child: Text(
                        subTitle,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: Utils.getDevice(context) == Device.PHONE ? 4 : 7,
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
