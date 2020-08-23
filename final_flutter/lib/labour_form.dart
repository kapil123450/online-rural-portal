import 'package:flutter/material.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/app_localizations.dart';
import 'package:provider/provider.dart';
import 'screens/AppLanguage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class InputFormForLabour extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return InputFormState();
  }
}

class Item {
  const Item(this.name);
  final String name;
  //final Icon icon;
}

class InputFormState extends State<InputFormForLabour> {
  Item selectedUser;
  List<Item> users = <Item>[
    Item('Android'),
    Item('Flutter'),
    Item('ReactNative'),
    Item('iOS'),
  ];

  String postalcode;
  TextEditingController nameController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController fathernameController = TextEditingController();

  bool validate_name = false;
  bool validate_fatherName = false;
  bool validate_number = false;
  bool validate_pc = true;
  Locale locale;
  SharedPreferences prefs;
  bool isLoading = false;

  FirebaseAuth _auth = FirebaseAuth.instance;
  File imageFile;

  storeData(BuildContext context) async {
    final FirebaseUser currentUser = await _auth.currentUser();
    final QuerySnapshot result = await Firestore.instance
        .collection('skilled_labour')
        .where('phone', isEqualTo: currentUser.phoneNumber)
        .getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    if (documents.length != 0) {
      print("already registered");
      Fluttertoast.showToast(
          msg: "User with given phonenumber Already Registered",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 120,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      setState(() {
        isLoading = true;
      });
      print(currentUser.phoneNumber);
      print("inside data");
      prefs = await SharedPreferences.getInstance();

      print(pincodeController.text);
      prefs.setString('postalcode', pincodeController.text);
      String url = "";

      if (imageFile != null) {
        String fileName = basename(imageFile.path);
        StorageReference reference =
            FirebaseStorage.instance.ref().child(fileName);

        StorageUploadTask uploadTask = reference.putFile(imageFile);

        StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
        url = (await downloadUrl.ref.getDownloadURL());
      }
/////////////////////////////////////////

      Firestore.instance.collection('skilled_labour').document().setData({
        'Name': nameController.text,
        //'Address': first.toString(),
        'phone': currentUser.phoneNumber,
        'Father\'s Name': fathernameController.text,
        'pincode': pincodeController.text,
        'field': selectedUser.name,
        'photoUrl': url != "" ? url : null,
      }).then((data) async {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: "Update success");
      }).catchError((err) {
        setState(() {
          isLoading = false;
        });

        Fluttertoast.showToast(msg: err.toString());
        print(err.toString());
      });
    }
//////////////////////////////////////////////////////////
    print("uploaded");
  }

  _openGallery(BuildContext context) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = image;
      print('Image Path $imageFile');
      //isLoading = true;
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
      //isLoading = true;
    });
    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title:
                  Text(AppLocalizations.of(context).translate("make a choice")),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: Text(
                          AppLocalizations.of(context).translate("gallery")),
                      onTap: () {
                        _openGallery(context);
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                    ),
                    GestureDetector(
                      child: Text(
                          AppLocalizations.of(context).translate("camera")),
                      onTap: () {
                        _openCamera(context);
                      },
                    )
                  ],
                ),
              ));
        });
  }

  Widget _decideImage(BuildContext context) {
    if (imageFile == null) {
      return Center(
        child: Text(AppLocalizations.of(context) != null
            ? AppLocalizations.of(context).translate("No image selected")
            : "No image selected"),
      );
    } else {
      return Image.file(imageFile, width: 100, height: 100);
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF167F67),
        title: Text(
          AppLocalizations.of(context) != null
              ? AppLocalizations.of(context)
                  .translate("Register as a skilled labour")
              : "Register as a skilled labour",
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10),
                  child: TextField(
                    controller: nameController,
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint('Something changed in name field');
                      setState(() {
                        nameController.text.isEmpty
                            ? validate_name = true
                            : validate_name = false;
                      });
                    },
                    decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context).translate("name"),
                        labelStyle: textStyle,
                        errorText: validate_name
                            ? AppLocalizations.of(context)
                                .translate("Value can not be empty")
                            : null,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10),
                  child: TextField(
                    controller: fathernameController,
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint('Something changed in father name field');
                      setState(() {
                        fathernameController.text.isEmpty
                            ? validate_fatherName = true
                            : validate_fatherName = false;
                      });
                    },
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)
                            .translate("father's name"),
                        labelStyle: textStyle,
                        errorText: validate_fatherName
                            ? AppLocalizations.of(context)
                                .translate("Value can not be empty")
                            : null,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10),
                  child: TextField(
                    controller: pincodeController,
                    style: textStyle,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      debugPrint('Something changed in pincode');
                      setState(() {
                        pincodeController.text.isEmpty
                            ? validate_pc = true
                            : validate_pc = false;
                      });
                    },
                    decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context).translate("Pincode"),
                        labelStyle: textStyle,
                        errorText: validate_pc
                            ? AppLocalizations.of(context)
                                .translate("Value can not be empty")
                            : null,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10),
                  child: Center(
                    child: DropdownButton<Item>(
                      hint: Text("Select item"),
                      value: selectedUser,
                      onChanged: (Item data) {
                        setState(() {
                          selectedUser = data;
                        });
                      },
                      items: users.map((Item user) {
                        return DropdownMenuItem<Item>(
                          value: user,
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                user.name,
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    child: new FittedBox(
                      child: Material(
                          color: Colors.white,
                          elevation: 14.0,
                          borderRadius: BorderRadius.circular(24.0),
                          shadowColor: Color(0x802196F3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Builder(
                                builder: (context) => Container(
                                  width: 250,
                                  height: 100,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: _decideImage(context),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RaisedButton(
                    onPressed: () {
                      _showChoiceDialog(context);
                    },
                    child: Text(
                        AppLocalizations.of(context).translate("Select Image")),
                    color: Colors.blue,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            AppLocalizations.of(context).translate('Submit'),
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            if (nameController.text.isNotEmpty &&
                                pincodeController.text.isNotEmpty &&
                                selectedUser != null) {
                              storeData(context);
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Enter all required data");
                            }
                            //Scaffold.of(context).showSnackBar(SnackBar(content: Text('Processing Data')));
                            /* Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LandingScreen()),
                        );*/
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          //////////////////////////////////////////////
          Positioned(
            child: isLoading
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.grey)),
                    ),
                    color: Colors.white.withOpacity(0.8),
                  )
                : Container(),
          ),
          ///////////////////////////////////
        ],
      ),
    );
  }
}
