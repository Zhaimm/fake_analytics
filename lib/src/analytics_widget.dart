import 'dart:io';

import 'package:fake_analytics/src/analytics.dart';
import 'package:fake_analytics/src/analytics_foundation.dart';
import 'package:flutter/widgets.dart';

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
  bool _lifeResumed = false;
  bool _shouldPopSystem = false;

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
  Future<bool> didPopRoute() {
    return super.didPopRoute().then((bool result) {
      if (!result) {
        Route<dynamic> route = ModalRoute.of<dynamic>(context);
        if (route.isFirst) {
          _shouldPopSystem = true;
          widget.analytics.stopPageTracking(
            pageName: widget.nameExtractor(route),
          );
        }
      }
      return result;
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    Route<dynamic> route = ModalRoute.of<dynamic>(context);
    if (route.isCurrent) {
      if (state == AppLifecycleState.resumed) {
        /// release 启动首页时候，会先调用一次 resumed
        if (Platform.isAndroid) {
          if (!_isReleaseMode() || !route.isFirst || _lifeResumed) {
            widget.analytics.resumePageTracking(
              pageName: widget.nameExtractor(route),
            );
          }
        } else {
          widget.analytics.resumePageTracking(
            pageName: widget.nameExtractor(route),
          );
        }
        _lifeResumed = true;
      } else if (state == AppLifecycleState.paused) {
        if (!_shouldPopSystem) {
          widget.analytics.pausePageTracking(
            pageName: widget.nameExtractor(route),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  bool _isReleaseMode() {
    return const bool.fromEnvironment('dart.vm.product');
  }
}
