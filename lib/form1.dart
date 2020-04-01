import 'dart:ffi';
//import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';
import 'package:flutter/services.dart';

import 'form2.dart';
//void main() => runApp(new MyApp1());

class MyApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Form Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Form Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  List<String> _colors = <String>['', 'red', 'green', 'blue', 'orange'];
  String _color = '';

  final _name = TextEditingController();
  final _fName = TextEditingController();
  final _phone = TextEditingController();

  SharedPreferences prefs;
  getUserLocation() async {//call this async method from whereever you need

      LocationData myLocation;
      String error;
      Location location = new Location();
      try {
        myLocation = await location.getLocation();
      } on PlatformException catch (e) {
        if (e.code == 'PERMISSION_DENIED') {
          error = 'please grant permission';
          print(error);
        }
        if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
          error = 'permission denied- please enable it from app settings';
          print(error);
        }
        myLocation = null;
      }
      //currentLocation = myLocation;
      final coordinates = new Coordinates(
          myLocation.latitude, myLocation.longitude);
      var addresses = await Geocoder.local.findAddressesFromCoordinates(
          coordinates);
      var first = addresses.first;
     // print(' ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');
      return first;
    }
  
  onsubmit() async {
    //print()
    var first = getUserLocation;
    String add = first.toString();
    print(add);
    prefs = await SharedPreferences.getInstance();
    final QuerySnapshot result =
        await Firestore.instance.collection('form').where('phone', isEqualTo: _phone.text).getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      if (documents.length == 0) {
      // Update data to server if new user
        Firestore.instance.collection('form').document(_phone.text).setData({
          'Name': _name.text,
          'Address': first.toString(),
          'phone': _phone.text,
          'createdAt': DateTime.now().toString(),
        });

        // Write data to local
        //currentUser = firebaseUser;
        await prefs.setString('phone', _phone.text);
        await prefs.setString('Name', _name.text);
        //await prefs.setString('photoUrl', null);
      } else {
        // Write data to local
        Firestore.instance.collection('form').document(_phone.text).updateData({
          'Name': _name.text,
          'Address': add,
          //'phone': _phone.text,
          'createdAt': DateTime.now().toString(),
        });
        await prefs.setString('phone', documents[0]['phone']);
        await prefs.setString('Name', documents[0]['Name']);
        //await prefs.setString('photoUrl', documents[0]['photoUrl']);
        //await prefs.setString('aboutMe', documents[0]['aboutMe']);
      }
  
}


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new SafeArea(
          top: false,
          bottom: false,
          child: new Form(
              key: _formKey,
              autovalidate: true,
              child: new ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  new TextField(
                    controller: _name ,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.person),
                      hintText: 'Enter your first and last name',
                      labelText: 'Name',
                    ),
                    /*onChanged: (value) {
                          name = value;
                        },*/
                  ),
                  new TextField(
                    controller: _fName ,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.person),
                      hintText: 'Enter your fathers name',
                      labelText: 'Fathers Name',
                    ),
                    
                    /*onChanged: (value) {
                          fName = value;
                        },*/
                  ),
                  new TextFormField(
                    controller: _phone ,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.phone),
                      hintText: 'Enter a phone number',
                      labelText: 'Phone',
                    ),
                    /*onChanged: (value) {
                          //phone1 = value ;
                          //phone = phone1.toString();
                          //phone = value;
                        },*/
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.email),
                      hintText: 'Enter a email address',
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  new Container(
                      padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                      child: new RaisedButton(
                        child: const Text('Submit'),
                         onPressed: (){
                           onsubmit();
                           Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LandingScreen()),
                            );
                         }
                      )),
                ],
              ))),
    );
  }

}