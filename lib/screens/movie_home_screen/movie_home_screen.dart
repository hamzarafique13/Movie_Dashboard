import 'package:date_time/date_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/genre_model/freezedcatagorymodel.dart';
import 'package:flutter_application_1/model/movie_model/freezedmoviemodel.dart';
import 'package:flutter_application_1/provider/movie_page_provider.dart';
import 'package:flutter_application_1/screens/create_movies/create_movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../provider/genre_movie_provider.dart';

class MovieHomeScreen extends ConsumerStatefulWidget {
  const MovieHomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MovieHomeScreenState();
}

class _MovieHomeScreenState extends ConsumerState<MovieHomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      ref.read(moviePageProvider.notifier).fetchMovieFirebase();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<DbMovieModel> movies = ref.watch(moviePageProvider);
    List<CatagoryModel> genremovie = ref.watch(genreNameProvider);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 144, 138, 160),
          title: const Center(child: Text('Movies Home'))),
      backgroundColor: Colors.black,
      body: (movies.isEmpty)
          ? const Center(
              child: Text(
                'No List',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            )
          : GridView.builder(
              itemCount: movies.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 10,
                  childAspectRatio: 3 / 2,
                  crossAxisCount: 3),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20, top: 24),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Stack(children: [
                              SizedBox(
                                height: 130,
                                width: 100,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
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
                                        return AlertDialog(
                                            title: const Text(
                                                'Are you sure you want to delete'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('Cancel')),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    ref
                                                        .read(moviePageProvider
                                                            .notifier)
                                                        .removeMovieList(
                                                            movies[index]);
                                                  },
                                                  child: const Text(
                                                    'Delete',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ))
                                            ]);
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
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
                                      fontWeight: FontWeight.w400),
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
                              children: [
                                const Icon(
                                  Icons.timer,
                                  color: Color(0xffFFFFFF),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  DateFormat.Hm().format(
                                    DateFormat("HH:mm")
                                        .parse(movies[index].time),
                                  ),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xffFFFFFF),
                                  ),
                                ),
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
    );
  }
}
