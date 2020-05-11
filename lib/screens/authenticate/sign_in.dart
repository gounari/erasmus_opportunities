import 'package:erasmusopportunities/screens/home/home.dart';
import 'package:erasmusopportunities/screens/services/auth.dart';
import 'package:erasmusopportunities/onboarding/models/signup_data.dart';
import 'package:flutter/material.dart';
import 'package:erasmusopportunities/onboarding/flutter_login.dart';

class Onboarding extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  final AuthService _auth = AuthService();

  Future<String> _signInUser(LoginData data) {
    return Future.delayed(loginTime).then((_) async {

      dynamic user = await _auth.signInWithEmailAndPassword(data.email, data.password);
      if (user == null) {
        return 'Error signing in';
      }

      return null;
    });
  }

  Future<String> _signUpUser(SignUpData data) async {
    return Future.delayed(loginTime).then((_) async {

      dynamic user = await _auth.registerWithEmailAndPassword(data.email, data.password, data.organisationName, data.organisationLocation);
      if (user == null) {
        return 'Error signing up';
      }

      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {

      //TODO

      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: '',
      logo: 'assets/images/logo_white.png',
      onLogin: _signInUser,
      onSignup: _signUpUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Home(),
        ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}