import 'package:flutter/widgets.dart';

typedef String AnalyticsNameExtractor(Route<dynamic> route);

String defaultNameExtractor(Route<dynamic> route) => route.settings.name;
