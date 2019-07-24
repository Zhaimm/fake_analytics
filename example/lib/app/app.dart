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
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _service = ServiceViewModel();
    _setupApp();
  }

  Future<void> _setupApp() async {
    /// 非不得以，不在此初始化
    await _service.analytics.startWork(
      appId: 'F4813AF882C147D6BD02732E8DE11A3B',
      channelId: () => Future<String>.value('xxx'), //'xxx',
      enableDebug: !_service.isReleaseMode,
    );
    _initialized = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return Builder(
        builder: AppNavigator.routes[AppNavigator.splash],
      );
    }
    return ScopedModel<ServiceViewModel>(
      model: _service,
      child: _RawApp(),
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
      theme: ThemeData.light().copyWith(
        platform: TargetPlatform.iOS,
      ),
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
