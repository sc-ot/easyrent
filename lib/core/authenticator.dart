import 'package:devtools/sc_network_api.dart';
import 'package:devtools/sc_shared_prefs_storage.dart';
import 'package:easyrent/core/constants.dart';
import 'package:easyrent/models/login.dart';
import 'package:flutter/cupertino.dart';

class Authenticator {
  static void saveAuthentication(Login login) {
    SCNetworkApi().addToHeader(
      {
        "Authorization": Authenticator.getToken(),
      },
    );
    Authenticator.saveToken("Bearer " + login.sessionToken);
    Authenticator.saveUser(login.firstName);
  }

  static void initAuthentication() {
    SCNetworkApi().addToHeader(
      {
        "Authorization": Authenticator.getToken(),
      },
    );
  }

  static bool userLoggedIn() {
    String? authentication = SCSharedPrefStorage.readString(Constants.KEY_AUTHORIZATION);
    return authentication != null ? true : false;
  }

  static void saveToken(String token) {
    SCNetworkApi().addToHeader(
      {"Authorization": token},
    );
    SCSharedPrefStorage.saveData(Constants.KEY_AUTHORIZATION, token);
  }

  static String getToken() {
    return SCSharedPrefStorage.readString(Constants.KEY_AUTHORIZATION) ?? "";
  }

  static void saveUser(String username) {
    SCSharedPrefStorage.saveData(Constants.KEY_USERNAME, username);
  }

  static String getUsername() {
    return SCSharedPrefStorage.readString(Constants.KEY_USERNAME) ?? "";
  }

  static void logout(BuildContext context) async {
    SCSharedPrefStorage.deleteData(Constants.KEY_AUTHORIZATION);
    SCSharedPrefStorage.deleteData(Constants.KEY_USERNAME);
    Navigator.popAndPushNamed(context, Constants.ROUTE_LOGIN);
  }
}
