import 'package:fake_analytics/src/analytics.dart';
import 'package:fake_analytics/src/analytics_foundation.dart';
import 'package:flutter/widgets.dart';

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
      analytics.pausePageTracking(
        pageName: nameExtractor(previousRoute),
      );
    }
    if (route != null && route is PageRoute) {
      analytics.startPageTracking(
        pageName: nameExtractor(route),
      );
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPop(route, previousRoute);
    if (route != null && route is PageRoute) {
      analytics.stopPageTracking(
        pageName: nameExtractor(route),
      );
    }
    if (previousRoute != null && previousRoute is PageRoute) {
      analytics.resumePageTracking(
        pageName: nameExtractor(previousRoute),
      );
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didRemove(route, previousRoute);
    if (route != null && route is PageRoute) {
      analytics.stopPageTracking(
        pageName: nameExtractor(route),
      );
    }
    if (previousRoute != null && previousRoute is PageRoute) {
      if (previousRoute.isCurrent) {
        analytics.resumePageTracking(
          pageName: nameExtractor(previousRoute),
        );
      }
    }
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (oldRoute != null && oldRoute is PageRoute) {
      analytics.stopPageTracking(
        pageName: nameExtractor(oldRoute),
      );
    }
    if (newRoute != null && newRoute is PageRoute) {
      analytics.startPageTracking(
        pageName: nameExtractor(newRoute),
      );
      if (!newRoute.isCurrent) {
        analytics.pausePageTracking(
          pageName: nameExtractor(newRoute),
        );
      }
    }
  }
}
