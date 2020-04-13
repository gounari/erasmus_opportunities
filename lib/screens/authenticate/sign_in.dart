import 'package:erasmusopportunities/models/user.dart';
import 'package:erasmusopportunities/screens/home/home.dart';
import 'package:erasmusopportunities/screens/services/auth.dart';
import 'package:erasmusopportunities/src/models/signup_data.dart';
import 'package:flutter/material.dart';
import 'package:erasmusopportunities/flutter_login.dart';
import 'package:firebase_auth/firebase_auth.dart';

const users = const {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class SignIn extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  final AuthService _auth = AuthService();

  Future<String> _signInUser(LoginData data) {
    print('Login: \nEmail: ${data.email}, Password: ${data.password}');

    return Future.delayed(loginTime).then((_) async {

      dynamic user = await _auth.signInWithEmailAndPassword(data.email, data.password);
      if (user == null) {
        return 'Error signing in';
      }

      return null;
    });
  }

  Future<String> _signUpUser(SignUpData data) async {
    print('SignUp: \nEmail: ${data.email}, Password: ${data.password}, Name: ${data.organisationName}, Location: ${data.organisationLocation}');
    return Future.delayed(loginTime).then((_) async {

      dynamic user = await _auth.registerWithEmailAndPassword(data.email, data.password);
      if (user == null) {
        return 'Error signing up';
      }

      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'Username not exists';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: '',
      logo: '/Users/argyrodevelop/AndroidStudioProjects/erasmus_opportunities/lib/assets/branding/logo.png',
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