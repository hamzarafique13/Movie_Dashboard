import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/services/firebase_movie_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/freezedmoviemodel.dart';

final moviepageProvider =
    StateNotifierProvider<MovieProviderNotifier, List<DbMovieModel>>(
        (ref) => MovieProviderNotifier(
              [],
            ));

final fierstoredb = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;
final Firebaseservices _firebaseservices = Firebaseservices();

class MovieProviderNotifier extends StateNotifier<List<DbMovieModel>> {
  MovieProviderNotifier([List<DbMovieModel>? initialmovie])
      : super(initialmovie ?? []);

  void addMovieToList(DbMovieModel movie) {
    state = [
      ...state,
      movie,
    ];
    _firebaseservices.addToFirebase(movie);
  }

  void removeList(DbMovieModel movie) async {
    //state.removeWhere((element) => element.id == )
    state = state.where((element) => element.id != movie.id).toList();
    await _firebaseservices.deletefirebase(movie);
  }

  Future<void> fetchFirebase() async {
    state = await _firebaseservices.fetchMovieFromFirebase();
  }

  void updatedMovie(DbMovieModel movie) {
    List<DbMovieModel> newlist = [...state];
    int index = newlist.indexWhere((element) => element.id == movie.id);
    if (index != -1) {
      newlist[index] = movie;
    }
    state = newlist;
  }
}
