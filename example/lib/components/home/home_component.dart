import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../navigator/navigator.dart';

class HomeComponent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeComponentState();
  }
}

class _HomeComponentState extends State<HomeComponent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fake Analytics'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('Analytics'),
            onTap: () {
              Navigator.of(context).pushNamed(AppNavigator.analytics);
            },
          ),
        ],
      ),
    );
  }
}
