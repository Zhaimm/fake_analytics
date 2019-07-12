import 'package:fake_lifecycle/fake_lifecycle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../analytics/analytics_tracker.dart';
import '../../app/app_view_model.dart';
import '../../components/about/about_component.dart';
import '../../navigator/navigator.dart';

class AnalyticsComponent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AnalyticsComponentState();
  }
}

class _AnalyticsComponentState extends State<AnalyticsComponent> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppViewModel>(
      builder: (
        BuildContext context,
        Widget child,
        AppViewModel model,
      ) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Analytics'),
          ),
          body: ListView(
            children: <Widget>[
              ListTile(
                title: const Text('Analytics'),
                onTap: () {
                  Navigator.of(context).pushNamed(AppNavigator.analytics);
                },
              ),
              ListTile(
                title: const Text('pop'),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('popAndPushNamed'),
                onTap: () {
                  Navigator.of(context).popAndPushNamed(AppNavigator.about);
                },
              ),
              ListTile(
                title: const Text('popUntil'),
                onTap: () {
                  Navigator.of(context).popUntil(
                      ModalRoute.withName(Navigator.defaultRouteName));
                },
              ),
              ListTile(
                title: const Text('push/pushNamed'),
                onTap: () {
                  Navigator.of(context).pushNamed(AppNavigator.about);
                },
              ),
              ListTile(
                title: const Text(
                    'pushAndRemoveUntil/pushNamedAndRemoveUntil - 不支持'),
                onTap: () {
                  throw UnsupportedError('LifecycleObserver 不支持');
                },
              ),
              ListTile(
                title: const Text('pushReplacement/pushReplacementNamed'),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(AppNavigator.about);
                },
              ),
              ListTile(
                title: const Text('removeRoute - 不支持'),
                onTap: () {
                  throw UnsupportedError('LifecycleObserver 不支持');
                },
              ),
              ListTile(
                title: const Text('removeRouteBelow - 不支持'),
                onTap: () {
                  throw UnsupportedError('LifecycleObserver 不支持');
                },
              ),
              ListTile(
                title: const Text('replace/replaceRouteBelow'),
                onTap: () {
                  Navigator.of(context).replaceRouteBelow(
                    anchorRoute: ModalRoute.of<dynamic>(context),
                    newRoute: CupertinoPageRoute<dynamic>(
                      builder: (BuildContext context) => LifecycleWidget(
                        tracker: AnalyticsTracker(
                          analytics: model.analytics,
                        ),
                        child: AboutComponent(),
                      ),
                      settings: const RouteSettings(
                        name: AppNavigator.about,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
