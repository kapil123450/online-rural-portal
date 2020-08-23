import 'package:final_flutter/screen1.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:final_flutter/screens/AppLanguage.dart';
import 'package:final_flutter/screens/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  runApp(FirstRoute(
    appLanguage: appLanguage,
  ));
}

class FirstRoute extends StatelessWidget {
  final AppLanguage appLanguage;

  FirstRoute({this.appLanguage});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppLanguage>(
      create: (_) => appLanguage,
      child: Consumer<AppLanguage>(builder: (context, model, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'FlutterDemo',
          locale: model.appLocal,
          supportedLocales: [
            Locale('en', ''),
            Locale('hi', ''),
          ],
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          home: LoginScreen(),
        );
      }),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

  Future<bool> loginUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 20),
        verificationCompleted: (AuthCredential credential) async {
          Navigator.of(context).pop();

          AuthResult result = await _auth.signInWithCredential(credential);

          FirebaseUser user = result.user;

          if (user != null) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => main_screen1()));
          } else {
            print("Error");
          }
        },
        verificationFailed: (AuthException exception) {
          print(exception);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text(
                      AppLocalizations.of(context).translate("Enter sms code")),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: _codeController,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text(
                          AppLocalizations.of(context).translate("Verify")),
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: () async {
                        final code = _codeController.text.trim();
                        AuthCredential credential =
                            PhoneAuthProvider.getCredential(
                                verificationId: verificationId, smsCode: code);

                        AuthResult result =
                            await _auth.signInWithCredential(credential);

                        FirebaseUser user = result.user;

                        if (user != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => main_screen1()));
                        } else {
                          print("Error");
                        }
                      },
                    )
                  ],
                );
              });
        },
        codeAutoRetrievalTimeout: null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            AppLocalizations.of(context).translate("Phone Authentication")),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(30),
              child: TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)
                        .translate("Enter Phone Number starting with +91")),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              onPressed: () {
                loginUser(_phoneController.text, context);
              },
              child: Text(AppLocalizations.of(context).translate("Verify")),
              textColor: Colors.white,
              elevation: 7,
              color: Colors.green,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      Provider.of<AppLanguage>(context, listen: false)
                          .changeLanguage(Locale("en"));
                    },
                    child: Text('English'),
                  ),
                  RaisedButton(
                    onPressed: () {
                      debugPrint('hindi');
                      Provider.of<AppLanguage>(context, listen: false)
                          .changeLanguage(Locale("hi"));
                    },
                    child: Text('हिंदी'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
