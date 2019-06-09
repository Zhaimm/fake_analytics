import 'package:fake_analytics/fake_analytics.dart';
import 'package:fake_lifecycle/fake_lifecycle.dart';
import 'package:flutter/widgets.dart';
import 'analytics_foundation.dart';

class AnalyticsTracker implements LifecycleTracker {
  const AnalyticsTracker({
    @required this.analytics,
    this.nameExtractor = defaultNameExtractor,
  }) : assert(analytics != null);

  final Analytics analytics;
  final AnalyticsNameExtractor nameExtractor;

  @override
  void trackStartRoute({Route<dynamic> route}) {}

  @override
  void trackResumeRoute({Route<dynamic> route}) {
    analytics.startPageTracking(pageName: nameExtractor(route));
  }

  @override
  void trackPauseRoute({Route<dynamic> route}) {
    analytics.stopPageTracking(pageName: nameExtractor(route));
  }

  @override
  void trackStopRoute({Route<dynamic> route}) {}
}
