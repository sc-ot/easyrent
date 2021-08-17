import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:easyrent/core/state_provider.dart';
import 'package:easyrent/services/login/login_provider.dart';
import 'package:easyrent/widgets/linear_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => LoginProvider(),
      builder: (context, child) {
        return Consumer<LoginProvider>(
          builder: (context, loginProvider, child) {
            return Scaffold(
              body: SafeArea(
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: loginProvider.ui == STATE.LOADING ? ERLinearProgressIndicator() : Container(),
                    ),
                    Center(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "EasyRent",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(
                                        color: Theme.of(context).accentColor),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 16.0, bottom: 16),
                                child: AnimatedOpacity(
                                  opacity:
                                      loginProvider.ui == STATE.ERROR ? 1 : 0,
                                  duration: Duration(seconds: 1),
                                  child: Text(
                                    "Anmeldung fehlgeschlagen. Bitte überprüfe deine Zugangsdaten und die Internetverbindung.",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(color: Colors.red),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              TextField(
                                decoration: InputDecoration(
                                  labelText: "Benutzername",
                                  labelStyle:
                                      Theme.of(context).textTheme.bodyText1,
                                  prefixIcon: Icon(
                                    Icons.person_add_alt_1_outlined,
                                    color: Theme.of(context).accentColor,
                                  ),
                                ),
                                controller: loginProvider.usernameController,
                              ),
                              SizedBox(
                                height: 32,
                              ),
                              TextField(
                                obscureText: true,
                                controller: loginProvider.passwordController,
                                decoration: InputDecoration(
                                  labelText: "Passwort",
                                  labelStyle:
                                      Theme.of(context).textTheme.bodyText1,
                                  prefixIcon: Icon(
                                    Icons.lock_outline_rounded,
                                    color: Theme.of(context).accentColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 32,
                              ),
                              FloatingActionButton.extended(
                                onPressed: () {
                                  loginProvider.loginUser(context);
                                },
                                label: Row(
                                  children: [
                                    Icon(
                                      Icons.login_outlined,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "Anmelden",
                                      style: Theme.of(context).textTheme.button,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
