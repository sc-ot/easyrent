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
    String? authentication = Storage.readString(Constants.KEY_AUTHORIZATION);
    return authentication != null ? true : false;
  }

  static void saveToken(String token) {
    Api().addToHeader(
      {"Authorization": token},
    );
    Storage.saveData(Constants.KEY_AUTHORIZATION, token);
  }

  static String getToken() {
    return Storage.readString(Constants.KEY_AUTHORIZATION) ?? "";
  }

  static void saveUser(String username) {
    Storage.saveData(Constants.KEY_USERNAME, username);
  }

  static String getUsername() {
    return Storage.readString(Constants.KEY_USERNAME) ?? "";
  }

  static void logout(BuildContext context) async {
    Storage.deleteData(Constants.KEY_AUTHORIZATION);
    Storage.deleteData(Constants.KEY_USERNAME);
    Navigator.popAndPushNamed(context, Constants.ROUTE_LOGIN);
  }
}
