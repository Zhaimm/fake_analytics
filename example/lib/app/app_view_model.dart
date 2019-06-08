import 'package:fake_analytics/fake_analytics.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class AppViewModel extends Model {

  bool _initialized;

  Analytics _analytics;

  bool get initialized => _initialized ?? false;

  Analytics get analytics => _analytics;

  Future<void> initApp() async {
    _analytics = Analytics();
    await _analytics.startWork(
      appId: 'F4813AF882C147D6BD02732E8DE11A3B',
      channelId: () => Future<String>.value('xxx'),
      enableDebug: !_isReleaseMode(),
    );
    _initialized = true;
    notifyListeners();
  }

  bool _isReleaseMode() {
    return const bool.fromEnvironment('dart.vm.product');
  }

  static AppViewModel of(BuildContext context) {
    return ScopedModel.of<AppViewModel>(context);
  }
}
