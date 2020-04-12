import 'package:erasmusopportunities/screens/authenticate/sign_in.dart';
import 'package:erasmusopportunities/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:erasmusopportunities/models/user.dart';
import 'package:erasmusopportunities/screens/authenticate/authenticate.dart';
import 'package:erasmusopportunities/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SignIn(),
    );
  }
}
