import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/genre_model/freezedcatagorymodel.dart';
import 'package:flutter_application_1/model/movie_model/freezedmoviemodel.dart';
import 'package:flutter_application_1/provider/genre_movie_provider.dart';
import 'package:flutter_application_1/screens/create_movies/create_movie.dart';
// import 'package:flutter_application_1/screens/genre_name_home_screen.dart';
import 'package:flutter_application_1/screens/genre_screen/create_genre/create_genre_name.dart';
import 'package:flutter_application_1/screens/genre_screen/home_genre/genre_name_home_screen.dart';
import 'package:flutter_application_1/screens/log_in/login_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';

import '../../provider/movie_page_provider.dart';
import '../movie_dashbord/movie_dashbord_table.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      ref.read(moviePageProvider.notifier).fetchMovieFirebase();
    });
  }

  final _Pagesdata = [
    const HomeScreen(),
    MovieDashBord(),
    const GenreHomeScreen()
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<DbMovieModel> movies = ref.watch(moviePageProvider);
    List<CatagoryModel> genremovie = ref.watch(genreNameProvider);

    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          onPressed: () {
            ref.read(moviePageProvider.notifier).logoutMovie();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Login(),
              ),
            );
          },
          icon: const Icon(Icons.logout),
          color: Colors.black,
        ),
      ]),
      backgroundColor: const Color(0xff1E1E1E),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return (constraints.maxWidth < 500)
              ? Row(
                  children: [
                    NavigationRail(
                      backgroundColor: Colors.blue,
                      selectedIndex: selectedIndex,
                      labelType: NavigationRailLabelType.selected,
                      selectedLabelTextStyle:
                          const TextStyle(color: Colors.white),
                      selectedIconTheme:
                          const IconThemeData(color: Colors.white),
                      onDestinationSelected: (newvalue) {
                        setState(() {
                          selectedIndex = newvalue;
                          pageController.animateToPage(newvalue,
                              duration: const Duration(milliseconds: 50),
                              curve: Curves.easeInOut);
                        });
                      },
                      destinations: const [
                        NavigationRailDestination(
                            icon: Icon(Icons.home), label: Text('Home')),
                        NavigationRailDestination(
                            icon: Icon(Icons.dashboard),
                            label: Text('Dashboard')),
                        NavigationRailDestination(
                            icon: Icon(Icons.tv), label: Text('Genre Movie')),
                      ],
                    ),
                    Expanded(
                      child: (movies.isEmpty)
                          ? const Center(
                              child: Text(
                                '',
                                // 'No List found',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            )
                          : GridView.builder(
                              itemCount: movies.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 30,
                                      childAspectRatio: 2 / 1,
                                      crossAxisCount: 1),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5, top: 14),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          Stack(children: [
                                            Container(
                                              height: 120,
                                              width: 100,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            CreateMovie(
                                                          movie: movies[index],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: Image.network(
                                                    movies[index].image,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: -10,
                                              right: -10,
                                              child: IconButton(
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return Container(
                                                        child: AlertDialog(
                                                            title: const Text(
                                                                'Are you sure you want to delete'),
                                                            actions: [
                                                              TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: const Text(
                                                                      'Cancel')),
                                                              TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                    ref
                                                                        .read(moviePageProvider
                                                                            .notifier)
                                                                        .removeMovieList(
                                                                            movies[index]);
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                    'Delete',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .red),
                                                                  ))
                                                            ]),
                                                      );
                                                    },
                                                  );
                                                },
                                                icon: const Icon(
                                                  Icons.clear,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                              ),
                                            )
                                          ]),
                                          const SizedBox(
                                            width: 10,
                                          ),

                                          // readMoreText: 'show more',
                                          // readLessText: 'show less',
                                          // trim: 2,
                                          // linkTextStyle: TextStyle(
                                          //     color: Colors.blue)),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 100,
                                            child: Text(
                                              movies[index].name,
                                              style: const TextStyle(
                                                  color: Color(0xffFFFFFF),
                                                  fontSize: 16,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.star_border,
                                                color: Color(0xffFF8700),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                movies[index].rating,
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xffFF8700)),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          // Row(
                                          //   children: [
                                          //     const Icon(
                                          //       Icons.movie_sharp,
                                          //       color: Color(0xffFFFFFF),
                                          //     ),
                                          //     const SizedBox(
                                          //       width: 5,
                                          //     ),
                                          //     Text(
                                          //       genremovie[index].genre,
                                          //       style: const TextStyle(
                                          //           color:
                                          //               Color(0xffFFFFFF),
                                          //           fontSize: 16,
                                          //           fontFamily: 'Poppins',
                                          //           fontWeight:
                                          //               FontWeight.w400),
                                          //       overflow:
                                          //           TextOverflow.ellipsis,
                                          //     ),
                                          //   ],
                                          // ),
                                          // const SizedBox(
                                          //   height: 4,
                                          // ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.calendar_month_outlined,
                                                color: Color(0xffFFFFFF),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                DateFormat("MMMM dd yyyy")
                                                    .format(movies[index].date),
                                                style: const TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xffFFFFFF)),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          const Row(
                                            children: [
                                              Icon(
                                                Icons.timer,
                                                color: Color(0xffFFFFFF),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                '139 minutes',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xffFFFFFF)),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                    ),
                    (movies.isEmpty)
                        ? Center(
                            child: Container(
                              child: const Text(
                                'No Movie found',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ),
                          )
                        : MovieDashBord(),
                    (genremovie.isEmpty)
                        ? Center(
                            child: Container(
                              child: const Text(
                                'No Tv found',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ),
                          )
                        : const GenreHomeScreen(),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  verticalDirection: VerticalDirection.down,
                  children: [
                    NavigationRail(
                      backgroundColor: Colors.blue,
                      selectedIndex: selectedIndex,
                      labelType: NavigationRailLabelType.selected,
                      selectedLabelTextStyle:
                          const TextStyle(color: Colors.white),
                      selectedIconTheme:
                          const IconThemeData(color: Colors.white),
                      onDestinationSelected: (newvalue) {
                        setState(() {
                          selectedIndex = newvalue;
                          // pageController.animateToPage(newvalue,
                          //     duration: const Duration(milliseconds: 50),
                          //     curve: Curves.easeInOut);
                        });
                      },
                      destinations: const [
                        NavigationRailDestination(
                            icon: Icon(Icons.home), label: Text('Home')),
                        NavigationRailDestination(
                            icon: Icon(Icons.dashboard),
                            label: Text('Dashboard')),
                        NavigationRailDestination(
                            icon: Icon(Icons.tv), label: Text('Genre Movie')),
                      ],
                    ),
                    Expanded(
                      child: (movies.isEmpty)
                          ? const Center(
                              child: Text(
                                'No List found',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            )
                          : GridView.builder(
                              itemCount: movies.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 10,
                                      childAspectRatio: 3 / 2,
                                      crossAxisCount: 3),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.only(left: 20, top: 24),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CreateMovie(
                                            movie: movies[index],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          children: [
                                            Stack(children: [
                                              Container(
                                                height: 130,
                                                width: 100,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.network(
                                                    movies[index].image,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: -10,
                                                right: -10,
                                                child: IconButton(
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return Container(
                                                          child: AlertDialog(
                                                              title: const Text(
                                                                  'Are you sure you want to delete'),
                                                              actions: [
                                                                TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: const Text(
                                                                        'Cancel')),
                                                                TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                      ref
                                                                          .read(moviePageProvider
                                                                              .notifier)
                                                                          .removeMovieList(
                                                                              movies[index]);
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                      'Delete',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.red),
                                                                    ))
                                                              ]),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  icon: const Icon(
                                                    Icons.clear,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                ),
                                              )
                                            ]),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 100,
                                              child: Text(
                                                movies[index].name,
                                                style: const TextStyle(
                                                    color: Color(0xffFFFFFF),
                                                    fontSize: 16,
                                                    fontFamily: 'Poppins',
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.star_border,
                                                  color: Color(0xffFF8700),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  movies[index].rating,
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xffFF8700)),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.movie_sharp,
                                                  color: Color(0xffFFFFFF),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  movies[index].genremovie,
                                                  style: const TextStyle(
                                                      color: Color(0xffFFFFFF),
                                                      fontSize: 16,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.calendar_month_outlined,
                                                  color: Color(0xffFFFFFF),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  DateFormat("MMMM dd yyyy")
                                                      .format(
                                                          movies[index].date),
                                                  style: const TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color(0xffFFFFFF)),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            const Row(
                                              children: [
                                                Icon(
                                                  Icons.timer,
                                                  color: Color(0xffFFFFFF),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  '139 minutes',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Color(0xffFFFFFF)),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),

                      // MovieDashBord(),
                    ),
                    (movies.isNotEmpty)
                        ? const Center(
                            child: Text(
                              'No Movie found',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          )
                        : MovieDashBord(),
                    (genremovie.isEmpty)
                        ? const Center(
                            child: Text(
                              'No Genre found',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          )
                        : const GenreHomeScreen(),
                  ],
                );
        },
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: const IconThemeData(size: 22),
        backgroundColor: const Color(0xFF801E48),
        visible: true,
        curve: Curves.bounceIn,
        children: [
          // FAB 1
          SpeedDialChild(
            child: const Icon(Icons.add),
            backgroundColor: const Color(0xFF801E48),
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
            labelBackgroundColor: const Color(0xFF801E48),
          ),
          // FAB 2
          SpeedDialChild(
            child: const Icon(Icons.movie_edit),
            backgroundColor: const Color(0xFF801E48),
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
            labelBackgroundColor: const Color(0xFF801E48),
          ),
        ],
      ),
    );
  }
}
