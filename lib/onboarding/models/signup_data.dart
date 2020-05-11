import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

class SignUpData {
  final String email;
  final String password;
  final String organisationName;
  final String organisationLocation;

  SignUpData({
    @required this.email,
    @required this.password,
    @required this.organisationName,
    @required this.organisationLocation,
  });

  @override
  String toString() {
    return '$runtimeType($email, $password, $organisationName, $organisationLocation)';
  }

  bool operator ==(Object other) {
    if (other is SignUpData) {
      return email == other.email &&
          password == other.password &&
          organisationName == other.organisationName &&
          organisationLocation == other.organisationLocation;
    }
    return false;
  }

  int get hashCode => hash2(email, password);
}
