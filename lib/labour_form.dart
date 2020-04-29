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


class InputForm extends StatefulWidget {
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

class InputFormState extends State<InputForm> {

  Item selectedUser;
  List<Item> users = <Item>[
    Item('Android'),
    Item('Flutter'),
    Item('ReactNative'),
    Item('iOS'),
  ];
  
  String postalcode ;
  TextEditingController nameController = TextEditingController();
  TextEditingController pincodeController= TextEditingController();
  TextEditingController numberController =
      TextEditingController();
  TextEditingController fathernameController =
      TextEditingController();
  
  bool validate_name = false;
  bool validate_fatherName = false;
  bool validate_number = false;
  bool validate_pc = true;
  Locale locale;
  SharedPreferences prefs;
  bool isLoading = false;
 /*  addStringToSF(phone) async {
  print(phone);
  prefs = await SharedPreferences.getInstance();
  prefs.setString('stringValue', phone);
  } */
 
  FirebaseAuth _auth = FirebaseAuth.instance;
  File imageFile;
  

  storeData(BuildContext context) async{

     setState(() {
      isLoading = true;
    });

    final FirebaseUser currentUser = await _auth.currentUser();
    print(currentUser.phoneNumber);
    print("inside data");
    prefs = await SharedPreferences.getInstance();
    
    print(pincodeController.text);
    prefs.setString('postalcode', pincodeController.text);
    String url = "";

    if (imageFile !=null){
    String fileName = basename(imageFile.path);
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    
    StorageUploadTask uploadTask = reference.putFile(imageFile);
    

    StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    url = (await downloadUrl.ref.getDownloadURL());
    }
/////////////////////////////////////////
     

    Firestore.instance.collection('skilled_labour').document().setData({
          'Name': nameController.text,
          //'Address': first.toString(),
          'phone': numberController.text,
          'Father\'s Name': fathernameController.text,
          'pincode': pincodeController.text,
          'field': selectedUser.name,
          'photoUrl': url != "" ? url :null,
        }).then((data) async{
          
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
//////////////////////////////////////////////////////////
      print("uploaded");
  }

  

  _openGallery(BuildContext context)async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = image;
      print('Image Path $imageFile');
      //isLoading = true;
    });
    Navigator.of(context).pop();
  }
  
  _openCamera(BuildContext context)async{
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
      //isLoading = true;
    });
    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialog(BuildContext context){
    return showDialog(context: context,builder: (BuildContext context){
        return AlertDialog(
          title: Text("Make a choice"),
          content: SingleChildScrollView(
            child: ListBody(children: <Widget>[
              GestureDetector(
                child: Text("gallery"),
                onTap: (){
                  _openGallery(context);
                },
              ),
              Padding(padding: EdgeInsets.all(8.0),),

              GestureDetector(
                child: Text("Camera"),
                onTap: (){
                  _openCamera(context);
                },
              )
            ],),
          )
        ) ;   
    });
  }
   
 Widget _decideImage(){
   if(imageFile == null){
     return Center(
       child: Text("No Image Selected"),
     );
     
   }else
   {
   return  Image.file(imageFile,width:100,height:100);
   } 
 }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF167F67),
        title: Text('Skilled Labour Registration'),centerTitle: true,
        ),
      body:  Stack(
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
                    labelText: "name",
                    labelStyle: textStyle,
                    errorText: validate_name ? 'Value can\'nt be empty' : null,
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
                  debugPrint('Something changed in number field');
                  setState(() {
                    fathernameController.text.isEmpty
                        ? validate_fatherName = true
                        : validate_fatherName = false;
                  });
                },
                decoration: InputDecoration(
                    labelText: "father's name",
                    labelStyle: textStyle,
                    errorText:
                        validate_fatherName ? 'Value can\'nt be empty' : null,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10),
              child: TextField(
                controller: numberController,
                style: textStyle,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  debugPrint('Something changed in number field');
                  setState(() {
                    numberController.text.isEmpty
                        ? validate_number = true
                        : validate_number = false;
                  });
                /* if (numberController.text.isNotEmpty) {
                  
                  addStringToSF(numberController.text);
                } */
                },
                decoration: InputDecoration(
                    labelText: "Mobile Number",
                    labelStyle: textStyle,
                    errorText:
                        validate_number ? 'Value can\'nt be empty' : null,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10),
              child: TextField(
                controller: numberController,
                style: textStyle,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  debugPrint('Something changed in number field');
                },
                decoration: InputDecoration(
                    labelText: "Mobile Number2",
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
           
            Padding(
              padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10),
              child: TextField(
                controller: pincodeController,
                style: textStyle,
                autocorrect: true,
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
                    labelText: "Pincode",
                    labelStyle: textStyle,
                    
                    errorText: pincodeController.text.isEmpty ? 'value can\'t be empty ' :'',
                        
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10),
            child:Center(
                child: DropdownButton<Item>(
            hint:  Text("Select item"),
            value: selectedUser,
            onChanged: (Item data) {
              setState(() {
                selectedUser = data;
              });
            },
            items: users.map((Item user) {
              return  DropdownMenuItem<Item>(
                value: user,
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 10,),
                    Text(
                      user.name,
                      style:  TextStyle(color: Colors.black),
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
                        builder: (context) =>  Container(
                          width: 250,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                                    child:  _decideImage(),
                                  ),
                                ),
                                ),  
                              ],)
                        ),
                      ),
                    ),
                  ),
                
                Padding(
                  padding: const EdgeInsets.all(16.0),
                        child: RaisedButton(onPressed: (){
                            _showChoiceDialog(context);
                          },child: Text("Select Image"),
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
                        'Submit',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                      
                        if(nameController.text.isNotEmpty && pincodeController.text.isNotEmpty &&  selectedUser !=null){
                        storeData(context);
                        }
                        else
                        {
                          Fluttertoast.showToast(msg: "Enter all required data");
                        }
                        //Scaffold.of(context).showSnackBar(SnackBar(content: Text('Processing Data')));
                       /* Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LandingScreen()),
                        );*/
                        
                      },
                    ),
                  ),
                  Container(width: 5.0),
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Back',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          debugPrint("Back button pressed");
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    Provider.of<AppLanguage>(context, listen: false)
                        .changeLanguage(Locale("en"));
                  },
                  child: Text('English'),
                ),
                RaisedButton(
                  onPressed: () {
                    debugPrint('hindi');
                    Provider.of<AppLanguage>(context, listen: false)
                        .changeLanguage(Locale("hi"));
                  },
                  child: Text('हिंदी'),
                )
              ],
            ),
          ],
        ),
       ),

      //////////////////////////////////////////////
                 Positioned(
                    child: isLoading
                        ? Container(
                            child: Center(
                              child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.grey)),
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
