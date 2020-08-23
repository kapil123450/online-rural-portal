import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:final_flutter/screens/input_form.dart';
import 'package:final_flutter/screens/reasonwise1.dart';
import 'package:final_flutter/screens/viewprob.dart';

import 'package:final_flutter/screens/app_localizations.dart';

class gov_portal_screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint("context in start1 - " + context.hashCode.toString());
    return new Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate("Welcome")),
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
        ],
      ),
    );
  }
}
