import 'package:flutter/material.dart';

class MenuPageContainer extends StatelessWidget {
  final String title;
  final String subTitle;
  final Widget child;
  final double paddingBottom;
  final bool resizeToAvoidBottomInset;
  Widget? floatingActionButton;
  AppBar? appBar;
  MenuPageContainer(
    this.title,
    this.subTitle,
    this.child, {
    Key? key,
    this.paddingBottom = 4,
    this.appBar,
    this.floatingActionButton,
    this.resizeToAvoidBottomInset = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton,
      appBar: appBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: Center(
        child: Container(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, paddingBottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary)),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          subTitle,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                  ),
                ),
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
