import 'package:fake_analytics/src/analytics.dart';
import 'package:flutter/widgets.dart';

class AnalyticsProvider extends InheritedWidget {
  AnalyticsProvider({
    Key key,
    @required this.analytics,
    @required Widget child,
  }) : super(key: key, child: child);

  final Analytics analytics;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    AnalyticsProvider oldProvider = oldWidget as AnalyticsProvider;
    return analytics != oldProvider.analytics;
  }

  static AnalyticsProvider of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(AnalyticsProvider)
        as AnalyticsProvider;
  }
}
