import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/state_provider.dart';
import 'package:flutter_application_1/screens/genre_screen/create_genre/create_genre_name.dart';
import 'package:flutter_application_1/screens/create_movies/create_movie.dart';
import 'package:flutter_application_1/screens/genre_screen/home_genre/genre_name_home_screen.dart';
import 'package:flutter_application_1/screens/movie_home_screen/movie_home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../movie_dashbord/movie_dashbord_table.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  // PageController pageController = PageController();

  final _Pagesdata = [
    const MovieHomeScreen(),
    MovieDashBord(),
    const GenreHomeScreen()
  ];

  @override
  Widget build(BuildContext context) {
    final indexpageprovider = ref.watch(indexProvider);
    return Scaffold(
      // appBar: AppBar(actions: [
      //   IconButton(
      //     onPressed: () {
      //       ref.read(moviepageProvider.notifier).logoutMovie();
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => const Login(),
      //         ),
      //       );
      //     },
      //     icon: const Icon(Icons.logout),
      //     color: Colors.black,
      //   ),
      // ]),
      backgroundColor: const Color(0xff1E1E1E),
      body: Row(
        children: [
          NavigationRail(
            backgroundColor: Color.fromARGB(255, 144, 138, 160),
            selectedIndex: indexpageprovider,
            labelType: NavigationRailLabelType.selected,
            selectedLabelTextStyle: const TextStyle(color: Colors.white),
            selectedIconTheme: const IconThemeData(color: Colors.white),
            onDestinationSelected: (newvalue) {
              ref.read(indexProvider.notifier).state = newvalue;
            },
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.dashboard),
                label: Text('Dashboard'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.tv),
                label: Text('Genre Movie'),
              ),
            ],
          ),
          Expanded(
            child: _Pagesdata[indexpageprovider],
          ),
        ],
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: const IconThemeData(size: 22),
        backgroundColor: Color.fromARGB(255, 144, 138, 160),
        visible: true,
        curve: Curves.bounceIn,
        children: [
          // FAB 1
          SpeedDialChild(
            child: const Icon(Icons.add),
            backgroundColor: Color.fromARGB(255, 144, 138, 160),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => CreateMovie(),
                ),
              );
            },
            label: 'Add movie',
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 16.0,
            ),
            labelBackgroundColor: Color.fromARGB(255, 144, 138, 160),
          ),
          // FAB 2
          SpeedDialChild(
            child: const Icon(Icons.movie_edit),
            backgroundColor: Color.fromARGB(255, 144, 138, 160),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => CreateGenreMovies(),
                ),
              );
            },
            label: 'Add genre',
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 16.0,
            ),
            labelBackgroundColor: Color.fromARGB(255, 144, 138, 160),
          ),
        ],
      ),
    );
  }
}
