import 'dart:io';

import 'package:final_flutter/create_new_job.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:final_flutter/screens/app_localizations.dart';

class InputFormForLoc extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return InputFormState();
  }
}

class InputFormState extends State<InputFormForLoc> {
  Geolocator geolocator = Geolocator();
  Position userLocation;
  String postalcode;
  TextEditingController nameController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController fathernameController = TextEditingController();
  TextEditingController adharnumberController = TextEditingController();
  bool validate_name = false;
  bool validate_fatherName = false;
  bool validate_number = false;
  bool validate_adharnumber = false;
  bool validate_pc = true;
  Locale locale;
  SharedPreferences prefs;
  FirebaseAuth _auth = FirebaseAuth.instance;
  /*  addStringToSF(phone) async {
  print(phone);
  prefs = await SharedPreferences.getInstance();
  prefs.setString('stringValue', phone);
  } */
  Future<String> _getLocation() async {
    print("1..Inside location fn");
    Position currentLocation;
    try {
      currentLocation = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
    } catch (e) {
      print(e);
      print("error");
      currentLocation = null;
    }
    print("2...$currentLocation");
    List<Placemark> placemark =
        await Geolocator().placemarkFromPosition(currentLocation);
    print(placemark);
    print(placemark[0].postalCode);
    return placemark[0].postalCode.toString();
  }

  storeData(BuildContext context) async {
    final FirebaseUser currentUser = await _auth.currentUser();
    print("inside data");
    prefs = await SharedPreferences.getInstance();
    prefs.setString('phone', currentUser.phoneNumber);
    validate_name
        ? print("no name")
        : prefs.setString('name', nameController.text);

    print(pincodeController.text);
    prefs.setString('postalcode', pincodeController.text);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      appBar: AppBar(
          title: Text(AppLocalizations.of(context).translate("User details"))),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10),
              child: TextField(
                controller: nameController,
                style: textStyle,
                onChanged: (value) {
                  debugPrint('Something changed in name field');
                  setState(() {
                    nameController.text.isEmpty
                        ? validate_name = true
                        : validate_name = false;
                  });
                },
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).translate("name"),
                    labelStyle: textStyle,
                    errorText: validate_name
                        ? AppLocalizations.of(context)
                            .translate("Value can not be empty")
                        : null,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10),
              child: TextField(
                controller: pincodeController,
                style: textStyle,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  debugPrint('Something changed in pincode');
                  setState(() {
                    pincodeController.text.isEmpty
                        ? validate_pc = true
                        : validate_pc = false;
                  });
                },
                decoration: InputDecoration(
                    labelText:
                        AppLocalizations.of(context).translate("Pincode"),
                    labelStyle: textStyle,
                    errorText: validate_pc
                        ? AppLocalizations.of(context)
                            .translate("Value can not be empty")
                        : null,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(120),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        AppLocalizations.of(context).translate('Submit'),
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        _getLocation().then((value) {
                          print("##$value");
                          setState(() {
                            postalcode = value;
                          });
                        });
                        storeData(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => create_new_job()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
