import 'package:flutter/material.dart';

class MenuPageContainer extends StatelessWidget {
  final String title;
  final String subTitle;
  final Widget child;
  MenuPageContainer(this.title, this.subTitle, this.child,
      {Key? key, })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.topLeft,
                child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: Theme.of(context).accentColor),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          subTitle,
                          style: Theme.of(context).textTheme.headline6!.copyWith(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.023),
                        ),
                      ],
                    ),
                ),
            ),
            Expanded(
              flex: 4,
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
