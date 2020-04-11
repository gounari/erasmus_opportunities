import 'package:erasmusopportunities/screens/authenticate/authenticate.dart';
import 'package:erasmusopportunities/screens/home/home.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // Return either Home or Authenticate widget
    return Authenticate();
  }
}
