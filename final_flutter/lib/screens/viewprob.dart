import 'package:flutter/material.dart';

import 'reasonwise2.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'app_localizations.dart';

class yourProblems extends StatefulWidget {
  final String title = "Enter Your phone number";
  @override
  yourProblemsState createState() => new yourProblemsState();
}

class yourProblemsState extends State<yourProblems> {
  String image = '';
  String videoFile = '';
  String problem = '';

  List<DocumentSnapshot> documents = [];

  final _phone = TextEditingController();

  SharedPreferences prefs;

  onsubmit() async {
    print(_phone.text);
    final QuerySnapshot result = await Firestore.instance
        .collection('form')
        .where('phone', isEqualTo: _phone.text)
        .getDocuments();
    final List<DocumentSnapshot> documents1 = result.documents;
    List<DocumentSnapshot> documents2 = [];
    print(documents1);
    for (int i = 0; i < documents1.length; i++) {
      if (documents1[i]['phone'] == _phone.text) {
        documents2.add(documents1[i]);
      }
    }
    setState(() {
      documents = documents2;
      print(documents);
    });
    print('AMAN');
    print(image);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(AppLocalizations.of(context).translate(widget.title)),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: <Widget>[
          new TextFormField(
            controller: _phone,
            decoration: const InputDecoration(
              icon: const Icon(Icons.phone),
              hintText: 'Enter your phone number',
              labelText: 'Phone',
            ),
            /*onChanged: (value) {
                          //phone1 = value ;
                          //phone = phone1.toString();
                          //phone = value;
                        },*/
          ),
          new Container(
              padding: const EdgeInsets.only(left: 40.0, top: 20.0),
              child: new RaisedButton(
                  child: const Text('Submit'),
                  onPressed: () async {
                    await onsubmit();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => displayProblems(),
                            // Pass the arguments as part of the RouteSettings. The
                            // DetailScreen reads the arguments from these settings.
                            settings: RouteSettings(
                              arguments: documents,
                            )));
                  })),
        ],
      ),
    );
  }
}
