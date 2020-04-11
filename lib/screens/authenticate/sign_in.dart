import 'package:erasmusopportunities/screens/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(231, 236, 239, 1.0),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(30.0),
          scrollDirection: Axis.horizontal,
          children: <Widget>[

            FlipCard(
              front: Card(
                elevation: 10.0,
                color: Color.fromRGBO(231, 236, 239, 1.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width/2.2,
                  height: MediaQuery.of(context).size.height,
                  child: Image.asset(
                    '/Users/argyrodevelop/AndroidStudioProjects/erasmus_opportunities/lib/assets/shapes1.jpg',
                    fit: BoxFit.none,
                    color: Colors.black,
                    colorBlendMode: BlendMode.plus,
                  ),
                ),
              ),
              back: Container(
                child: Text('Back'),
              ),
            ),

            SizedBox(width: 30.0,),

            FlipCard(
              front: Container(
                child: Text('Front'),
              ),
              back: Card(
                elevation: 10.0,
                color: Color.fromRGBO(231, 236, 239, 1.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width/2.2,
                  height: MediaQuery.of(context).size.height,
                  child: Image.asset(
                    '/Users/argyrodevelop/AndroidStudioProjects/erasmus_opportunities/lib/assets/shapes2.jpg',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
