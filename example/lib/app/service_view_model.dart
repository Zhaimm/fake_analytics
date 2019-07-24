import 'package:fake_analytics/fake_analytics.dart';
import 'package:fake_analytics_example/analytics/analytics_tracker.dart';
import 'package:fake_lifecycle/fake_lifecycle.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

class ServiceViewModel extends Model {
  Analytics _analytics;
  LifecycleTracker _tracker;

  Analytics get analytics => _analytics ?? (_analytics = Analytics());

  LifecycleTracker get tracker =>
      _tracker ?? (_tracker = AnalyticsTracker(analytics: analytics));

  bool get isReleaseMode => const bool.fromEnvironment('dart.vm.product');

  static ServiceViewModel of(BuildContext context) {
    return ScopedModel.of<ServiceViewModel>(context);
  }
}
