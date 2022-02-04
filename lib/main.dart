import 'package:flutter/material.dart';
import 'package:ninja_brew_crew/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ninja_brew_crew/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:ninja_brew_crew/models/appUser.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
