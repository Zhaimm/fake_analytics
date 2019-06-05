import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

class Analytics {
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

  final MethodChannel _channel =
      const MethodChannel('v7lin.github.io/fake_analytics');

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

  Future<void> resumePageTracking({
    @required String pageName,
  }) {
    return startPageTracking(pageName: pageName);
  }

  Future<void> pausePageTracking({
    @required String pageName,
  }) {
    return stopPageTracking(pageName: pageName);
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
