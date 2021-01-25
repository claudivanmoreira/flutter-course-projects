import 'package:flutter/material.dart';

class AppConfig extends InheritedWidget {
  AppConfig({
    @required this.apiBaseUrl,
    @required this.apiSecret,
    @required this.apiTrendsGifsPath,
    @required this.apiSearchGifsPath,
    @required this.appIconUrl,
    @required Widget child,
  }) : super(child: child);

  final String apiSecret;
  final String apiBaseUrl;
  final String apiTrendsGifsPath;
  final String apiSearchGifsPath;
  final String appIconUrl;

  static AppConfig of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppConfig>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
