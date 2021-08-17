import 'package:flutter/material.dart';

class MenuCardIconText extends StatelessWidget {
  final String title;
  final IconData icon;
  const MenuCardIconText(this.title, this.icon, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.height -
              MediaQuery.of(context).size.height * 0.1 -
              MediaQuery.of(context).size.height * 0.25) /
          3.3,
      width: MediaQuery.of(context).size.width*0.8,
      child: Card(
        elevation: 7,
        child: InkWell(
          onTap: () {},
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16,),
                child: Icon(
                  icon,
                  size: MediaQuery.of(context).size.height * 0.08,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headline3!.copyWith(fontSize: MediaQuery.of(context).size.height * 0.05),
                    maxLines: 1,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
