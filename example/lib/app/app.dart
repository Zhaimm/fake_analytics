import 'package:fake_analytics/fake_analytics.dart';
import 'package:fake_lifecycle/fake_lifecycle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import '../analytics/analytics_tracker.dart';
import '../components/about/about_component.dart';
import '../components/analytics/analytics_component.dart';
import '../components/home/home_component.dart';
import '../components/not_found/not_found_component.dart';
import '../navigator/navigator.dart';
import 'app_view_model.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppState();
  }
}

class _AppState extends State<App> {
  AppViewModel _model = AppViewModel();

  @override
  void initState() {
    super.initState();
    _model.initApp();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppViewModel>(
      model: _model,
      child: _RawApp(),
    );
  }
}

class _RawApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppViewModel>(
      builder: (
        BuildContext context,
        Widget child,
        AppViewModel model,
      ) {
        return MaterialApp(
          onGenerateRoute: (RouteSettings settings) =>
              _lifecycleRouteRoute(model.analytics, settings),
          navigatorObservers: <NavigatorObserver>[
            LifecycleRouteObserver(
              tracker: AnalyticsTracker(
                analytics: model.analytics,
                nameExtractor: _nameExtractor,
              ),
            ),
          ],
          theme: ThemeData.light().copyWith(
            platform: TargetPlatform.iOS,
          ),
        );
      },
    );
  }

  Route<dynamic> _lifecycleRouteRoute(
      Analytics analytics, RouteSettings settings) {
    return MaterialPageRoute<dynamic>(
      builder: (BuildContext context) {
        Widget component;
        switch (settings.name) {
          case Navigator.defaultRouteName:
            component = HomeComponent();
            break;
          case AppNavigator.analytics:
            component = AnalyticsComponent();
            break;
          case AppNavigator.about:
            component = AboutComponent();
            break;
          default:
            component = NotFoundComponent();
            break;
        }
        return LifecycleWidget(
          tracker: AnalyticsTracker(
            analytics: analytics,
            nameExtractor: _nameExtractor,
          ),
          child: component,
        );
      },
      settings: settings,
    );
  }

  String _nameExtractor(Route<dynamic> route) {
    return route.settings.name;
  }
}
