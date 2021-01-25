import 'package:buscador_gifs/app_config.dart';
import 'package:buscador_gifs/screens/home_page.dart';
import 'package:buscador_gifs/services/giphy_api.dart';
import 'package:flutter/material.dart';

void main() {
  var configuredApp = AppConfig(
    apiBaseUrl: 'https://api.giphy.com/v1/gifs',
    apiTrendsGifsPath: '/trending',
    apiSearchGifsPath: '/search',
    apiSecret: 'qoKhE1bIysg5lzODrfjInePwk3AnLRd9',
    appIconUrl:
        'https://developers.giphy.com/static/img/dev-logo-lg.7404c00322a8.gif',
    child: MyApp(),
  );
  runApp(configuredApp);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppConfig appConfig = AppConfig.of(context);
    return MaterialApp(
      title: 'Buscador de Gifs',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        hintColor: Colors.white,
      ),
      home: HomePage(
        title: 'Home Page',
        appConfig: appConfig,
        giphyApi: GiphyApi(appConfig),
      ),
    );
  }
}
