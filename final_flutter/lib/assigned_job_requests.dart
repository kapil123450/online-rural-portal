import 'package:final_flutter/display_local_problem.dart';
import 'package:final_flutter/screens/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class assigned_job_requests extends StatefulWidget {
  @override
  your_assigned_jobs_state createState() => your_assigned_jobs_state();
}

class your_assigned_jobs_state extends State<assigned_job_requests> {
  String phone = "+916388664668";
  List<DocumentSnapshot> documents = new List<DocumentSnapshot>();

  Future getData() async {
    FirebaseUser cu = await FirebaseAuth.instance.currentUser();
    setState(() {
      phone = cu.phoneNumber;
    });
    final QuerySnapshot result = await Firestore.instance
        .collection('jobs')
        .where('phone', isEqualTo: phone)
        .getDocuments();

    List<DocumentSnapshot> docs = result.documents;
    documents = [];

    setState(() {
      for (var i = 0; i < docs.length; i++) {
        if (docs[i]['AssignedToPhone'] != "none") documents.add(docs[i]);
      }
    });
    return documents;
  }

  Widget documentsWidget() {
    return FutureBuilder(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.none ||
            snapshot.data == null) {
          return Container();
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
        title: Text("assigned jobs"),
      ),
      body: documentsWidget(),
    );
  }
}
