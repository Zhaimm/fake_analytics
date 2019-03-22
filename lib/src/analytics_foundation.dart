import 'package:flutter/widgets.dart';

typedef String AnalyticsNameExtractor(RouteSettings settings);

String defaultNameExtractor(RouteSettings settings) => settings.name;
