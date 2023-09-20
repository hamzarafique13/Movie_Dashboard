import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/model/genre_model/freezedcatagorymodel.dart';
import 'package:flutter_application_1/provider/genre_filter_provider.dart';
import 'package:flutter_application_1/services/firebase_movie_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/movie_model/freezedmoviemodel.dart';

final moviePageProvider =
    StateNotifierProvider<MovieProviderNotifier, List<DbMovieModel>>(
        (ref) => MovieProviderNotifier([], ref));
final fierstoredb = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;
final Firebaseservices _firebaseservices = Firebaseservices();

class MovieProviderNotifier extends StateNotifier<List<DbMovieModel>> {
  MovieProviderNotifier(List<DbMovieModel>? initialmovie, Ref ref)
      : _ref = ref,
        super(initialmovie ?? []);

  final Ref _ref;

  void addMovieToList(DbMovieModel movie) {
    state = [
      ...state,
      movie,
    ];
    _firebaseservices.addMovieToFirebase(movie);
  }

  void removeMovieList(DbMovieModel movie) async {
    //state.removeWhere((element) => element.id == )
    state = state.where((element) => element.id != movie.id).toList();
    await _firebaseservices.deleteMovieToFirebase(movie);
  }

  Future<void> fetchMovieFirebase() async {
    state = await _firebaseservices.fetchMoviesFromFirebase();
  }

  void updatedMovie(DbMovieModel movie) async {
    List<DbMovieModel> newlist = [...state];
    int index = newlist.indexWhere((element) => element.id == movie.id);
    if (index != -1) {
      newlist[index] = movie;
    }
    state = newlist;
    await _firebaseservices.updateMoviefirebase(movie);
  }

  void sortDecsendRatingWatchList() {
    List<DbMovieModel> sorting = [...state];
    sorting.sort((a, b) => b.rating.compareTo(a.rating));
    state = sorting;
  }

  void sortAccsendingRatingWatchList() {
    List<DbMovieModel> sorting = [...state];
    sorting.sort((a, b) => a.rating.compareTo(b.rating));
    state = sorting;
  }

  void searchByTheName(String name) async {
    state = await _firebaseservices.searchByName(name);
  }

  void register(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print(e);
    }
  }

  void login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e);
    }
  }

  void logoutMovie() async {
    await auth.signOut();
  }

  List<DbMovieModel> filterMoviesWithGenre(String genreName) {
    final filterdMovieList = [
      ...state.where((item) => item.genremovie == genreName).toList()
    ];
    // _ref.read(genrenamestateprovider.notifier).state = filterdMovieList;
    return filterdMovieList;
  }
}

// void searchByName(String name) {
  //   List<DbMovieModel> Search = [...state];

  //   Search.where((movie) => movie.name.contains(name)).toList();
  //   state = Search;
  // }

//  Future<List<Todo>> filterListNameAge(
//     String name,
//   ) async {
//     final isar = await db;
//     final tasks = await isar.todos.filter().nameBetween('a', 'z').findAll();
//     return tasks.where((task) => task.name.contains(name)).toList();
//   }
// Future<void> searchByName(String name) async {
  //   state = await isarServices.filterListNameAge(
  //     name,
  //   );
  // }