import 'package:final_flutter/accepted_job_requests.dart';
import 'package:final_flutter/assign_the_job.dart';
import 'package:final_flutter/complited_job_requests.dart';
import 'package:final_flutter/personal_problem.dart';
import 'package:final_flutter/rejected_job_requests.dart';
import 'package:final_flutter/resppond_pending_job_requests.dart';
import 'package:final_flutter/screens/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class solve_local_problems extends StatefulWidget {
  @override
  solve_local_problems_state createState() => new solve_local_problems_state();
}

class solve_local_problems_state extends State<solve_local_problems> {
  String phone = "8264959487";
  bool is_registered;
  DocumentSnapshot registeredUser;
  getdata() async {
    FirebaseUser cu = await FirebaseAuth.instance.currentUser();
    setState(() {
      phone = cu.phoneNumber;
    });
    print(phone);
    final QuerySnapshot result = await Firestore.instance
        .collection('skilled_labour')
        .where('phone', isEqualTo: phone)
        .getDocuments();

    if (result.documents.length != 0) {
      setState(() {
        registeredUser = result.documents[0];
      });
    } else {
      setState(() {
        registeredUser = null;
      });
    }
    return registeredUser;
  }

  Widget futureWidget() {
    return FutureBuilder(
      future: getdata(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.none ||
            snapshot.hasData == null) {
          return Container();
        } else if (registeredUser == null) {
          return Center(
            child: Card(
              child: Text(
                "You are not registered as skilled labour",
                style: TextStyle(color: Colors.red),
              ),
            ),
          );
        } else {
          return ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: new InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => respond_pending_job_requests()),
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
                                        AppLocalizations.of(context).translate(
                                                    "Pending job requests") !=
                                                null
                                            ? AppLocalizations.of(context)
                                                .translate(
                                                    "Pending job requests")
                                            : "Pending job requests",
                                        style:
                                            TextStyle(color: Colors.deepPurple),
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
                      MaterialPageRoute(
                          builder: (context) => accepted_job_requests()),
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
                                        AppLocalizations.of(context).translate(
                                                    "Accepted job requests") !=
                                                null
                                            ? AppLocalizations.of(context)
                                                .translate(
                                                    "Accepted job requests")
                                            : "Accepted job requests",
                                        style:
                                            TextStyle(color: Colors.deepPurple),
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
                      MaterialPageRoute(
                          builder: (context) => rejected_job_requests()),
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
                                        AppLocalizations.of(context).translate(
                                                    "Rejected job requests") !=
                                                null
                                            ? AppLocalizations.of(context)
                                                .translate(
                                                    "Rejected job requests")
                                            : "Rejected job requests",
                                        style:
                                            TextStyle(color: Colors.deepPurple),
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
                      MaterialPageRoute(
                          builder: (context) => completed_job_requests()),
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
                                        AppLocalizations.of(context).translate(
                                                    "Compeleted job requests") !=
                                                null
                                            ? AppLocalizations.of(context)
                                                .translate(
                                                    "Completed job requests")
                                            : "Completed job requests",
                                        style:
                                            TextStyle(color: Colors.deepPurple),
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
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("skilled labour"),
      ),
      body: futureWidget(),
    );
  }
}
