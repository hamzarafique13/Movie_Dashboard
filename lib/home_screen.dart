import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/create_movie.dart';
import 'package:flutter_application_1/model/freezedmoviemodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'provider/movie_page_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      ref.read(moviepageProvider.notifier).fetchFirebase();
    });
  }

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<DbMovieModel> movies = ref.watch(moviepageProvider);
    return Scaffold(
      backgroundColor: const Color(0xff1E1E1E),
      body: Row(
        children: [
          NavigationRail(
            backgroundColor: Colors.brown,
            selectedIndex: selectedIndex,
            labelType: NavigationRailLabelType.selected,
            selectedLabelTextStyle: const TextStyle(color: Colors.white),
            selectedIconTheme: const IconThemeData(color: Colors.white),
            onDestinationSelected: (index) {
              setState(() {
                selectedIndex = index;
                pageController.animateToPage(index,
                    duration: const Duration(milliseconds: 50),
                    curve: Curves.easeInOut);
              });
            },
            destinations: const [
              NavigationRailDestination(
                  icon: Icon(Icons.home), label: Text('Home')),
              NavigationRailDestination(
                  icon: Icon(Icons.movie), label: Text('Movie')),
              NavigationRailDestination(
                  icon: Icon(Icons.tv), label: Text('Tv Show')),
            ],
          ),
          Expanded(
            child: (movies.isEmpty)
                ? Center(
                    child: Container(
                      child: const Text(
                        'No List found',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  )
                : PageView(
                    controller: pageController,
                    children: [
                      Container(
                        child: GridView.builder(
                          itemCount: movies.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 2 / 1,
                                  crossAxisCount: 1),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 20, top: 24),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Stack(children: [
                                        Container(
                                          height: 130,
                                          width: 100,
                                          child: Image.network(
                                            movies[index].image,
                                            fit: BoxFit.cover,
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
                                                        title: Text(
                                                            'Are you sure you want to delete'),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text(
                                                                  'Cancel')),
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                                ref
                                                                    .read(moviepageProvider
                                                                        .notifier)
                                                                    .removeList(
                                                                        movies[
                                                                            index]);
                                                              },
                                                              child: Text(
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
                                            icon: Icon(
                                              Icons.clear,
                                              color: Colors.black,
                                              size: 20,
                                            ),
                                          ),
                                        )
                                      ]),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        child: Text(
                                          movies[index].title,
                                          style: const TextStyle(
                                              color: Color(0xffFFFFFF),
                                              fontSize: 16,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 200,
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
                                      Row(
                                        children: const [
                                          Icon(
                                            Icons.movie_sharp,
                                            color: Color(0xffFFFFFF),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            'Action',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xffFFFFFF)),
                                          )
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
                                      Row(
                                        children: const [
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
                      Container(
                        child: (movies.isNotEmpty)
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
                            : Container(),
                      ),
                      Container(
                        child: (movies.isNotEmpty)
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
                            : Container(),
                      ),
                    ],
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => CreateMovie(),
            ),
          );
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
