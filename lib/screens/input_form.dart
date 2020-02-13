import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/screens/AppLanguage.dart';

class InputForm extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return InputFormState();
  }
}

class InputFormState extends State<InputForm> {
  TextEditingController nameController = TextEditingController(text: 'xyz');
  TextEditingController numberController = TextEditingController(text: '8264959487');
  TextEditingController fathernameController = TextEditingController(text: 'xyz');
  TextEditingController adharnumberController = TextEditingController(text: '33xxx');
  bool validate_name = false;
  bool validate_fatherName = false;
  bool validate_number = false;
  bool validate_adharnumber = false;
  Locale locale;
  AppLanguage appLanguage = AppLanguage();

  void initState()  {
    super.initState();


    appLanguage.fetchLocale().then((locale) {
      setState(() {
        this.locale = locale;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    var appLanguage = Provider.of<AppLanguage>(context);
    return MaterialApp(
        locale: this.locale,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: [
    const Locale('en', ''), // English
    const Locale('hi', ''), // Arabic
    ],
      home:Scaffold(
      appBar: AppBar(title: Text('Form')),
      body: Padding(
        padding:
            EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),

        child: ListView(
          children: <Widget>[

            Padding(
              padding: EdgeInsets.only(
                  top: 20.0, left: 10.0, right: 10),
              child: TextField(
                controller: nameController,
                style: textStyle,

                onChanged: (value) {
                  debugPrint('Something changed in name field');
                  setState(() {
                    nameController.text.isEmpty ? validate_name = true : validate_name = false;
                  });
                },
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).translate("first_string"),
                    labelStyle: textStyle,
                    errorText: validate_name?'Value can\'nt be empty':null,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 20.0, left: 10.0, right: 10),
              child: TextField(
                controller: fathernameController,
                style: textStyle,

                onChanged: (value) {
                  debugPrint('Something changed in number field');
                  setState(() {
                    fathernameController.text.isEmpty ? validate_fatherName = true : validate_fatherName = false;
                  });
                },
                decoration: InputDecoration(
                    labelText: 'Father Name',
                    labelStyle: textStyle,
                    errorText: validate_fatherName?'Value can\'nt be empty':null,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
              Padding(
                padding: EdgeInsets.only(
                    top: 20.0, left: 10.0, right: 10),
                child: TextField(
                  controller: numberController,
                  style: textStyle,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    debugPrint('Something changed in number field');
                    setState(() {
                      numberController.text.isEmpty ? validate_number = true : validate_number = false;
                    });
                  },
                  decoration: InputDecoration(
                      labelText: 'Mobile Number',
                      labelStyle: textStyle,
                      errorText: validate_number?'Value can\'nt be empty':null,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 20.0, left: 10.0, right: 10),
              child: TextField(
                controller: numberController,
                style: textStyle,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  debugPrint('Something changed in number field');
                },
                decoration: InputDecoration(
                    labelText: 'Mobile Number 2',
                    labelStyle: textStyle,

                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 20.0, left: 10.0, right: 10),
              child: TextField(
                controller: adharnumberController,
                style: textStyle,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  debugPrint('Something changed in discription field');
                  setState(() {
                    adharnumberController.text.isEmpty ? validate_adharnumber = true : validate_adharnumber = false;
                  });
                },
                decoration: InputDecoration(
                    labelText: 'Adhar Number',
                    labelStyle: textStyle,
                    errorText: validate_adharnumber?'Value can\'nt be empty':null,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top:15.0 , bottom: 15.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Submit',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: (){
                        setState((){
                          debugPrint("Ok");
                        });
                      },
                    ),
                  ),
                  Container(width: 5.0),
                  Expanded(
                      child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            'Back',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: (){
                            setState((){
                              debugPrint("Back button pressed");
                            });
                          },
                      ),
                  ),
                ],
              ),
            ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              appLanguage.changeLanguage(Locale("en_"));
            },
            child: Text('English'),
          ),
          RaisedButton(
            onPressed: () {
              debugPrint('hindi');
              appLanguage.changeLanguage(Locale("hi_"));
            },
            child: Text('हिंदी'),
          )
          ],
        ),
      ],
      ),
    ),
    ),
    );
  }


}
