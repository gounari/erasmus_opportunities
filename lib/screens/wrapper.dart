import 'package:erasmusopportunities/models/user.dart';
import 'package:erasmusopportunities/screens/authenticate/authenticate.dart';
import 'package:erasmusopportunities/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);
    // Return either Home or Authenticate widget
    return Authenticate();
  }
}
