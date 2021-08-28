import 'package:flutter/material.dart';

class MenuPageContainer extends StatelessWidget {
  final String title;
  final String subTitle;
  final Widget child;
  final double paddingBottom;
  final bool isMobile;
  MenuPageContainer(this.title, this.subTitle, this.child,
      {Key? key, this.paddingBottom = 4, this.isMobile = false})
      : super(key: key);

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
                      child: Text(
                        title,
                        style: isMobile
                            ? Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(color: Theme.of(context).accentColor, fontSize: MediaQuery.of(context).size.height * 0.06)
                            : Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(color: Theme.of(context).accentColor),
                                overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    FittedBox(
                      child: Text(
                        subTitle,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontSize: MediaQuery.of(context).size.height * 0.023),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 4,
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
