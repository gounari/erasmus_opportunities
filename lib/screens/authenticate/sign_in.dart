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
              front: Stack(
                children: <Widget>[
                  Card(
                    elevation: 10.0,
                    color: Color.fromRGBO(231, 236, 239, 1.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width/2.2,
                          height: MediaQuery.of(context).size.height,
                          child: Image.asset(
                            '/Users/argyrodevelop/AndroidStudioProjects/erasmus_opportunities/lib/assets/onboarding4.jpg',
                            fit: BoxFit.fill,
                          ),
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: MediaQuery.of(context).size.width/3,
                              height: MediaQuery.of(context).size.height/5,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Text(
                                  'Welcome back!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width/3,
                              height: MediaQuery.of(context).size.height/5,
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Text(
                                  'Time to post amazing \n opportunities.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width/2.2,
                              height: MediaQuery.of(context).size.width/9,
                            ),
                            FlatButton(
                              padding: EdgeInsets.fromLTRB(
                                  MediaQuery.of(context).size.width/15,
                                  0.0,
                                  MediaQuery.of(context).size.width/15,
                                  0.0),
                              color: Colors.black54,
                              splashColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.black,
                                  width: 0.0,
                                  style: BorderStyle.solid
                                ),
                                borderRadius: BorderRadius.circular(40)
                              ),
                              onPressed: () {},
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width/10,
                                height: MediaQuery.of(context).size.height/10,
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Text(
                                    'SIGN UP',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ],
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
                    '/Users/argyrodevelop/AndroidStudioProjects/erasmus_opportunities/lib/assets/onboarding2.jpg',
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
