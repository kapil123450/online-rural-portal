import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:final_flutter/labour_form.dart';

import 'package:final_flutter/screens/input_form.dart';
import 'package:final_flutter/screens/reasonwise1.dart';
import 'package:final_flutter/screens/viewprob.dart';

import 'package:final_flutter/screens/awareness.dart';

import 'package:final_flutter/screens/app_localizations.dart';
import 'package:final_flutter/personal_problem.dart';
import 'package:final_flutter/settings.dart';

class hs1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint("context in start1 - " + context.hashCode.toString());
    return new Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate("Welcome")),
      ),
      drawer: Container(
        width: 200,
        height: 240,
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors
                .blueGrey, //This will change the drawer background to blue.
          ),
          child: Drawer(
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10),
                  child: Center(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        AppLocalizations.of(context) != null
                            ? AppLocalizations.of(context).translate('settings')
                            : 'settings',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Settings()),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10),
                  child: Center(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        AppLocalizations.of(context) != null
                            ? AppLocalizations.of(context).translate('Log out')
                            : 'Log out',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Displaypeople()),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: new InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InputForm()),
                );
              },
              child: Container(
                child: new FittedBox(
                  child: Material(
                      color: Colors.white,
                      elevation: 14.0,
                      borderRadius: BorderRadius.circular(24.0),
                      shadowColor: Colors.blue,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: 250,
                            height: 100,
                            child: Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .translate("Register your problem"),
                                    style: TextStyle(color: Colors.deepPurple),
                                  ),
                                )
                                //child: myDetailsContainer1(),
                                ),
                          ),
                        ],
                      )),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: new InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => yourProblems()),
                );
              },
              child: Container(
                child: new FittedBox(
                  child: Material(
                      color: Colors.white,
                      elevation: 14.0,
                      borderRadius: BorderRadius.circular(24.0),
                      shadowColor: Color(0x802196F3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: 250,
                            height: 100,
                            child: Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .translate("View your problem"),
                                    style: TextStyle(color: Colors.deepPurple),
                                  ),
                                )
                                //child: myDetailsContainer1(),
                                ),
                          ),
                        ],
                      )),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: new InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => reagonwise()),
                );
              },
              child: Container(
                child: new FittedBox(
                  child: Material(
                      color: Colors.white,
                      elevation: 14.0,
                      borderRadius: BorderRadius.circular(24.0),
                      shadowColor: Colors.blue,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: 250,
                            height: 100,
                            child: Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .translate("District Problems"),
                                    style: TextStyle(color: Colors.deepPurple),
                                  ),
                                )
                                //child: myDetailsContainer1(),
                                ),
                          ),
                        ],
                      )),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: new InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
              child: Container(
                child: new FittedBox(
                  child: Material(
                      color: Colors.white,
                      elevation: 14.0,
                      borderRadius: BorderRadius.circular(24.0),
                      shadowColor: Color(0x802196F3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: 250,
                            height: 100,
                            child: Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .translate("General Awareness"),
                                    style: TextStyle(color: Colors.deepPurple),
                                  ),
                                )
                                //child: myDetailsContainer1(),
                                ),
                          ),
                        ],
                      )),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: new InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InputFormForLabour()),
                );
              },
              child: Container(
                //decoration: BoxDecoration(shape: BoxShape.circle),
                child: new FittedBox(
                  child: Material(
                      color: Colors.white,
                      elevation: 14.0,
                      borderRadius: BorderRadius.circular(24.0),
                      shadowColor: Colors.blue,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: 250,
                            height: 100,
                            child: Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(context) != null
                                        ? AppLocalizations.of(context)
                                            .translate(
                                                "Register as a skilled labour")
                                        : "Register as a skilled labour",
                                    style: TextStyle(color: Colors.deepPurple),
                                  ),
                                )
                                //child: myDetailsContainer1(),
                                ),
                          ),
                        ],
                      )),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: new InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DropdownScreen()),
                );
              },
              child: Container(
                //decoration: BoxDecoration(shape: BoxShape.circle),
                child: new FittedBox(
                  child: Material(
                      color: Colors.white,
                      elevation: 14.0,
                      borderRadius: BorderRadius.circular(24.0),
                      shadowColor: Colors.blue,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: 250,
                            height: 100,
                            child: Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(context) != null
                                        ? AppLocalizations.of(context).translate(
                                            "Submit problem to local people")
                                        : "Submit problem to local people",
                                    style: TextStyle(color: Colors.deepPurple),
                                  ),
                                )
                                //child: myDetailsContainer1(),
                                ),
                          ),
                        ],
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}