// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/genre_model/freezedcatagorymodel.dart';
import 'package:flutter_application_1/model/movie_model/freezedmoviemodel.dart';
import 'package:flutter_application_1/provider/genre_filter_provider.dart';
import 'package:flutter_application_1/provider/genre_movie_provider.dart';
import 'package:flutter_application_1/provider/movie_page_provider.dart';
import 'package:flutter_application_1/screens/create_movies/create_movie.dart';
import 'package:flutter_application_1/services/firebase_movie_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../provider/search_movie_with_state_provider.dart';

final searchboolProvider = StateProvider<bool>((ref) => false);
final genreNameListProvider = StateProvider<bool>((ref) => false);
final textFieltBoolProvider = StateProvider<bool>((ref) => false);

class MovieDashBord extends ConsumerStatefulWidget {
  const MovieDashBord({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MovieDashBordState();
}

class _MovieDashBordState extends ConsumerState<MovieDashBord> {
  TextEditingController searchcontroller = TextEditingController();

  bool isSearch = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      ref.read(moviePageProvider.notifier).fetchMovieFirebase();

      ref.read(genreNameProvider.notifier).fetchGenreNameFirebase();
    });
  }

  // List<DbMovieModel>? genreMovieList;
  List<DbMovieModel>? movieslist;

  @override
  Widget build(BuildContext context) {
    final searchBoolState = ref.watch(searchboolProvider);
    List<CatagoryModel> genreMovieNameList = ref.watch(genreNameProvider);
    var genreNameList = ref.watch(genrenameProvider);
    final genreboolstateprovider = ref.watch(genreNameListProvider);

    if (!searchBoolState && !genreboolstateprovider) {
      movieslist = ref.watch(moviePageProvider);
    } else if (!searchBoolState && genreboolstateprovider) {
      movieslist = ref.watch(filteredGenreMoviesProvider);
    } else {
      movieslist =
          ref.watch(searchBoolState ? searchmoviesprovider : moviePageProvider);
    }

    // final DataTableSource data =
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 144, 138, 160),
        title: const Center(child: Text('Movies')),
        actions: [
          PopupMenuButton(
              child: const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(Icons.sort),
              ),
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: const Text(
                        'top rating',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      onTap: () {
                        ref
                            .read(moviePageProvider.notifier)
                            .sortDecsendRatingWatchList();
                        // studentProvider!.sortListDecsendingAge();
                      },
                    ),
                    PopupMenuItem(
                      child: const Text(
                        'low rating',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ),
                      onTap: () {
                        // studentProvider!.sortAccsendingListAge();
                        ref
                            .read(moviePageProvider.notifier)
                            .sortAccsendingRatingWatchList();
                      },
                    ),
                  ])
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          verticalDirection: VerticalDirection.down,
          children: [
            const SizedBox(
              height: 30,
            ),
            PaginatedDataTable(
              source: MyData(
                movies: movieslist,
                ref: ref,
                filter: 'name',
              ),
              header: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        margin: const EdgeInsets.only(left: 30),
                        width: 400,
                        height: 50,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 7,
                                offset: const Offset(1, 1),
                                color: Colors.grey.withOpacity(0.2))
                          ],
                        ),
                        child: TextField(
                          style: const TextStyle(color: Colors.black),
                          controller: searchcontroller,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.white,
                                width: 1.0,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                searchcontroller.clear();
                                ref.read(searchboolProvider.notifier).state =
                                    false;
                              },
                              icon:
                                  const Icon(Icons.clear, color: Colors.black),
                            ),
                            labelText: 'Filter by Name',
                            labelStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                          onChanged: (value) {
                            ref.read(textFieltBoolProvider.notifier).state =
                                true;
                            final modifiedText = value.capitalizeFirstLetter();
                            if (value != modifiedText) {
                              searchcontroller.value = TextEditingValue(
                                text: modifiedText,
                                selection: TextSelection.collapsed(
                                    offset: modifiedText.length),
                              );
                            }
                          },
                        )),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  TextButton(
                    child: const Text('Show Name'),
                    onPressed: () async {
                      final searchedMoviesData = await Firebaseservices()
                          .searchByName(searchcontroller.text);
                      ref.read(searchmoviesprovider.notifier).state =
                          searchedMoviesData;
                      ref.read(searchboolProvider.notifier).state = true;
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 400,
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 7,
                              offset: const Offset(1, 1),
                              color: Colors.grey.withOpacity(0.2))
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton<CatagoryModel>(
                          underline: const SizedBox(),
                          value:
                              genreNameList, // Set your default value or null here initially
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: [
                            const DropdownMenuItem<CatagoryModel>(
                              value: null,
                              child: Text('Filter by Genre'),
                            ),
                            ...genreMovieNameList.map((CatagoryModel genre) {
                              return DropdownMenuItem<CatagoryModel>(
                                value: genre,
                                child: Text(genre.genre),
                              );
                            }),
                          ],
                          onChanged: (newValue) {
                            if (newValue != null) {
                              genreNameList = newValue;
                              ref.read(genrenameProvider.notifier).state =
                                  newValue;
                              ref.read(genreNameListProvider.notifier).state =
                                  true;

                              final filteredMovies = ref
                                  .read(moviePageProvider.notifier)
                                  .filterMoviesWithGenre(newValue.genre);
                              ref
                                  .read(filteredGenreMoviesProvider.notifier)
                                  .state = filteredMovies;
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  TextButton(
                    child: const Text('Clear All Filter'),
                    onPressed: () async {
                      ref.read(genreNameListProvider.notifier).state = false;
                    },
                  ),
                ],
              ),
              columns: const [
                DataColumn(
                    label: Text(
                  'Name',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                )),
                DataColumn(
                    label: Text('Rating',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600))),
                DataColumn(
                    label: Text('Genre',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600))),
                DataColumn(
                    label: Text('Release date',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600))),
                DataColumn(
                    label: Text('Time',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600))),
              ],
              columnSpacing: 100,
              horizontalMargin: 220,
              rowsPerPage: 5,
              showCheckboxColumn: false,
            ),
          ],
        ),
      ),
    );
  }
}

