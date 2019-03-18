import 'package:fake_analytics/src/analytics.dart';
import 'package:flutter/widgets.dart';
import 'package:fake_analytics/src/analytics_foundation.dart';

class AnalyticsRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  AnalyticsRouteObserver({
    @required this.analytics,
    this.nameExtractor = defaultNameExtractor,
  }) : assert(analytics != null);

  final Analytics analytics;
  final AnalyticsNameExtractor nameExtractor;

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPush(route, previousRoute);
    if (previousRoute != null && previousRoute is PageRoute) {
      String pageName = nameExtractor(previousRoute.settings);
      analytics.stopPageTracking(
        pageName: pageName,
      );
    }
    if (route != null && route is PageRoute) {
      String pageName = nameExtractor(route.settings);
      analytics.startPageTracking(
        pageName: pageName,
      );
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPop(route, previousRoute);
    if (route != null && route is PageRoute) {
      String pageName = nameExtractor(route.settings);
      analytics.stopPageTracking(
        pageName: pageName,
      );
    }
    if (previousRoute != null && previousRoute is PageRoute) {
      String pageName = nameExtractor(previousRoute.settings);
      analytics.startPageTracking(
        pageName: pageName,
      );
    }
  }
}