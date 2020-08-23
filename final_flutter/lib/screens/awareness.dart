import 'package:final_flutter/screens/district_portal.dart';
import 'package:flutter/material.dart';
import 'pg1.dart';
import 'pg2.dart';
import 'pg3.dart';
import 'pg4.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(
          'POSSIBLE PROBLEMS',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[700],
        elevation: 0.0,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Pg1()),
                );
              },
              child: Text(
                'COVID-19',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 28.0,
                ),
              ),
              color: Colors.amber,
              padding: EdgeInsets.all(40.0),
            ),
          ),
          Divider(
            color: Colors.grey[800],
            height: 5.0,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Pg2()),
                );
              },
              child: Text(
                'CRIME',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 28.0,
                ),
              ),
              color: Colors.amber,
              padding: EdgeInsets.all(40.0),
            ),
          ),
          Divider(
            color: Colors.grey[800],
            height: 5.0,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Pg3()),
                );
              },
              child: Text(
                'ELECTRICITY',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 28.0,
                ),
              ),
              color: Colors.amber,
              padding: EdgeInsets.all(40.0),
            ),
          ),
          Divider(
            color: Colors.grey[800],
            height: 5.0,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Pg4()),
                );
              },
              child: Text(
                'HEALTH',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 28.0,
                ),
              ),
              color: Colors.amber,
              padding: EdgeInsets.all(40.0),
            ),
          ),
          Divider(
            color: Colors.grey[800],
            height: 5.0,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => distric_portal()),
                );
              },
              child: Text(
                'Goverment Services and notices',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 28.0,
                ),
              ),
              color: Colors.amber,
              padding: EdgeInsets.all(40.0),
            ),
          ),
        ],
      ),
    );
  }
}
