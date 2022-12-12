import 'package:flutter/material.dart';
import 'package:frenzy_store/presentation/main/pages/home_page.dart';
import 'package:frenzy_store/presentation/main/pages/notification_page.dart';
import 'package:frenzy_store/presentation/main/pages/search_page.dart';
import 'package:frenzy_store/presentation/main/pages/settings_page.dart';
import 'package:frenzy_store/presentation/resources/strings_manager.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final List<Widget> _pages = [
    const HomePage(),
    const SearchPage(),
    const NotificationPage(),
    const SettingsPage()
  ];

  String _title = AppStrings.home;
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: _pages[_currentPage],
    );
  }
}
