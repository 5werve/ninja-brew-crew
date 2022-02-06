import 'package:flutter/material.dart';
import 'package:ninja_brew_crew/models/appUser.dart';
import 'package:ninja_brew_crew/screens/authenticate/sign_in.dart';
import 'package:ninja_brew_crew/screens/authenticate/authenticate.dart';
import 'package:ninja_brew_crew/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);

    // return either Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
