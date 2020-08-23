import 'package:final_flutter/assigned_job_requests.dart';
import 'package:final_flutter/input_form_for_loc_port.dart';
import 'package:final_flutter/personal_problem.dart';
import 'package:final_flutter/solve_local_problems.dart';
import 'package:final_flutter/your_unassigned_jobs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:final_flutter/screens/app_localizations.dart';

import 'labour_form.dart';
import 'package:final_flutter/create_new_job.dart';

class local_portal_screen1 extends StatelessWidget {
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
                                    "Search for skilled labour",
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
                  MaterialPageRoute(builder: (context) => InputFormForLoc()),
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
                                    AppLocalizations.of(context)
                                                .translate("Create new job") !=
                                            null
                                        ? AppLocalizations.of(context)
                                            .translate("Create new job")
                                        : "Create new job",
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
                  MaterialPageRoute(
                      builder: (context) => your_unassigned_jobs()),
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
                                                "Your unassigned jobs") !=
                                            null
                                        ? AppLocalizations.of(context)
                                            .translate("Create new job")
                                        : "Your unassigned jobs",
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
                  MaterialPageRoute(
                      builder: (context) => assigned_job_requests()),
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
                                                "Your assigned job requests") !=
                                            null
                                        ? AppLocalizations.of(context)
                                            .translate("Create new job")
                                        : "Your assigned jobs requests",
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
                  MaterialPageRoute(
                      builder: (context) => solve_local_problems()),
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
                                                "Your assigned job requests") !=
                                            null
                                        ? AppLocalizations.of(context)
                                            .translate("Create new job")
                                        : "Skilled labour",
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
