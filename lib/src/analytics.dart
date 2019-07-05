import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

class Analytics {
  static const int ACCOUNT_TYPE_ANONYMOUS = 0;
  static const int ACCOUNT_TYPE_REGISTERED = 1;
  static const int ACCOUNT_TYPE_SINA_WEIBO = 2;
  static const int ACCOUNT_TYPE_QQ = 3;
  static const int ACCOUNT_TYPE_QQ_WEIBO = 4;
  static const int ACCOUNT_TYPE_ND91 = 5;
  static const int ACCOUNT_TYPE_WEIXIN = 6;
  static const int ACCOUNT_TYPE_TYPE1 = 11;
  static const int ACCOUNT_TYPE_TYPE2 = 12;
  static const int ACCOUNT_TYPE_TYPE3 = 13;
  static const int ACCOUNT_TYPE_TYPE4 = 14;
  static const int ACCOUNT_TYPE_TYPE5 = 15;
  static const int ACCOUNT_TYPE_TYPE6 = 16;
  static const int ACCOUNT_TYPE_TYPE7 = 17;
  static const int ACCOUNT_TYPE_TYPE8 = 18;
  static const int ACCOUNT_TYPE_TYPE9 = 19;
  static const int ACCOUNT_TYPE_TYPE10 = 20;

  static const String _METHOD_STARTWORK = 'startWork';
  static const String _METHOD_SIGNUP = 'signUp';
  static const String _METHOD_SIGNIN = 'signIn';
  static const String _METHOD_TRACKEVENT = 'trackEvent';
  static const String _METHOD_TRACKPLACEORDER = 'trackPlaceOrder';
  static const String _METHOD_TRACKPAYORDER = 'trackPayOrder';
  static const String _METHOD_STARTPAGETRACKING = 'startPageTracking';
  static const String _METHOD_STOPPAGETRACKING = 'stopPageTracking';

  static const String _ARGUMENT_KEY_APPID = 'appId';
  static const String _ARGUMENT_KEY_CHANNELID = 'channelId';
  static const String _ARGUMENT_KEY_ENABLEDEBUG = 'enableDebug';

  static const String _ARGUMENT_KEY_TYPE = 'type';
  static const String _ARGUMENT_KEY_UID = "uid";
  static const String _ARGUMENT_KEY_NAME = "name";
  static const String _ARGUMENT_KEY_ORDERID = "orderId";
  static const String _ARGUMENT_KEY_TOTAL = "total";
  static const String _ARGUMENT_KEY_CURRENCYTYPE = "currencyType";
  static const String _ARGUMENT_KEY_PAYTYPE = "payType";
  static const String _ARGUMENT_KEY_EVENTID = 'eventId';
  static const String _ARGUMENT_KEY_EVENTLABEL = 'eventLabel';
  static const String _ARGUMENT_KEY_EVENTPARAMS = 'eventParams';

  static const String _ARGUMENT_KEY_PAGENAME = 'pageName';

  final MethodChannel _channel =
      const MethodChannel('v7lin.github.io/fake_analytics');

  /// 开始统计
  Future<void> startWork({
    @required String appId,
    @required AsyncValueGetter<String> channelId,
    bool enableDebug = false,
  }) async {
    assert(appId != null && appId.isNotEmpty);
    assert(channelId != null);
    String channelIdStr = await channelId();
    assert(channelIdStr != null && channelIdStr.isNotEmpty);
    await _channel.invokeMethod(
      _METHOD_STARTWORK,
      <String, dynamic>{
        _ARGUMENT_KEY_APPID: appId,
        _ARGUMENT_KEY_CHANNELID: channelIdStr,
        _ARGUMENT_KEY_ENABLEDEBUG: enableDebug,
      },
    );
  }

  /// 注册
  Future<void> signUp({
    int type = ACCOUNT_TYPE_REGISTERED,
    @required String uid,
    @required String name,
  }) {
    assert(uid != null && uid.isNotEmpty);
    assert(name != null && name.isNotEmpty);
    return _channel.invokeMethod(
      _METHOD_SIGNUP,
      <String, dynamic>{
        _ARGUMENT_KEY_TYPE: type,
        _ARGUMENT_KEY_UID: uid,
        _ARGUMENT_KEY_NAME: name,
      },
    );
  }

  /// 登录
  Future<void> signIn({
    int type = ACCOUNT_TYPE_REGISTERED,
    @required String uid,
    @required String name,
  }) {
    assert(uid != null && uid.isNotEmpty);
    assert(name != null && name.isNotEmpty);
    return _channel.invokeMethod(
      _METHOD_SIGNIN,
      <String, dynamic>{
        _ARGUMENT_KEY_TYPE: type,
        _ARGUMENT_KEY_UID: uid,
        _ARGUMENT_KEY_NAME: name,
      },
    );
  }

  /// 统计自定义事件发生次数
  Future<void> trackEvent({
    @required String eventId,
    String eventLabel,
    Map<String, dynamic> eventParams,
  }) {
    assert(eventId != null && eventId.isNotEmpty);
    assert(eventLabel == null || eventLabel.isNotEmpty);
    assert(eventParams == null || eventParams.isNotEmpty);
    if (eventParams != null) {
      eventParams.forEach((String key, dynamic value) {
        assert(value is String || value is num);
      });
    }
    Map<String, dynamic> map = <String, dynamic>{
      _ARGUMENT_KEY_EVENTID: eventId,
    };
    if (eventLabel != null) {
      map.putIfAbsent(_ARGUMENT_KEY_EVENTLABEL, () => eventLabel);
    }
    if (eventParams != null) {
      map.putIfAbsent(_ARGUMENT_KEY_EVENTPARAMS, () => eventParams);
    }
    return _channel.invokeMethod(_METHOD_TRACKEVENT, map);
  }

  Future<void> trackPlaceOrder({
    @required String uid,
    @required String orderId,
    @required int total,
    @required String currencyType,
  }) {
    assert(uid != null && uid.isNotEmpty);
    assert(orderId != null && orderId.isNotEmpty);
    assert(total != null);
    assert(currencyType != null && currencyType.isNotEmpty);
    return _channel.invokeMethod(
      _METHOD_TRACKPLACEORDER,
      <String, dynamic>{
        _ARGUMENT_KEY_UID: uid,
        _ARGUMENT_KEY_ORDERID: orderId,
        _ARGUMENT_KEY_TOTAL: total,
        _ARGUMENT_KEY_CURRENCYTYPE: currencyType,
      },
    );
  }

  Future<void> trackPayOrder({
    @required String uid,
    @required String payType,
    @required String orderId,
    @required int total,
    @required String currencyType,
  }) {
    assert(uid != null && uid.isNotEmpty);
    assert(payType != null && payType.isNotEmpty);
    assert(orderId != null && orderId.isNotEmpty);
    assert(total != null);
    assert(currencyType != null && currencyType.isNotEmpty);
    return _channel.invokeMethod(
      _METHOD_TRACKPAYORDER,
      <String, dynamic>{
        _ARGUMENT_KEY_UID: uid,
        _ARGUMENT_KEY_PAYTYPE: payType,
        _ARGUMENT_KEY_ORDERID: orderId,
        _ARGUMENT_KEY_TOTAL: total,
        _ARGUMENT_KEY_CURRENCYTYPE: currencyType,
      },
    );
  }

  /// 统计页面开始
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

  /// 统计页面结束
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
