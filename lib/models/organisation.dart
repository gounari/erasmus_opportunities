import 'package:flutter/foundation.dart';

class Organisation {
  final String uid;
  final String name;
  final String email;
  final String location;

  Organisation({
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


