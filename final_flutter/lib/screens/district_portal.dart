import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class distric_portal extends StatefulWidget {
  @override
  distric_portal_state createState() => distric_portal_state();
}

class distric_portal_state extends State<distric_portal> {
  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Rupnagar Portal"),
        ),
        body: ListView(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Center(
              child: RaisedButton(
                color: Colors.grey,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => services()),
                  );
                },
                child: const Text("Services"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: RaisedButton(
                color: Colors.grey,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => notifications()),
                  );
                },
                child: const Text("Notifications"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: RaisedButton(
                color: Colors.grey,
                onPressed: () {
                  _launchURL("https://rupnagar.nic.in/public-utilities/");
                },
                child: const Text("public-utilities"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: RaisedButton(
                color: Colors.grey,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => documents()));
                },
                child: const Text("Documents"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: RaisedButton(
                color: Colors.grey,
                onPressed: () {
                  _launchURL("https://rupnagar.nic.in/disaster-management/");
                },
                child: const Text("Disaster Management"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: RaisedButton(
                color: Colors.grey,
                onPressed: () {
                  _launchURL("https://rupnagar.nic.in/rti/");
                },
                child: const Text("Right to Information"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: RaisedButton(
                color: Colors.grey,
                onPressed: () {
                  _launchURL("https://rupnagar.nic.in/helpline/");
                },
                child: const Text("Helplines"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: RaisedButton(
                color: Colors.grey,
                onPressed: () {
                  _launchURL("https://rupnagar.nic.in/");
                },
                child: const Text("More Information"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ));
  }
}

class services extends StatelessWidget {
  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Services"),
      ),
      body: ListView(
        children: <Widget>[
          Center(
            child: RaisedButton(
              color: Colors.grey,
              onPressed: () {
                _launchURL("https://rupnagar.nic.in/service/driving-license/");
              },
              child: const Text("Driving License"),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: RaisedButton(
              color: Colors.grey,
              onPressed: () {
                _launchURL(
                    "https://rupnagar.nic.in/service/property-registration/");
              },
              child: const Text("Property Registration"),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: RaisedButton(
              color: Colors.grey,
              onPressed: () {
                _launchURL(
                    "https://rupnagar.nic.in/service/property-registration/");
              },
              child: const Text("Property Registration"),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: RaisedButton(
              color: Colors.grey,
              onPressed: () {
                _launchURL("https://rupnagar.nic.in/service/e-district-sewa/");
              },
              child: const Text("E-District-Sewa"),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: RaisedButton(
              color: Colors.grey,
              onPressed: () {
                _launchURL("https://rupnagar.nic.in/service/revenue-services/");
              },
              child: const Text("Revenue Services"),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: RaisedButton(
              color: Colors.grey,
              onPressed: () {
                _launchURL(
                    "https://rupnagar.nic.in/service/electricity-bill-payment/");
              },
              child: const Text("Electricity bill"),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: RaisedButton(
              color: Colors.grey,
              onPressed: () {
                _launchURL(
                    "https://rupnagar.nic.in/service/bsnl-landline-mobile-bills/");
              },
              child: const Text("Bsnl Landline/Mobile bills"),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: RaisedButton(
              color: Colors.grey,
              onPressed: () {
                _launchURL("https://rupnagar.nic.in/service/uidai/");
              },
              child: const Text("UIDAI services"),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class notifications extends StatelessWidget {
  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
      ),
      body: ListView(children: <Widget>[
        Center(
          child: RaisedButton(
            color: Colors.grey,
            onPressed: () {
              _launchURL("https://rupnagar.nic.in/notices/events/");
            },
            child: const Text("Events"),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Center(
          child: RaisedButton(
            color: Colors.grey,
            onPressed: () {
              _launchURL("https://rupnagar.nic.in/notices/upcoming-events/");
            },
            child: const Text("Upcoming-Events"),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Center(
          child: RaisedButton(
            color: Colors.grey,
            onPressed: () {
              _launchURL(
                  "https://rupnagar.nic.in/notice_category/announcements/");
            },
            child: const Text("Announcements"),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Center(
          child: RaisedButton(
            color: Colors.grey,
            onPressed: () {
              _launchURL(
                  "https://rupnagar.nic.in/notice_category/recruitment/");
            },
            child: const Text("Recruitments"),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Center(
          child: RaisedButton(
            color: Colors.grey,
            onPressed: () {
              _launchURL("https://rupnagar.nic.in/notice_category/tenders/");
            },
            child: const Text("Tenders"),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ]),
    );
  }
}

class documents extends StatelessWidget {
  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Documents"),
        ),
        body: ListView(children: <Widget>[
          Center(
            child: RaisedButton(
              color: Colors.grey,
              onPressed: () {
                _launchURL(
                    "https://rupnagar.nic.in/document/dapo-registration-form/");
              },
              child: const Text("DAPO Registration Form"),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: RaisedButton(
              color: Colors.grey,
              onPressed: () {
                _launchURL(
                    "https://rupnagar.nic.in/document-category/notification/");
              },
              child: const Text("Notifications related to documents"),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: RaisedButton(
              color: Colors.grey,
              onPressed: () {
                _launchURL(
                    "https://rupnagar.nic.in/document-category/district-profile/");
              },
              child: const Text("District profile"),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ]));
  }
}
