import 'package:easyrent/core/application.dart';
import 'package:easyrent/core/constants.dart';
import 'package:easyrent/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sc_appframework/storage/sc_shared_prefs_storage.dart';

class MenuCardIconText extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onPressed;
  String? backgroundImage;

  MenuCardIconText(
    this.title,
    this.icon,
    this.onPressed, {
    Key? key,
    this.backgroundImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Application application = Provider.of<Application>(context, listen: false);
    return Container(
      height: (MediaQuery.of(context).size.height -
              MediaQuery.of(context).size.height * 0.1 -
              MediaQuery.of(context).size.height * 0.25) /
          3.3,
      width: MediaQuery.of(context).size.width * 1,
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
            fit: StackFit.expand,
            children: [
              backgroundImage != null
                  ? Container(
                      width: double.infinity,
                      child: Image.asset(
                        backgroundImage!,
                        fit: BoxFit.fitWidth,
                      ),
                    )
                  : Container(),
              backgroundImage != null
                  ? Container(
                      color: application.themeMode == ThemeMode.dark
                          ? Colors.black.withOpacity(0.4)
                          : Colors.black.withOpacity(0.1),
                    )
                  : Container(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                        ),
                        child: Icon(
                          icon,
                          size: Utils.getDevice(context) == Device.PHONE
                              ? 50
                              : 70,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          child: Text(
                            title,
                            style: application.themeMode == ThemeMode.light &&
                                    SCSharedPrefStorage.readBool(Constants
                                            .KEY_SHOW_IMAGES_IN_MENU) !=
                                        null &&
                                    SCSharedPrefStorage.readBool(
                                        Constants.KEY_SHOW_IMAGES_IN_MENU)
                                ? Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(color: Colors.white)
                                : Theme.of(context).textTheme.headline4,
                            overflow: TextOverflow.ellipsis,
                          ),
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
                  color: Theme.of(context).colorScheme.secondary,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
