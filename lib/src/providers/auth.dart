import 'package:erasmusopportunities/src/models/signup_data.dart';
import 'package:flutter/material.dart';

import '../models/login_data.dart';

enum AuthMode { Signup, Login }

/// The result is an error message, callback successes if message is null
typedef AuthCallbackLogin = Future<String> Function(LoginData);

/// The result is an error message, callback successes if message is null
typedef AuthCallbackSignUp = Future<String> Function(SignUpData);

/// The result is an error message, callback successes if message is null
typedef RecoverCallback = Future<String> Function(String);

class Auth with ChangeNotifier {
  Auth({
    this.onLogin,
    this.onSignup,
    this.onRecoverPassword,
    String email = '',
    String password = '',
    String confirmPassword = '',
    String organisationName = '',
    String organisationLocation = '',
  })  : this._email = email,
        this._password = password,
        this._confirmPassword = confirmPassword,
        this._organisationName = organisationName,
        this._organisationLocation = organisationLocation;

  final AuthCallbackLogin onLogin;
  final AuthCallbackSignUp onSignup;
  final RecoverCallback onRecoverPassword;

  AuthMode _mode = AuthMode.Login;

  AuthMode get mode => _mode;
  set mode(AuthMode value) {
    _mode = value;
    notifyListeners();
  }

  bool get isLogin => _mode == AuthMode.Login;
  bool get isSignup => _mode == AuthMode.Signup;
  bool isRecover = false;

  AuthMode opposite() {
    return _mode == AuthMode.Login ? AuthMode.Signup : AuthMode.Login;
  }

  AuthMode switchAuth() {
    if (mode == AuthMode.Login) {
      mode = AuthMode.Signup;
    } else if (mode == AuthMode.Signup) {
      mode = AuthMode.Login;
    }
    return mode;
  }

  String _email = '';
  get email => _email;
  set email(String email) {
    _email = email;
    notifyListeners();
  }

  String _password = '';
  get password => _password;
  set password(String password) {
    _password = password;
    notifyListeners();
  }

  String _confirmPassword = '';
  get confirmPassword => _confirmPassword;
  set confirmPassword(String confirmPassword) {
    _confirmPassword = confirmPassword;
    notifyListeners();
  }

  String _organisationName = '';
  get organisationName => _organisationName;
  set organisationName(String organisationName) {
    _organisationName = organisationName;
    notifyListeners();
  }

  String _organisationLocation = '';
  get organisationLocation => _organisationLocation;
  set organisationLocation(String organisationLocation) {
    _organisationLocation = organisationLocation;
    notifyListeners();
  }
}
