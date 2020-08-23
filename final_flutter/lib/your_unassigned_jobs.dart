import 'package:final_flutter/display_local_problem.dart';
import 'package:final_flutter/screens/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class your_unassigned_jobs extends StatefulWidget {
  @override
  your_unassigned_jobs_state createState() => your_unassigned_jobs_state();
}

class your_unassigned_jobs_state extends State<your_unassigned_jobs> {
  String phone;
  List<DocumentSnapshot> documents = new List<DocumentSnapshot>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser currentUser;

  Future getData() async {
    FirebaseUser user = await _auth.currentUser();
    setState(() {
      currentUser = user;
    });
    final QuerySnapshot result = await Firestore.instance
        .collection('jobs')
        .where('phone', isEqualTo: currentUser.phoneNumber)
        .where('AssignedToPhone', isEqualTo: "none")
        .getDocuments();
    setState(() {
      documents = result.documents;
    });
    return result.documents;
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
                  print(doc.documentID);
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
        title: Text("Unassigned jobs"),
      ),
      body: documentsWidget(),
    );
  }
}
