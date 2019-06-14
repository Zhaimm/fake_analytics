import 'package:fake_lifecycle/fake_lifecycle.dart';
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
  final Map<String, WidgetBuilder> _routes = <String, WidgetBuilder>{
    Navigator.defaultRouteName: (BuildContext context) => HomeComponent(),
    AppNavigator.analytics: (BuildContext context) => AnalyticsComponent(),
    AppNavigator.about: (BuildContext context) => AboutComponent(),
  };

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppViewModel>(
      builder: (
        BuildContext context,
        Widget child,
        AppViewModel model,
      ) {
        LifecycleTracker tracker = AnalyticsTracker(
          analytics: model.analytics,
        );
        return MaterialApp(
          onGenerateRoute: (RouteSettings settings) =>
              _onGenerateRoute(settings, tracker),
          onUnknownRoute: (RouteSettings settings) =>
              _onUnknownRoute(settings, tracker),
          builder: (BuildContext context, Widget child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaleFactor: 1.0,
                boldText: false,
              ),
              child: child,
            );
          },
          navigatorObservers: <NavigatorObserver>[
            LifecycleRouteObserver(
              tracker: tracker,
            ),
          ],
          theme: ThemeData.light().copyWith(
            platform: TargetPlatform.iOS,
          ),
        );
      },
    );
  }

  Route<dynamic> _onGenerateRoute(
    RouteSettings settings,
    LifecycleTracker tracker,
  ) {
    WidgetBuilder builder = _routes[settings.name];
    return MaterialPageRoute<dynamic>(
      builder: (BuildContext context) {
        return LifecycleWidget(
          tracker: tracker,
          child: Builder(
            builder: builder,
          ),
        );
      },
      settings: settings,
    );
  }

  Route<dynamic> _onUnknownRoute(
    RouteSettings settings,
    LifecycleTracker tracker,
  ) {
    return MaterialPageRoute<dynamic>(
      builder: (BuildContext context) {
        return LifecycleWidget(
          tracker: tracker,
          child: NotFoundComponent(),
        );
      },
      settings: settings,
    );
  }
}
