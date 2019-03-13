import 'dart:async';
import 'dart:io';

import 'package:fake_analytics/fake_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runZoned(() {
    runApp(MyApp());
  }, onError: (Object error, StackTrace stack) {
    print(error);
    print(stack);
  });

  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FakeAnalytics analytics = FakeAnalytics();
    if (Platform.isAndroid) {
      analytics.startWork(
        appKey: '86eaf64920',
        appChannel: () => Future.value('official'),
        enableDebug: true,
      );
    } else if (Platform.isIOS) {
      analytics.startWork(
        appKey: '911c2d1f04',
        appChannel: () => Future.value('official'),
        enableDebug: true,
      );
    }
    return FakeAnalyticsProvider(
      analytics: analytics,
      child: MaterialApp(
        home: FakeAnalyticsWidget(
          analytics: analytics,
          nameExtractor: _nameExtractor,
          child: Home(),
        ),
        routes: {
//          Navigator.defaultRouteName: (BuildContext context) {
//            print('xxx');/// issue iOS初始化会调用三次
//            return FakeAnalyticsWidget(
//              analytics: analytics,
//              nameExtractor: _nameExtractor,
//              child: Home(),
//            );
//          },
          '/about': (BuildContext context) => FakeAnalyticsWidget(
                analytics: analytics,
                nameExtractor: _nameExtractor,
                child: About(),
              ),
          '/feedback': (BuildContext context) => FakeAnalyticsWidget(
                analytics: analytics,
                nameExtractor: _nameExtractor,
                child: Feedback(),
              ),
        },
        navigatorObservers: [
          FakeAnalyticsRouteObserver(
            analytics: analytics,
            nameExtractor: _nameExtractor,
          )
        ],
        title: 'Fake Analytics Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          platform: TargetPlatform.iOS,
        ),
      ),
    );
  }

  final Map<String, String> _pageNameMap = {
    Navigator.defaultRouteName: '主页',
    '/about': '关于',
    '/feedback': '反馈'
  };

  String _nameExtractor(RouteSettings settings) {
    String routeName = settings.name;
    return _pageNameMap.containsKey(routeName)
        ? _pageNameMap[routeName]
        : routeName;
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fake Analytics Demo'),
      ),
      body: Center(
        child: GestureDetector(
          child: Text('${Platform.operatingSystem}'),
          onTap: () {
            FakeAnalyticsProvider.of(context).analytics.trackEvent(
                  eventId: '关于',
                  eventLabel: '首页',
                );
            Navigator.of(context).pushNamed('/about');
          },
        ),
      ),
    );
  }
}

class About extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AboutState();
  }
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: Center(
        child: GestureDetector(
          child: Text('${Platform.operatingSystem}'),
          onTap: () {
            Navigator.of(context).pushNamed('/feedback');
          },
        ),
      ),
    );
  }
}

class Feedback extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FeedbackState();
  }
}

class _FeedbackState extends State<Feedback> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
      ),
      body: Center(
        child: GestureDetector(
          child: Text('${Platform.operatingSystem}'),
          onTap: () {},
        ),
      ),
    );
  }
}
