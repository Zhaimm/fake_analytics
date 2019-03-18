import 'dart:io';

import 'package:fake_analytics/src/analytics.dart';
import 'package:flutter/widgets.dart';
import 'package:fake_analytics/src/analytics_foundation.dart';

class AnalyticsWidget extends StatefulWidget {
  AnalyticsWidget({
    Key key,
    @required this.analytics,
    this.nameExtractor = defaultNameExtractor,
    @required this.child,
  })  : assert(analytics != null),
        assert(child != null),
        super(key: key);

  final Analytics analytics;
  final AnalyticsNameExtractor nameExtractor;
  final Widget child;

  @override
  State<StatefulWidget> createState() {
    return _AnalyticsWidgetState();
  }
}

class _AnalyticsWidgetState extends State<AnalyticsWidget>
    with WidgetsBindingObserver {
  bool _firstLifeResumed = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    Route<dynamic> route = ModalRoute.of<dynamic>(context);
    if (route.isCurrent) {
      if (state == AppLifecycleState.resumed) {
        /// release 启动首页时候，会先调用一次 resumed
        if (Platform.isAndroid) {
          if (!_isReleaseMode() || !route.isFirst || !_firstLifeResumed) {
            widget.analytics.startPageTracking(
              pageName: widget.nameExtractor(route.settings),
            );
          }
        } else {
          widget.analytics.startPageTracking(
            pageName: widget.nameExtractor(route.settings),
          );
        }
        _firstLifeResumed = false;
      } else if (state == AppLifecycleState.paused) {
        widget.analytics.stopPageTracking(
          pageName: widget.nameExtractor(route.settings),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Route<dynamic> route = ModalRoute.of<dynamic>(context);
    if (route.isFirst) {
      /// WillPopScope 会阻止侧滑返回功能
      return WillPopScope(
        child: widget.child,
        onWillPop: () {
          widget.analytics.stopPageTracking(
            pageName: widget.nameExtractor(route.settings),
          );
          return Future<bool>.value(true);
        },
      );
    }
    return widget.child;
  }

  bool _isReleaseMode() {
    return const bool.fromEnvironment('dart.vm.product');
  }
}
