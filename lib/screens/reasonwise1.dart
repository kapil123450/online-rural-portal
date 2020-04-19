import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/screens/reasonwise2.dart';
import 'app_localizations.dart';
import 'package:flutter_app/screens/app_localizations.dart';
class reagonwise extends StatefulWidget 
{
@override
reagionwiseState createState() => reagionwiseState();
}


class reagionwiseState extends State<reagonwise>{
 
  var item_count  = 0;
  
  Map<String,List<DocumentSnapshot>> documents_map = new Map<String,List<DocumentSnapshot>>();
List<String> postal_code = [];

Future<String> getDocuments() async{
  Map<String,List<DocumentSnapshot>> documents_map1 = new Map<String,List<DocumentSnapshot>>();
  List<String> postal_code1 = [];

  print("1...getdoc");
  documents_map.clear();
  
  final QuerySnapshot result =
        await Firestore.instance.collection('form').getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
  //var p = documents.length;
  print("2... length ");
  for (int i=0;i<documents.length;i++)
  {
    documents_map1[documents[i]['postalcode']] = [];
  }
  
  for (var i= 0;i<documents.length;i++)
  {
    print(documents[i]['postalcode']);
    
    bool fg = true;
    //documents_map[documents[i]['postalcode']].add(documents[i]);
    print("axcha");
    documents_map1[documents[i]['postalcode']].add(documents[i]);
    if(postal_code1!=null){
      for(var i1 =0 ;i1<postal_code1.length;i1++)
      {
        if(postal_code1[i1]==documents[i]['postalcode'])
          fg = false;
      }
    }
    if (fg) postal_code1.add(documents[i]['postalcode']);
  }
  
  setState(() {
    documents_map = documents_map1;
    postal_code = postal_code1;
  });
  for(var i= 0;i<postal_code.length;i++)
  {
    print(postal_code[i]+" ");
    print(documents_map[postal_code[i]]);
  }
  print("3...");
  return "done";

}
  
  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context).translate("District Problems"))!=null?Text(AppLocalizations.of(context).translate("District Problems")):Text("District Problems"),
        ),
      body:
      postal_code.length>0?new ListView.builder(
        
        itemCount : postal_code.length,
        itemBuilder: (context,index){
          return 
            Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  print('Card tapped.');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => displayProblems(),
                      // Pass the arguments as part of the RouteSettings. The
                      // DetailScreen reads the arguments from these settings.
                      settings: RouteSettings(
                        arguments: documents_map[postal_code[index]],
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 300,
                  height: 100,
                  child: Text("view the problems of district with postal code : \n\n\n            " + postal_code[index]),
                ),
              ),
              
          );
        },

      ):Text("Nothing"),
      floatingActionButton: FloatingActionButton(
      onPressed: () async{
        print("inside onpresssed");
        var x = await getDocuments();
      },
      child: Icon(Icons.refresh),
      backgroundColor: Colors.green,
    ),
    );
  }
  

}
