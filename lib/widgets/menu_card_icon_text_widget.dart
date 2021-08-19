import 'package:easyrent/core/utils.dart';
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
      width: MediaQuery.of(context).size.width * 0.8,
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 7,
        child: InkWell(
          onTap: () {},
          child: Stack(
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                      ),
                      child: Icon(
                        icon,
                        size:
                            Utils.getDevice(context) == Device.PHONE ? 50 : 70,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          title,
                          style: Utils.getDevice(context) == Device.PHONE
                              ? Theme.of(context).textTheme.headline4
                              : Theme.of(context).textTheme.headline4,
                          maxLines: 1,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 3,
                  color: Colors.orange,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
