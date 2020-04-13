import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';

class LoginData {
  final String uid;
  final String name;
  final String email;
  final String location;

  LoginData({
    @required this.uid,
    @required this.name,
    @required this.email,
    @required this.location,
  });

  @override
  String toString() {
    return '$runtimeType($uid, $name, $email, $location)';
  }
}
