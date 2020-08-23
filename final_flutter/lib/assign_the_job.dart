import 'package:final_flutter/screens/app_localizations.dart';
import 'package:final_flutter/personal_problem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';

/*
jobs collection -->
        'phone': prefs.getString('phone'),
        'Name': prefs.getString('name'),
        'postalcode': prefs.getString('postalcode'),
        'problemText': problemText.text,
        'createdAt': DateTime.now().toString(),
        'AssignedToPhone':
            "none", //phone number of user to whoom the job is requested
        'status': "1", //0-->rejected,1-->pending,2-->accepted

*/
class assign_the_job extends StatefulWidget {
  final String id;
  assign_the_job(this.id);
  @override
  assign_the_job_state createState() => assign_the_job_state();
}

class assign_the_job_state extends State<assign_the_job> {
  TextEditingController phone = new TextEditingController();
  bool flag;
  String id;
  DocumentSnapshot skilledlabour;
  @override
  void initState() {
    super.initState();
    id = widget.id;
  }

  getInformationAboutPhone() async {
    final QuerySnapshot result = await Firestore.instance
        .collection('skilled_labour')
        .where('phone', isEqualTo: phone.text)
        .getDocuments();
    skilledlabour = null;
    if (result.documents.length != 0) {
      setState(() {
        skilledlabour = result.documents[0];
      });
    } else {
      setState(() {
        skilledlabour = null;
      });
    }

    if (skilledlabour == null) print("no registered");
  }

  Future<bool> storedata() async {
    print(phone.text);
    final QuerySnapshot result = await Firestore.instance
        .collection('skilled_labour')
        .where('phone', isEqualTo: phone.text)
        .getDocuments();
    List<DocumentSnapshot> doc = result.documents;
    if (doc.length == 0) {
      print(false);
      print("incorrect phone number");
      return false;
    }
    Firestore.instance.runTransaction((transaction) async {
      await transaction
          .update(Firestore.instance.collection("jobs").document(id), {
        'AssignedToPhone': phone.text,
        'status': '1',
      });
    });

    Fluttertoast.showToast(
      msg: "Succesfully submitted",
      timeInSecForIosWeb: 20,
      backgroundColor: Colors.green,
    );

    print(true);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: ListView(
        children: <Widget>[
          TextField(
            controller: phone,
            decoration: const InputDecoration(
              icon: const Icon(Icons.message),
              hintText: "Enter number of skilled labour starting with +91",
              labelText: "PhoneNumber",
            ),
            onChanged: (value) {
              getInformationAboutPhone();
            },
          ),
          skilledlabour != null
              ? Card(
                  child: Text("following are the details"),
                )
              : Container(),
          skilledlabour != null
              ? buildItem(context, skilledlabour)
              : Card(
                  child: Text("No labour registered with that number"),
                ),
          skilledlabour != null
              ? RaisedButton(
                  child: Text("Submit the job request"),
                  onPressed: () async {
                    await storedata();
                    Navigator.of(context).pop();
                  },
                )
              : Container(),
        ],
      ),
    );
  }
}
