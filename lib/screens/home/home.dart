import 'package:flutter/material.dart';
import 'package:ninja_brew_crew/screens/home/settings_form.dart';
import 'package:ninja_brew_crew/services/auth.dart';
import 'package:ninja_brew_crew/services/database.dart';
import 'package:provider/provider.dart';
import 'package:ninja_brew_crew/screens/home/brew_list.dart';
import 'package:ninja_brew_crew/models/brew.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Brew>?>.value(
      value: DatabaseService(uid: '0').brews,
      initialData: [Brew(name: 'new crew member', sugars: '0', strength: 100)],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('settings'),
              onPressed: () => _showSettingsPanel(),
            ),
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
