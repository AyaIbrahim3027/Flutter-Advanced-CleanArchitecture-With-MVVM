import 'package:advanced_flutter/presentation/main/pages/home_page.dart';
import 'package:advanced_flutter/presentation/main/pages/notifications_page.dart';
import 'package:advanced_flutter/presentation/main/pages/search_page.dart';
import 'package:advanced_flutter/presentation/main/pages/settings_page.dart';
import 'package:advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';
class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages =[
    const HomePage(),
    const SearchPage(),
    const NotificationsPage(),
    const SettingsPage(),
  ];

  var _title = AppStrings.home;
  var _currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(_title,style: Theme.of(context).textTheme.titleSmall,),
      ),
      body: pages[_currentIndex],
    );
  }
}
