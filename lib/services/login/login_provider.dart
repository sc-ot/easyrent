import 'dart:async';
import 'dart:convert';

import 'package:devtools/storage.dart';
import 'package:easyrent/core/authenticator.dart';
import 'package:easyrent/core/constants.dart';
import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/models/login.dart';
import 'package:easyrent/network/repository.dart';
import 'package:flutter/cupertino.dart';

class LoginProvider extends StateProvider {
  EasyRentRepository easyRentRepository = EasyRentRepository();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  StreamSubscription? loginUserSubscription;
  int selectedClient = 0;
  Storage storage = Storage();

  LoginProvider() {
    usernameController.text = "devm1";
    passwordController.text = "Start01";
    notifyListeners();
  }
  void loginUser(BuildContext context) async {
    Map<String, dynamic> loginData = {
      "username": usernameController.text,
      "password": passwordController.text
    };

    loginUserSubscription?.cancel();

    setState(state: STATE.LOADING);

    loginUserSubscription =
        easyRentRepository.loginUser(jsonEncode(loginData)).asStream().listen(
      (response) {
        response.fold(
          (error) {
            setState(state: STATE.ERROR);
          },
          (success) {
            success = success as Login;
            Authenticator.saveAuthentication(success);
            Navigator.popAndPushNamed(
              context,
              Constants.ROUTE_CLIENTS,
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    loginUserSubscription?.cancel();
    super.dispose();
  }
}
