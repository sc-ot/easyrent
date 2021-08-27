import 'package:easyrent/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class MenuCardIconText extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onPressed;
  const MenuCardIconText(this.title, this.icon, this.onPressed, {Key? key})
      : super(key: key);

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
          onTap: () async {
            
            await onPressed.call();

            FocusScope.of(context).requestFocus(
              FocusNode(),
            );
          },
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
                          style: Theme.of(context).textTheme.headline4,
                          maxLines: 2,
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
