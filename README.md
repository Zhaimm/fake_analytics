# fake_analytics

[![Build Status](https://cloud.drone.io/api/badges/v7lin/fake_analytics/status.svg)](https://cloud.drone.io/v7lin/fake_analytics)
[![Codecov](https://codecov.io/gh/v7lin/fake_analytics/branch/master/graph/badge.svg)](https://codecov.io/gh/v7lin/fake_analytics)
[![GitHub Tag](https://img.shields.io/github/tag/v7lin/fake_analytics.svg)](https://github.com/v7lin/fake_analytics/releases)
[![Pub Package](https://img.shields.io/pub/v/fake_analytics.svg)](https://pub.dartlang.org/packages/fake_analytics)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://github.com/v7lin/fake_analytics/blob/master/LICENSE)

flutter版百度移动统计SDK

## android

````
# 不需要做任何额外接入工作
# 混淆已打入 Library，随 Library 引用，自动添加到 apk 打包混淆
````

## ios

````
# 不需要做任何额外接入工作
````

## flutter

* 重点 --- 请勿使用 Navigator 的以下几种方式路由
pushAndRemoveUntil
pushNamedAndRemoveUntil
removeRouteBelow

* snapshot

````
dependencies:
  fake_analytics:
    git:
      url: https://github.com/v7lin/fake_analytics.git
````

* release

````
dependencies:
  fake_analytics: ^${latestTag}
````

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
