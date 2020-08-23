import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'app_localizations.dart';
import 'reasonwise3.dart';

class displayProblems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<DocumentSnapshot> documents =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context).translate("All the problems")),
      ),
      body: documents.length > 0
          ? ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                return Card(
                  child: InkWell(
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      color: Colors.blue[600],
                      child: Text(Text(AppLocalizations.of(context)
                                  .translate("name"))
                              .data +
                          "       :  " +
                          documents[index]['Name'] +
                          "\n" +
                          Text(AppLocalizations.of(context)
                                  .translate("Problem Description"))
                              .data +
                          "       :  " +
                          documents[index]['problemText'] +
                          '\n' +
                          Text(AppLocalizations.of(context).translate("Date"))
                              .data +
                          "       :  " +
                          documents[index]['createdAt'] +
                          '\n' +
                          Text(AppLocalizations.of(context)
                                  .translate("Mobile Number"))
                              .data +
                          "       :  " +
                          documents[index]['phone']),
                    ),
                    onTap: () {
                      print("tapped");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => detailProblem(),
                          // Pass the arguments as part of the RouteSettings. The
                          // DetailScreen reads the arguments from these settings.
                          settings: RouteSettings(
                            arguments: documents[index],
                          ),
                        ),
                      );
                    },
                  ),
                );
              })
          : Center(
              child: Text("empty"),
            ),
    );
  }
}