// The "soruce" of the table
class MyData extends DataTableSource {
  final MovieProviderNotifier? movieProviderNotifier;
  final GenreNameProviderNotifier? genreMovieProviderNotifier;
  final WidgetRef ref;
  String filter;
  final List<DbMovieModel>? movies;
  // final List<DbMovieModel>? genreMovies;
  MyData({
    this.movieProviderNotifier,
    this.genreMovieProviderNotifier,
    required this.ref,
    required this.filter,
    this.movies,
    // this.genreMovies,
  });

  // bool isSearch = false;

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount =>
      //  (isSearch) ? movies!.length : searchByTheName.length;
      movies?.length ?? 0;
  @override
  int get selectedRowCount => 0;
  @override
  DataRow getRow(int index) {
    if (movies != null && index < movies!.length) {
      return DataRow(cells: [
        // DataCell(Text(movies![index].image)),
        // DataCell(ClipRRect(
        //   borderRadius: BorderRadius.circular(50),
        //   child: SizedBox(
        //     height: 50,
        //     width: 50,
        //     child: Image.network(
        //       movies![index].image,
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        // )),
        DataCell(Text(movies![index].name)),
        DataCell(
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
                movies![index].rating,
                style: const TextStyle(
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    color: Color(0xffFF8700)),
              )
            ],
          ),
        ),
        DataCell(Text(movies![index].genremovie)),

        DataCell(Text(DateFormat("MMMM dd yyyy").format(movies![index].date))),
        DataCell(Text(
          DateFormat.Hm().format(
            DateFormat("HH:mm").parse(movies![index].time),
          ),
        ))
        //   ),
        // )
      ]);
    } else {
      return const DataRow(cells: [
        DataCell(Text('')),
      ]);
    }
  }
}
