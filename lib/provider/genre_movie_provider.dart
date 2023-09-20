import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/model/genre_model/freezedcatagorymodel.dart';
import 'package:flutter_application_1/services/firebase_movie_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final genreNameProvider =
    StateNotifierProvider<GenreNameProviderNotifier, List<CatagoryModel>>(
        (ref) => GenreNameProviderNotifier(
              [],
            ));

final fierstoredb = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;
final Firebaseservices _firebaseservices = Firebaseservices();

class GenreNameProviderNotifier extends StateNotifier<List<CatagoryModel>> {
  GenreNameProviderNotifier([List<CatagoryModel>? initialmovie])
      : super(initialmovie ?? []);

  void addGeneraNameToList(CatagoryModel generamovie) {
    state = [
      ...state,
      generamovie,
    ];
    _firebaseservices.addGenreToFirebase(generamovie);
  }

  Future<void> fetchGenreNameFirebase() async {
    state = await _firebaseservices.fetchGenreNameFromFirebase();
  }

  void removeGenreName(CatagoryModel genre) async {
    state = state.where((element) => element.id != genre.id).toList();
    await _firebaseservices.deleteGenreNameFirebase(genre);
  }

  void updatedGenreName(CatagoryModel genre) async {
    List<CatagoryModel> newlist = [...state];
    int index = newlist.indexWhere((element) => element.id == genre.id);
    if (index != -1) {
      newlist[index] = genre;
    }
    state = newlist;
    await _firebaseservices.updateGenreNamefirebase(genre);
  }
}
