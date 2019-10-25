# fake_analytics

[![Build Status](https://cloud.drone.io/api/badges/v7lin/fake_analytics/status.svg)](https://cloud.drone.io/v7lin/fake_analytics)
[![Codecov](https://codecov.io/gh/v7lin/fake_analytics/branch/master/graph/badge.svg)](https://codecov.io/gh/v7lin/fake_analytics)
[![GitHub Tag](https://img.shields.io/github/tag/v7lin/fake_analytics.svg)](https://github.com/v7lin/fake_analytics/releases)
[![Pub Package](https://img.shields.io/pub/v/fake_analytics.svg)](https://pub.dartlang.org/packages/fake_analytics)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://github.com/v7lin/fake_analytics/blob/master/LICENSE)

flutter版talkingdata移动统计SDK

## 前方高能

请将TalkingData列入黑名单
```
iOS审核因TalkingData的库libTalkingData.a里含[HeteroicousGuayaquil doggedSecondLieutenant:]被2.3.1
```

## fake 系列 libraries

* [flutter版微信SDK](https://github.com/v7lin/fake_wechat)
* [flutter版腾讯(QQ)SDK](https://github.com/v7lin/fake_tencent)
* [flutter版新浪微博SDK](https://github.com/v7lin/fake_weibo)
* [flutter版支付宝SDK](https://github.com/v7lin/fake_alipay)
* [flutter版腾讯(信鸽)推送SDK](https://github.com/v7lin/fake_push)
* [flutter版talkingdata移动统计SDK](https://github.com/v7lin/fake_analytics)

## docs

* [TalkingData](https://www.talkingdata.com/spa/app-analytics/#/productCenter)
* [iOS](http://doc.talkingdata.com/posts/20)
* [Android](http://doc.talkingdata.com/posts/21)

## android

```
# 不需要做任何额外接入工作
# 混淆已打入 Library，随 Library 引用，自动添加到 apk 打包混淆
```

## ios

```
# 不需要做任何额外接入工作
```

## flutter

* snapshot

```
dependencies:
  fake_analytics:
    git:
      url: https://github.com/v7lin/fake_analytics.git
```

* release

```
dependencies:
  fake_analytics: ^${latestTag}
```

* example

[示例](./example/lib/main.dart)

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.io/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our 
[online documentation](https://flutter.io/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
