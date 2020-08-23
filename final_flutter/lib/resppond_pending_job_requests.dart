import 'package:final_flutter/display_local_problem.dart';
import 'package:final_flutter/screens/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class respond_pending_job_requests extends StatefulWidget {
  @override
  respond_pending_job_requests_state createState() =>
      new respond_pending_job_requests_state();
}

class respond_pending_job_requests_state
    extends State<respond_pending_job_requests> {
  String phone = "8264959487";
  List<DocumentSnapshot> documents = new List<DocumentSnapshot>();

  Future getData() async {
    FirebaseUser cu = await FirebaseAuth.instance.currentUser();
    setState(() {
      phone = cu.phoneNumber;
    });
    final QuerySnapshot result = await Firestore.instance
        .collection('jobs')
        .where('AssignedToPhone', isEqualTo: phone)
        .getDocuments();

    List<DocumentSnapshot> docs = result.documents;
    documents = [];

    print(docs.length);
    setState(() {
      for (var i = 0; i < docs.length; i++) {
        if (docs[i]['status'] == "1") documents.add(docs[i]);
      }
    });
    print(documents.length);
    return documents;
  }

  Widget documentsWidget() {
    return FutureBuilder(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.none ||
            snapshot.data == null ||
            snapshot.data.length == 0) {
          return Center(
            child: Container(
              child: Text("No requests"),
            ),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            DocumentSnapshot doc = snapshot.data[index];
            return Card(
              child: InkWell(
                splashColor: Colors.blue,
                onTap: () {
                  print("doc id is ------>  " + doc.documentID);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              display_local_problem(doc.documentID)));
                },
                child: Container(
                  color: Colors.blue[600],
                  width: 300,
                  height: 100,
                  child: Text("************PROBLEM DESCRIPTION***********" +
                      '\n\n' +
                      doc['problemText']),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Pending Job Requests"),
      ),
      body: documentsWidget(),
    );
  }
}