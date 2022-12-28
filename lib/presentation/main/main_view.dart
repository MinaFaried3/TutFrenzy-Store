import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:frenzy_store/presentation/main/pages/home/view/home_page.dart';
import 'package:frenzy_store/presentation/main/pages/notification/notification_page.dart';
import 'package:frenzy_store/presentation/main/pages/search/search_page.dart';
import 'package:frenzy_store/presentation/main/pages/settings/settings_page.dart';
import 'package:frenzy_store/presentation/resources/color_manager.dart';
import 'package:frenzy_store/presentation/resources/strings_manager.dart';
import 'package:frenzy_store/presentation/resources/values_manager.dart';

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

  final List<String> _titles = [
    AppStrings.home.tr(),
    AppStrings.search.tr(),
    AppStrings.notifications.tr(),
    AppStrings.settings.tr(),
  ];

  String _title = AppStrings.home.tr();
  int _currentPage = 0;
  late Text _appBarText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StatefulBuilder(
          builder: (context, state) {
            state(() {
              _appBarText = Text(
                _title,
                style: Theme.of(context).textTheme.titleMedium,
              );
            });
            return _appBarText;
          },
        ),
      ),
      body: _pages[_currentPage],
      bottomNavigationBar: StatefulBuilder(
        builder: (context, state) {
          return BottomNavigationBar(
            elevation: AppSize.s1_5,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            unselectedItemColor: ColorManager.grey,
            selectedItemColor: ColorManager.primary,
            currentIndex: _currentPage,
            onTap: (int index) {
              setState(() {
                _title = _titles[index];
              });
              state(() {
                _currentPage = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: const Icon(Icons.home_outlined),
                  label: AppStrings.home.tr()),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.search_outlined),
                  label: AppStrings.search.tr()),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.notifications_outlined),
                  label: AppStrings.notifications.tr()),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.settings_outlined),
                  label: AppStrings.settings.tr()),
            ],
          );
        },
      ),
    );
  }
}
