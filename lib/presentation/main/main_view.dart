import 'package:advanced_flutter/presentation/main/pages/home/view/home_page.dart';
import 'package:advanced_flutter/presentation/main/pages/notifications/notifications_page.dart';
import 'package:advanced_flutter/presentation/main/pages/search/search_page.dart';
import 'package:advanced_flutter/presentation/main/pages/settings/settings_page.dart';
import 'package:advanced_flutter/presentation/resources/color_manager.dart';
import 'package:advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:advanced_flutter/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = [
    const HomePage(),
    const SearchPage(),
    const NotificationsPage(),
    const SettingsPage(),
  ];

  List<String> titles = [
    AppStrings.home,
    AppStrings.search,
    AppStrings.notifications,
    AppStrings.settings,
  ];

  var _title = AppStrings.home;
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: ColorManager.lightGrey,
              spreadRadius: AppSize.s1,
            )
          ],
        ),
        child: BottomNavigationBar(
            selectedItemColor: ColorManager.primary,
            unselectedItemColor: ColorManager.grey,
            currentIndex: _currentIndex,
            onTap: onTap,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: AppStrings.home,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: AppStrings.search,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications_outlined),
                label: AppStrings.notifications,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                label: AppStrings.settings,
              ),
            ]),
      ),
    );
  }

  onTap(int index) {
    setState(() {
      _currentIndex = index;
      _title = titles[index];
    });
  }
}
