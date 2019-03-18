# fake_analytics

[![Build Status](https://cloud.drone.io/api/badges/v7lin/fake_analytics/status.svg)](https://cloud.drone.io/v7lin/fake_analytics)
[![GitHub tag](https://img.shields.io/github/tag/v7lin/fake_analytics.svg)](https://github.com/v7lin/fake_analytics/releases)
[![pub package](https://img.shields.io/pub/v/fake_analytics.svg)](https://pub.dartlang.org/packages/fake_analytics)

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

### snapshot
````
dependencies:
  fake_analytics:
    git:
      url: https://github.com/v7lin/fake_analytics.git
````

### release
````
latestVersion = 0.1.0+1
````

````
dependencies:
  fake_analytics: ^${latestVersion}
````

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.io/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our 
[online documentation](https://flutter.io/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
