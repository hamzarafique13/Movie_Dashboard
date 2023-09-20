import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/genre_model/freezedcatagorymodel.dart';
import 'package:flutter_application_1/provider/genre_movie_provider.dart';
import 'package:flutter_application_1/screens/genre_screen/create_genre/create_genre_name.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GenreHomeScreen extends ConsumerStatefulWidget {
  const GenreHomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GenreHomeScreenState();
}

class _GenreHomeScreenState extends ConsumerState<GenreHomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      ref.read(genreNameProvider.notifier).fetchGenreNameFirebase();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<CatagoryModel> genremovie = ref.watch(genreNameProvider);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 144, 138, 160),
          title: const Center(child: Text('Genres'))),
      // backgroundColor: Colors.black,
      body: Column(children: [
        SizedBox(
          height: 500,
          width: 200,
          child: ListView.builder(
              // scrollDirection: Axis.vertical,
              itemCount: genremovie.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: Container(
                          height: 50,
                          width: 400,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          margin: const EdgeInsets.all(10),
                          child: GestureDetector(
                            child: Text(
                              genremovie[index].genre,
                              style: const TextStyle(
                                  color: Color(0xffFFFFFF),
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400),
                            ),
                            onLongPress: () {
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
                                                  .read(genreNameProvider
                                                      .notifier)
                                                  .removeGenreName(
                                                      genremovie[index]);
                                            },
                                            child: const Text(
                                              'Delete',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ))
                                      ]);
                                },
                              );
                            },
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateGenreMovies(
                                genrename: genremovie[index],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }),
        )
      ]),
    );
  }
}
