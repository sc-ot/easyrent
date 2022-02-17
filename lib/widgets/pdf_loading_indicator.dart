import 'package:easyrent/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';

class PDFLoadingIndicator extends StatelessWidget {
  String title;
  PDFLoadingIndicator(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: ERLoadingIndicator(),
            width: MediaQuery.of(context).size.height * 0.08,
            height: MediaQuery.of(context).size.height * 0.08,
          ),
          Text(
            this.title,
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }
}
