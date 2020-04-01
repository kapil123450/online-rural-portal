import 'package:flutter/material.dart';
import 'package:test_app/view_prob.dart';
//import 'form2.dart';
import 'form1.dart';
import 'view_prob.dart';
import 'show_prob.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Navigation Basics',
    home: FirstRoute(),
  ));
}

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen()
    );
  }
}


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text("Welcome"),),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child:new InkWell(
                onTap: () {
                Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => MyApp1()),
                  );
                },
            child: Container(
              child: new FittedBox(
                child: Material(
                    color: Colors.blueGrey,
                    elevation: 14.0,
                    borderRadius: BorderRadius.circular(24.0),
                    shadowColor: Colors.blue,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        
                        Container(
                          width: 250,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Center(
                              child:Text("Register Your problems",
                              style: TextStyle(color: Colors.deepPurple),
                            ),
                            )
                            //child: myDetailsContainer1(),
                          ),
                        ),
                      ],)
                ),
              ),
            ),
          ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child:new InkWell(
                onTap: () {
                Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => MyApp2()),
                  );
                },
            child: Container(
              child: new FittedBox(
                child: Material(
                    color: Colors.blueGrey,
                    elevation: 14.0,
                    borderRadius: BorderRadius.circular(24.0),
                    shadowColor: Colors.blue,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        
                        Container(
                          width: 250,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Center(
                              child:Text("View Your problems",
                              style: TextStyle(color: Colors.deepPurple),
                            ),
                            )
                            //child: myDetailsContainer1(),
                          ),
                        ),
                      ],)
                ),
              ),
            ),
          ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child:new InkWell(
                onTap: () {
                Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => MyApp3()),
                  );
                },
            child: Container(
              child: new FittedBox(
                child: Material(
                    color: Colors.blueGrey,
                    elevation: 14.0,
                    borderRadius: BorderRadius.circular(24.0),
                    shadowColor: Colors.blue,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        
                        Container(
                          width: 250,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Center(
                              child:Text("View ALL problems",
                              style: TextStyle(color: Colors.deepPurple),
                            ),
                            )
                            //child: myDetailsContainer1(),
                          ),
                        ),
                      ],)
                ),
              ),
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
                        Container(
                          width: 250,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            //child: myDetailsContainer1(),
                          ),
                        ),
                       
                      ],)
                ),
              ),
            ),
          ),


        ],
      ),
    );
  }
}


class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}