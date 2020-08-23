import 'package:final_flutter/screens/app_localizations.dart';
import 'package:final_flutter/your_unassigned_jobs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';

class create_new_job extends StatelessWidget {
  TextEditingController problemText = new TextEditingController();

  Future<bool> onSubmit() async {
    SharedPreferences prefs;

    prefs = await SharedPreferences.getInstance();
    Firestore.instance.runTransaction((transaction) async {
      await transaction.set(Firestore.instance.collection("jobs").document(), {
        'phone': prefs.getString('phone'),
        'Name': prefs.getString('name'),
        'postalcode': prefs.getString('postalcode'),
        'problemText': problemText.text,
        'createdAt': DateTime.now().toString(),
        'AssignedToPhone':
            "none", //phone number of user to whoom the job is requested
        'status': "1", //0-->rejected,1-->pending,2-->accepted
      });
    });

    Fluttertoast.showToast(
        msg: "Successfully Created job",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 120,
        textColor: Colors.green,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)
            .translate("Input problem description")),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Center(
            child: Container(
              padding: EdgeInsets.all(30),
              child: new ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 300.0,
                ),
                child: TextField(
                  maxLines: null,
                  controller: problemText,
                  onChanged: (value) => print(problemText.text),
                ),
              ),
            ),
          ),
          new Container(
            padding: const EdgeInsets.all(120),
            child: new RaisedButton(
              child: const Text('Submit'),
              onPressed: () async {
                await onSubmit();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => your_unassigned_jobs()));
              },
            ),
          )
        ],
      ),
    );
  }
}
