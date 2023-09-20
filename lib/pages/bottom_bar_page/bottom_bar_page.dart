import 'package:flutter/material.dart';
import 'package:movie_app_use_riverpod/pages/home_page/home_page.dart';
import 'package:movie_app_use_riverpod/pages/search_page/search_page.dart';
import 'package:movie_app_use_riverpod/pages/watch_list_page/watch_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ignore: non_constant_identifier_names
  final _Pagesdata = [
    const MoviesPage(),
    const SearchPage(),
    const WatchPage()
  ];
  int _selectedItem = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _Pagesdata[_selectedItem],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0xff242A32),
          unselectedItemColor: const Color(0xff67686D),
          unselectedFontSize: 12,
          selectedFontSize: 12,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              activeIcon: Image.asset(
                'assets/images/Home6.png',
              ),
              icon: Image.asset(
                "assets/images/Home3.png",
                color: const Color(0xff67686D),
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
                activeIcon: Image.asset('assets/images/Search.png'),
                icon: Image.asset("assets/images/Search1.png"),
                label: "Search"),
            BottomNavigationBarItem(
                activeIcon: Image.asset('assets/images/Path1.png'),
                icon: Image.asset("assets/images/Path2.png"),
                label: "Watch list"),
          ],
          currentIndex: _selectedItem,
          onTap: (setValue) {
            setState(() {
              _selectedItem = setValue;
            });
          },
        ));
  }
}
