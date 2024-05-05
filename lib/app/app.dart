import 'package:advanced_flutter/app/app_prefs.dart';
import 'package:advanced_flutter/app/dependancy_injection.dart';
import 'package:advanced_flutter/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';

import '../presentation/resources/theme_manager.dart';
import 'package:easy_localization/easy_localization.dart';

class MyApp extends StatefulWidget {
  // const MyApp({super.key}); // default constructor

  // named constructor
  MyApp._internal();
  static final MyApp _instance =
      MyApp._internal(); // singleton or single instance
  factory MyApp() => _instance; // factory

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  void didChangeDependencies() {
    _appPreferences.getLocal().then((local) => {context.setLocale(local)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      theme: getApplicationTheme(),
    );
  }
}
