import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

class FakeAnalytics {
  static const String _METHOD_STARTWORK = 'startWork';
  static const String _METHOD_SIGNUP = 'signUp';
  static const String _METHOD_SIGNIN = 'signIn';
  static const String _METHOD_SIGNOUT = 'signOut';
  static const String _METHOD_TRACKEVENT = 'trackEvent';
  static const String _METHOD_STARTEVENTTRACKING = 'startEventTracking';
  static const String _METHOD_STOPEVENTTRACKING = 'stopEventTracking';
  static const String _METHOD_STARTPAGETRACKING = 'startPageTracking';
  static const String _METHOD_STOPPAGETRACKING = 'stopPageTracking';

  static const String _ARGUMENT_KEY_APPKEY = 'appKey';
  static const String _ARGUMENT_KEY_APPCHANNEL = 'appChannel';
  static const String _ARGUMENT_KEY_ENABLEDEBUG = 'enableDebug';

  static const String _ARGUMENT_KEY_USERID = 'userId';
  static const String _ARGUMENT_KEY_USERNICK = "userNick";

  static const String _ARGUMENT_KEY_EVENTID = 'eventId';
  static const String _ARGUMENT_KEY_EVENTLABEL = 'eventLabel';

  static const String _ARGUMENT_KEY_PAGENAME = 'pageName';

  static const MethodChannel _channel =
      MethodChannel('v7lin.github.io/fake_analytics');

  /// 开始统计
  Future<void> startWork({
    @required String appKey,
    @required AsyncValueGetter<String> appChannel,
    bool enableDebug = false,
  }) async {
    assert(appKey != null && appKey.isNotEmpty);
    assert(appChannel != null);
    String channelId = await appChannel();
    assert(channelId != null && channelId.isNotEmpty);
    await _channel.invokeMethod(
      _METHOD_STARTWORK,
      <String, dynamic>{
        _ARGUMENT_KEY_APPKEY: appKey,
        _ARGUMENT_KEY_APPCHANNEL: channelId,
        _ARGUMENT_KEY_ENABLEDEBUG: enableDebug,
      },
    );
  }

  /// 注册
  Future<void> signUp({
    @required String userId,
    @required String userNick,
  }) {
    assert(userId != null && userId.isNotEmpty);
    return _channel.invokeMethod(
      _METHOD_SIGNUP,
      <String, dynamic>{
        _ARGUMENT_KEY_USERID: userId,
        _ARGUMENT_KEY_USERNICK: userNick,
      },
    );
  }

  /// 登录
  Future<void> signIn({
    @required String userId,
    @required String userNick,
  }) {
    assert(userId != null && userId.isNotEmpty);
    return _channel.invokeMethod(
      _METHOD_SIGNIN,
      <String, dynamic>{
        _ARGUMENT_KEY_USERID: userId,
        _ARGUMENT_KEY_USERNICK: userNick,
      },
    );
  }

  /// 登出
  Future<void> signOut() {
    return _channel.invokeMethod(_METHOD_SIGNOUT);
  }

  /// 统计自定义事件发生次数
  Future<void> trackEvent({
    @required String eventId,
    @required String eventLabel,
  }) {
    assert(eventId != null && eventId.isNotEmpty);
    assert(eventLabel != null && eventLabel.isNotEmpty);
    return _channel.invokeMethod(
      _METHOD_TRACKEVENT,
      <String, dynamic>{
        _ARGUMENT_KEY_EVENTID: eventId,
        _ARGUMENT_KEY_EVENTLABEL: eventLabel,
      },
    );
  }

  /// 统计自定义事件开始时间
  Future<void> startEventTracking({
    @required String eventId,
    @required String eventLabel,
  }) {
    assert(eventId != null && eventId.isNotEmpty);
    assert(eventLabel != null && eventLabel.isNotEmpty);
    return _channel.invokeMethod(
      _METHOD_STARTEVENTTRACKING,
      <String, dynamic>{
        _ARGUMENT_KEY_EVENTID: eventId,
        _ARGUMENT_KEY_EVENTLABEL: eventLabel,
      },
    );
  }

  /// 统计自定义事件结束时间
  Future<void> stopEventTracking({
    @required String eventId,
    @required String eventLabel,
  }) {
    assert(eventId != null && eventId.isNotEmpty);
    assert(eventLabel != null && eventLabel.isNotEmpty);
    return _channel.invokeMethod(
      _METHOD_STOPEVENTTRACKING,
      <String, dynamic>{
        _ARGUMENT_KEY_EVENTID: eventId,
        _ARGUMENT_KEY_EVENTLABEL: eventLabel,
      },
    );
  }

  /// 统计页面开始时间
  Future<void> startPageTracking({
    @required String pageName,
  }) {
    assert(pageName != null && pageName.isNotEmpty);
    return _channel.invokeMethod(
      _METHOD_STARTPAGETRACKING,
      <String, dynamic>{
        _ARGUMENT_KEY_PAGENAME: pageName,
      },
    );
  }

  /// 统计页面结束时间
  Future<void> stopPageTracking({
    @required String pageName,
  }) {
    assert(pageName != null && pageName.isNotEmpty);
    return _channel.invokeMethod(
      _METHOD_STOPPAGETRACKING,
      <String, dynamic>{
        _ARGUMENT_KEY_PAGENAME: pageName,
      },
    );
  }
}

class FakeAnalyticsProvider extends InheritedWidget {
  FakeAnalyticsProvider({
    Key key,
    @required this.analytics,
    @required Widget child,
  }) : super(key: key, child: child);

  final FakeAnalytics analytics;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    FakeAnalyticsProvider oldProvider = oldWidget as FakeAnalyticsProvider;
    return analytics != oldProvider.analytics;
  }

  static FakeAnalyticsProvider of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(FakeAnalyticsProvider)
        as FakeAnalyticsProvider;
  }
}

typedef String FakeAnalyticsNameExtractor(RouteSettings settings);

String defaultNameExtractor(RouteSettings settings) => settings.name;

class FakeAnalyticsRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  FakeAnalyticsRouteObserver({
    @required this.analytics,
    this.nameExtractor = defaultNameExtractor,
  }) : assert(analytics != null);

  final FakeAnalytics analytics;
  final FakeAnalyticsNameExtractor nameExtractor;

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

class FakeAnalyticsWidget extends StatefulWidget {
  FakeAnalyticsWidget({
    Key key,
    @required this.analytics,
    this.nameExtractor = defaultNameExtractor,
    @required this.child,
  })  : assert(analytics != null),
        assert(child != null),
        super(key: key);

  final FakeAnalytics analytics;
  final FakeAnalyticsNameExtractor nameExtractor;
  final Widget child;

  @override
  State<StatefulWidget> createState() {
    return _FakeAnalyticsWidgetState();
  }
}

class _FakeAnalyticsWidgetState extends State<FakeAnalyticsWidget>
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
