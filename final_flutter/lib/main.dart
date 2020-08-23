import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:final_flutter/start1.dart';
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
          home: MyApp(),
        );
      }),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint("context in counterscreen - " + context.hashCode.toString());
    return Scaffold(
        body: MyAppPage(
      title: AppLocalizations.of(context).translate("Phone Authentication"),
      hintext: AppLocalizations.of(context)
          .translate("Enter Phone Number starting with +91"),
      verify: AppLocalizations.of(context).translate("Verify"),
      entersmscode: AppLocalizations.of(context).translate("Enter sms code"),
    ));
  }
}

class MyAppPage extends StatefulWidget {
  MyAppPage({this.title, this.hintext, this.verify, this.entersmscode});
  final String title;
  final String hintext;
  final String verify;
  final String entersmscode;

  @override
  _MyAppPageState createState() => _MyAppPageState();
}

class _MyAppPageState extends State<MyAppPage> {
  String phoneNo;
  String smsOTP;
  String verificationId;
  String errorMessage = '';
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> verifyPhone() async {
    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      smsOTPDialog(context).then((value) {
        print('sign in');
      });
    };
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: this.phoneNo, // PHONE NUMBER TO SEND OTP
          codeAutoRetrievalTimeout: (String verId) {
            //Starts the phone number verification process for the given phone number.
            //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
            this.verificationId = verId;
          },
          codeSent:
              smsOTPSent, // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.
          timeout: const Duration(seconds: 20),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            Navigator.of(context).pop();
            Navigator.push(context,
                new MaterialPageRoute(builder: (context) => new hs1()));
            print(phoneAuthCredential);
          },
          verificationFailed: (AuthException exceptio) {
            print('${exceptio.message}');
          });
    } catch (e) {
      handleError(e);
    }
  }

  Future<bool> smsOTPDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text(widget.entersmscode),
            content: Container(
              height: 50,
              child: Column(children: [
                TextField(
                  onChanged: (value) {
                    this.smsOTP = value;
                  },
                ),
                (errorMessage != ''
                    ? Text(
                        errorMessage,
                        style: TextStyle(color: Colors.red),
                      )
                    : Container())
              ]),
            ),
            contentPadding: EdgeInsets.all(30),
            actions: <Widget>[
              FlatButton(
                child: AppLocalizations.of(context) != null
                    ? Text(AppLocalizations.of(context).translate("Ok"))
                    : Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => new hs1()));
                  //signIn();
                },
              )
            ],
          );
        });
  }

  signIn() async {
    print(smsOTP);
    try {
      final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId,
        smsCode: smsOTP,
      );
      final FirebaseUser user =
          (await _auth.signInWithCredential(credential)) as FirebaseUser;
      if (user != null) {
        Navigator.of(context).pop();
        Navigator.push(
            context, new MaterialPageRoute(builder: (context) => new hs1()));
      }
    } catch (e) {
      handleError(e);
    }
  }

  handleError(PlatformException error) {
    print(error);
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        FocusScope.of(context).requestFocus(new FocusNode());
        setState(() {
          errorMessage = 'Invalid Code';
        });
        Navigator.of(context).pop();
        smsOTPDialog(context).then((value) {
          print('sign in');
        });
        break;
      default:
        setState(() {
          errorMessage = error.message;
        });

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("context in myappage screen - " + context.hashCode.toString());

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
                decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)
                        .translate("Enter Phone Number starting with +91")),
                onChanged: (value) {
                  this.phoneNo = value;
                },
              ),
            ),
            (errorMessage != ''
                ? Text(
                    errorMessage,
                    style: TextStyle(color: Colors.red),
                  )
                : Container()),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              onPressed: () {
                verifyPhone();
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
