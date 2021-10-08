import 'package:flutter/material.dart';

class CustomGridView extends StatelessWidget {
  CustomGridView({
    Key? key,
    required this.builder,
    required this.list,
    required this.mainAxisCount,
    this.widgetIfEmpty,
    this.additionalWidget,
    this.fillEmptySpace = true,
  }) : super(key: key);
  final Function(BuildContext, int) builder;
  final List<dynamic> list;
  final int mainAxisCount;
  final Widget? widgetIfEmpty;
  final Widget? additionalWidget;
  final bool fillEmptySpace;

  @override
  Widget build(BuildContext context) {
    List<Widget> rowList = [];
    bool additionalWidgetAdded = false;

    if (list.isNotEmpty) {
      for (var i = 0; i < (list.length / mainAxisCount).ceil(); i++) {
        List<Widget> tmpList = [];
        for (var j = i * mainAxisCount;
            j <= ((i + 1) * mainAxisCount) - 1;
            j++) {
          if (j >= list.length) {
            if (tmpList.length != mainAxisCount && fillEmptySpace) {
              for (var k = 0; k <= mainAxisCount - tmpList.length; k++) {
                if (!additionalWidgetAdded && additionalWidget != null) {
                  tmpList.add(additionalWidget!);
                  additionalWidgetAdded = true;
                } else {
                  tmpList.add(Expanded(
                    child: SizedBox(
                      width: 1,
                    ),
                  ));
                }
              }
            }
            break;
          }
          tmpList.add(Expanded(child: builder(context, j)));
        }

        rowList.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: tmpList,
            ),
          ),
        );
      }

      if (!additionalWidgetAdded && additionalWidget != null) {
        List<Widget> tmpList = [];
        tmpList.add(additionalWidget!);
        for (var i = 1; i < mainAxisCount; i++) {
          tmpList.add(Expanded(
            child: SizedBox(
              width: 1,
            ),
          ));
        }
        rowList.add(Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: tmpList,
          ),
        ));
      }
    }

    if (rowList.isEmpty && widgetIfEmpty != null) {
      rowList.add(widgetIfEmpty!);
    }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: rowList,
      ),
    );
  }
}
