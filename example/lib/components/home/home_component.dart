import 'package:fake_analytics_example/app/service_view_model.dart';
import 'package:fake_analytics_example/navigator/navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
              Navigator.of(context).pushNamed(AppNavigator.analytics).then((dynamic resp) {
                print('hhhhhhhhh $resp');
              });
            },
          ),
          ListTile(
            title: const Text('Sign In'),
            onTap: () {
              ServiceViewModel.of(context)
                  .analytics
                  .signIn(uid: 'abc', name: 'abc');
            },
          ),
          ListTile(
            title: const Text('Track Event - eventId'),
            onTap: () {
              ServiceViewModel.of(context).analytics.trackEvent(
                    eventId: 'abc',
                  );
            },
          ),
          ListTile(
            title: const Text('Track Event - eventId, eventLabel'),
            onTap: () {
              ServiceViewModel.of(context).analytics.trackEvent(
                    eventId: 'efg',
                    eventLabel: 'efg',
                  );
            },
          ),
          ListTile(
            title: const Text('Track Event - eventId, eventParams'),
            onTap: () {
              ServiceViewModel.of(context).analytics.trackEvent(
                eventId: 'hij',
                eventParams: <String, dynamic>{
                  'key-i': 1,
                  'key-f': 3.3,
                  'key-s': 'value',
                },
              );
            },
          ),
          ListTile(
            title: const Text('Track Event - eventId, eventLabel, eventParams'),
            onTap: () {
              ServiceViewModel.of(context).analytics.trackEvent(
                eventId: 'klm',
                eventLabel: 'klm',
                eventParams: <String, dynamic>{
                  'key-i': 1,
                  'key-f': 1.0,
                  'key-s': 'value',
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
