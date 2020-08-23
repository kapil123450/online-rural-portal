import 'package:final_flutter/assign_the_job.dart';
import 'package:final_flutter/personal_problem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

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
class display_local_problem extends StatefulWidget {
  String id;
  display_local_problem(this.id);
  @override
  display_local_problem_state createState() =>
      new display_local_problem_state();
}

class display_local_problem_state extends State<display_local_problem> {
  String id;
  DocumentSnapshot wasAssignedTo;
  String yourphone = "826495947";
  TextEditingController comment = new TextEditingController()..text = "ok";
  bool isSolver;
  bool ispendingJob;
  bool isrejectedjob;
  bool isacceptedjob;
  bool isunassigned;
  bool iscompleted;
  FirebaseUser currentUser;
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    id = widget.id;
    wasAssignedTo = null;
    isSolver = false;
    ispendingJob = false;
    isrejectedjob = false;

    isacceptedjob = false;
    isunassigned = false;
    iscompleted = false;
  }

  Future getData() async {
    FirebaseUser tmp = await _auth.currentUser();
    setState(() {
      currentUser = tmp;
    });
    print(currentUser.phoneNumber);
    final DocumentReference result =
        await Firestore.instance.collection('jobs').document(id);
    print(id);
    if (result != null) print(">1");
    print(result.documentID);
    DocumentSnapshot fr = await result.get();

    if (currentUser.phoneNumber == fr['AssignedToPhone']) {
      setState(() {
        isSolver = true;
      });
      return fr;
    }
    if (fr['AssignedToPhone'] == "none") {
      setState(() {
        isunassigned = true;
      });
    } else if (fr['AssignedToPhone'] != "none" && fr["status"] == '0') {
      setState(() {
        isrejectedjob = true;
      });
    } else if (fr['AssignedToPhone'] != "none" && fr['status'] == '1') {
      setState(() {
        ispendingJob = true;
      });
    } else if (fr['AssignedToPhone'] != "none" && fr['status'] == '2') {
      setState(() {
        isacceptedjob = true;
      });
    }
    if (fr['status'] == "3") {
      setState(() {
        iscompleted = true;
      });
    }

    return fr;
  }

  getDetailoflabour(String phone) async {
    print("inside getdetail function");
    final QuerySnapshot result = await Firestore.instance
        .collection('skilled_labour')
        .where('phone', isEqualTo: phone)
        .getDocuments();

    if (result.documents.length != 0) {
      setState(() {
        wasAssignedTo = result.documents[0];
      });
    } else {
      setState(() {
        wasAssignedTo = null;
      });
    }
  }

  acceptRequest() async {
    Firestore.instance.runTransaction((transaction) async {
      await transaction
          .update(Firestore.instance.collection("jobs").document(id), {
        'status': '2',
        'comment': comment.text,
      });
    });
    Fluttertoast.showToast(
      msg: "Accepted",
      timeInSecForIosWeb: 20,
      backgroundColor: Colors.green,
    );
  }

  rejectRequest() async {
    Firestore.instance.runTransaction((transaction) async {
      await transaction
          .update(Firestore.instance.collection("jobs").document(id), {
        'status': '0',
        'comment': comment.text,
      });
    });
    Fluttertoast.showToast(
      msg: "Rejected",
      timeInSecForIosWeb: 20,
      backgroundColor: Colors.red,
    );
  }

  complete() async {
    Firestore.instance.runTransaction((transaction) async {
      await transaction
          .update(Firestore.instance.collection("jobs").document(id), {
        'status': '3',
      });
    });
    Fluttertoast.showToast(
      msg: "Done",
      timeInSecForIosWeb: 20,
      backgroundColor: Colors.green,
    );
  }

  Widget DisplayProblem() {
    return FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot doc) {
          if (doc.data == null)
            return Container();
          else {
            return Scaffold(
              body: ListView(
                children: <Widget>[
                  Flexible(
                    child: Card(
                      child: Text("************PROBLEM DESCRIPTION***********" +
                          '\n' +
                          doc.data['problemText']),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Flexible(
                    child: Card(
                      child: Text("Submitted By " +
                          doc.data['Name'] +
                          "\n" +
                          "Phone number " +
                          doc.data['phone'] +
                          "\n" +
                          "Postal Code " +
                          doc.data['postalcode'] +
                          "\nTime of submission " +
                          doc.data['createdAt']),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  isunassigned
                      ? Flexible(
                          child: Card(
                            child: Text("Your job is unassigned"),
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 10,
                  ),
                  isunassigned
                      ? RaisedButton(
                          color: Colors.red,
                          child: Text("Assign"),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => assign_the_job(id)));
                          },
                        )
                      : Container(),
                  isrejectedjob
                      ? Flexible(
                          child: InkWell(
                            child: Text(
                                "Your job request is rejected tap for details"),
                            onTap: () {
                              getDetailoflabour(doc.data['AssignedToPhone']);
                            },
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 10,
                  ),
                  isrejectedjob
                      ? RaisedButton(
                          color: Colors.red,
                          child: Container(
                              child: Text("ReAssign"),
                              alignment: Alignment.center),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => assign_the_job(id)));
                          },
                        )
                      : Container(),
                  ispendingJob
                      ? Flexible(
                          child: InkWell(
                            child: Text(
                                "Your job request is pending tap for details"),
                            onTap: () {
                              getDetailoflabour(doc.data['AssignedToPhone']);
                            },
                          ),
                        )
                      : Container(),
                  wasAssignedTo != null
                      ? buildItem(context, wasAssignedTo)
                      : Container(),
                  SizedBox(
                    height: 20,
                  ),
                  isrejectedjob || isacceptedjob
                      ? Card(
                          child:
                              Text("comment provided\n" + doc.data['comment']),
                        )
                      : Container(),
                  isacceptedjob
                      ? Card(
                          child: Text(
                              "your job request is accepted by labour " +
                                  "\nhis phone number is : " +
                                  doc.data['AssignedToPhone']),
                        )
                      : Container(),
                  isacceptedjob
                      ? Container(
                          child: RaisedButton(
                              color: Colors.green,
                              child: Text("Mark as complete"),
                              onPressed: () {
                                complete();
                                Navigator.of(context).pop();
                              },
                              splashColor: Colors.blue),
                          padding: EdgeInsets.all(100),
                        )
                      : Container(),
                  SizedBox(
                    height: 10,
                  ),
                  isSolver
                      ? Container(
                          padding: EdgeInsets.all(30),
                          child: new ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: 300.0,
                            ),
                            child: TextField(
                              maxLines: null,
                              controller: comment,
                              decoration:
                                  const InputDecoration(labelText: "Comment"),
                            ),
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 30,
                  ),
                  iscompleted
                      ? Container(
                          padding: EdgeInsets.all(40),
                          color: Colors.green,
                          child: Text("JOB COMPLETED !!"))
                      : Container(),
                  isSolver
                      ? Card(
                          child: Row(
                            children: <Widget>[
                              RaisedButton(
                                onPressed: () {
                                  acceptRequest();
                                  Navigator.of(context).pop();
                                },
                                color: Colors.green,
                                child: Text(
                                  "Accept",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 160,
                              ),
                              RaisedButton(
                                onPressed: () {
                                  rejectRequest();
                                  Navigator.of(context).pop();
                                },
                                color: Colors.red,
                                child: Text(
                                  "Reject",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                ],
              ),
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(""),
      ),
      body: DisplayProblem(),
    );
  }
}
