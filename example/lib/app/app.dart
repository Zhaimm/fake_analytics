import 'package:fake_analytics_example/app/service_view_model.dart';
import 'package:fake_analytics_example/navigator/navigator.dart';
import 'package:fake_lifecycle/fake_lifecycle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppState();
  }
}

class _AppState extends State<App> {
  ServiceViewModel _service;

  @override
  void initState() {
    super.initState();
    _service = ServiceViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _service.initApp(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Builder(
            builder: AppNavigator.routes[AppNavigator.splash],
          );
        }
        return ScopedModel<ServiceViewModel>(
          model: _service,
          child: _RawApp(),
        );
      },
    );
  }
}

class _RawApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RawAppState();
  }
}

class _RawAppState extends State<_RawApp> {
  ServiceViewModel _service;

  @override
  void initState() {
    super.initState();
    _service = ServiceViewModel.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (RouteSettings settings) =>
          _onGenerateRoute(settings, _service.tracker),
      onUnknownRoute: (RouteSettings settings) =>
          _onUnknownRoute(settings, _service.tracker),
      navigatorObservers: <NavigatorObserver>[
        LifecycleRouteObserver(
          tracker: _service.tracker,
        ),
      ],
      builder: (BuildContext context, Widget child) {
        /// 禁用系统字体控制
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: 1.0,
            boldText: false,
          ),
          child: child,
        );
      },
      onGenerateTitle: (BuildContext context) {
        return 'Fake Analytics';
      },
    );
  }

  Route<dynamic> _onGenerateRoute(
      RouteSettings settings, LifecycleTracker tracker) {
    if (AppNavigator.routes.containsKey(settings.name)) {
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          return LifecycleWidget(
            tracker: tracker,
            child: Builder(
              builder: AppNavigator.routes[settings.name],
            ),
          );
        },
        settings: settings,
      );
    }
    return null;
  }

  Route<dynamic> _onUnknownRoute(
      RouteSettings settings, LifecycleTracker tracker) {
    return MaterialPageRoute<dynamic>(
      builder: (BuildContext context) {
        return LifecycleWidget(
          tracker: tracker,
          child: Builder(
            builder: AppNavigator.routes[AppNavigator.notFound],
          ),
        );
      },
      settings: settings,
    );
  }
}
