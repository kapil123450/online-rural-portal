import 'package:flutter/material.dart';
import 'package:test_app/view_prob.dart';
//import 'form2.dart';
import 'form1.dart';
import 'view_prob.dart';
import 'show_prob.dart';
import 'labour_form.dart';
import 'personal_problem.dart';
import 'settings.dart';

/*void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Navigation Basics',
    home: FirstRoute(),
  ));
}*/


class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen()
    );
  }
}


class HomeScreen extends StatelessWidget {

/////////////////////////////////////////////////////

//////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text("Welcome"),centerTitle: true,
      ),
      drawer: Container(
        width: 200,
        height: 240,
      child: Theme(
           data: Theme.of(context).copyWith(
                 canvasColor: Colors.blueGrey,  //This will change the drawer background to blue.
              ),
     child: Drawer(
        child: ListView(
          children: <Widget>[
             Padding(
              padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10),
              child: Center(
                child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'settings',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Settings()),
                        );
                        
                      },
                    ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10),
              child: Center(
                child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Log out',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Displaypeople()),
                        );
                        
                      },
                    ),
              ),
            ),
           ],
          ),
        ),
      ),
      ),
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
              //decoration: BoxDecoration(shape: BoxShape.circle),
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
            child:new InkWell(
                onTap: () {
                Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => InputForm()),
                  );
                },
            child: Container(
              //decoration: BoxDecoration(shape: BoxShape.circle),
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
                              child:Text("Labour Registration",
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
                 MaterialPageRoute(builder: (context) => DropdownScreen()),
                  );
                },
            child: Container(
              //decoration: BoxDecoration(shape: BoxShape.circle),
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
                              child:Text("Personal Problem",
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