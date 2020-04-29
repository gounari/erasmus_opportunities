import 'package:erasmusopportunities/screens/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'opportunity_form.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthService _auth = AuthService();
  int _count = 0;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 68, 148, 1),
      appBar: AppBar(
        title: Image.asset('images/logo.png', fit: BoxFit.contain, height: 50),
        backgroundColor: Colors.white,
        elevation: 10.0,
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(
                Icons.exit_to_app,
                color: Color.fromRGBO(0, 68, 148, 1),
              ),
              label: Text(''),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            _count += 1;
          });
        },
        icon: Icon(Icons.refresh),
        label: Text("Reset"),
        foregroundColor: Colors.black,
        backgroundColor: Colors.yellowAccent,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child:  AnimatedSwitcher(
              duration: Duration(milliseconds: 0),
              child: OpportunityCard(
                // This key causes the AnimatedSwitcher to interpret this as a "new"
                // child each time the count changes, so that it will begin its animation
                // when the count changes.
                key: ValueKey<int>(_count),
                auth: _auth,
              ),
            ),
          ),
        ),
      ),
    );
  }
}


