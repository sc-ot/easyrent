import 'package:devtools/api.dart';
import 'package:devtools/storage.dart';
import 'package:easyrent/core/constants.dart';
import 'package:easyrent/models/login.dart';
import 'package:flutter/cupertino.dart';

class Authenticator {
  static void saveAuthentication(Login login) {
    Api().addToHeader(
      {
        "Authorization": Authenticator.getToken(),
      },
    );
    Authenticator.saveToken("Bearer " + login.sessionToken);
    Authenticator.saveUser(login.firstName);
  }

  static void initAuthentication() {
    Api().addToHeader(
      {
        "Authorization": Authenticator.getToken(),
      },
    );
  }

  static bool userLoggedIn() {
    Storage storage = Storage();
    String? authentication =
        storage.sharedPreferences.getString(Constants.KEY_AUTHORIZATION);
    return authentication != null ? true : false;
  }

  static void saveToken(String token) {
    Storage storage = Storage();
    Api().addToHeader(
      {"Authorization": token},
    );
    storage.sharedPreferences.setString(Constants.KEY_AUTHORIZATION, token);
  }

  static String getToken() {
    Storage storage = Storage();
    return storage.sharedPreferences.getString(Constants.KEY_AUTHORIZATION) ??
        "";
  }

  static void saveUser(String username) {
    Storage storage = Storage();
    storage.sharedPreferences.setString(Constants.KEY_USERNAME, username);
  }

  static String getUsername() {
    Storage storage = Storage();
    return storage.sharedPreferences.getString(Constants.KEY_USERNAME) ?? "";
  }

  static void logout(BuildContext context) async {
    Storage storage = Storage();
    await storage.sharedPreferences.clear();
    Navigator.popAndPushNamed(context, Constants.ROUTE_LOGIN);
  }
}
