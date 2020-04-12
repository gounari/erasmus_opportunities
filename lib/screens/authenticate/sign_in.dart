import 'package:erasmusopportunities/screens/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_login/flutter_login.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
              Color.fromRGBO(0, 68, 148, 0.3),
                Color.fromRGBO(0, 68, 148, 1.0),
              ]
          )
      ),
      alignment: Alignment(0.0, 0.0),
      child: FlipCard(
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
                '/Users/argyrodevelop/AndroidStudioProjects/erasmus_opportunities/lib/assets/onboarding2.jpg',
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
    );
  }
}
