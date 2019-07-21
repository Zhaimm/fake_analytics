import 'package:fake_analytics/fake_analytics.dart';
import 'package:fake_lifecycle/fake_lifecycle.dart';
import 'package:flutter/widgets.dart';

String _defaultNameExtractor(Route<dynamic> route) => route.settings.name;

class AnalyticsTracker implements LifecycleTracker {
  const AnalyticsTracker({
    @required this.analytics,
    this.nameExtractor = _defaultNameExtractor,
  }) : assert(analytics != null);

  final Analytics analytics;
  final String Function(Route<dynamic> route) nameExtractor;

  @override
  void trackStartRoute({Route<dynamic> route}) {
    print('Start - ${route.settings.name}');
  }

  @override
  void trackResumeRoute({Route<dynamic> route}) {
    print('Resume - ${route.settings.name}');
    String pageName = nameExtractor(route);
    if (pageName != null && pageName.isNotEmpty) {
      analytics.startPageTracking(pageName: pageName);
    }
  }

  @override
  void trackPauseRoute({Route<dynamic> route}) {
    print('Pause - ${route.settings.name}');
    String pageName = nameExtractor(route);
    if (pageName != null && pageName.isNotEmpty) {
      analytics.stopPageTracking(pageName: pageName);
    }
  }

  @override
  void trackStopRoute({Route<dynamic> route}) {
    print('Stop - ${route.settings.name}');
  }
}
