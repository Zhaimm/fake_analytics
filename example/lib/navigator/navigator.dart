import 'package:fake_analytics_example/components/about/about_component.dart';
import 'package:fake_analytics_example/components/analytics/analytics_component.dart';
import 'package:fake_analytics_example/components/home/home_component.dart';
import 'package:fake_analytics_example/components/not_found/not_found_component.dart';
import 'package:fake_analytics_example/components/splash/splash_component.dart';
import 'package:flutter/widgets.dart';

class AppNavigator {
  const AppNavigator._();

  static const String splash = '/splash';
  static const String analytics = '/analytics';
  static const String about = '/about';
  static const String notFound = '/not_found';

  static final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    Navigator.defaultRouteName: (BuildContext context) => HomeComponent(),
    splash: (BuildContext context) => SplashComponent(),
    analytics: (BuildContext context) => AnalyticsComponent(),
    about: (BuildContext context) => AboutComponent(),
    notFound: (BuildContext context) => NotFoundComponent(),
  };
}
