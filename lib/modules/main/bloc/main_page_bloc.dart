import 'package:ateba_app/modules/categories/ui/page/categories_page.dart';
import 'package:ateba_app/modules/home/ui/page/home_page.dart';
import 'package:ateba_app/modules/profile/ui/page/profile_page.dart';
import 'package:flutter/material.dart';

final List<Widget> pages = <Widget>[
  const HomePage(),
  const Text(
    'Search Page',
  ),
  const CategoriesPage(),
  const Text(
    'Archive Page',
  ),
  const ProfilePage()
];

class MainPageBloc extends ChangeNotifier {
  factory MainPageBloc() => _instance;
  MainPageBloc._init();
  static final MainPageBloc _instance = MainPageBloc._init();

  int _pageIndex = 0;

  void resetPageIndex() {
    _pageIndex = 0;
    notifyListeners();
  }

  int get pagesCount => pages.length;
  Widget get page => pages.elementAt(_pageIndex);
  int get pageIndex => _pageIndex;

  void changePage(int index) {
    if (index != _pageIndex) {
      _pageIndex = index;
      notifyListeners();
    }
  }
}
