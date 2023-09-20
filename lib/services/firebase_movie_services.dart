import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/model/genre_model/freezedcatagorymodel.dart';
import 'package:flutter_application_1/model/movie_model/freezedmoviemodel.dart';

class Firebaseservices {
  final _fierstoredb = FirebaseFirestore.instance;
  final String _moviecollection = 'movie';
  final String _genrecollection = 'genremovie';

  Future<void> addMovieToFirebase(DbMovieModel movie) async {
    try {
      await _fierstoredb
          .collection(_moviecollection)
          .doc(movie.id)
          .set(movie.toJson());
      print('Document added successfully');
    } catch (e) {
      print('Error adding document: $e');
    }
  }

  Future<void> deleteMovieToFirebase(DbMovieModel movie) async {
    await _fierstoredb.collection(_moviecollection).doc(movie.id).delete();
  }

  Future<List<DbMovieModel>> fetchMoviesFromFirebase() async {
    try {
      List<DbMovieModel> movie = [];
      var snapshot = await _fierstoredb.collection(_moviecollection).get();
      for (var data in snapshot.docs) {
        movie.add(DbMovieModel.fromJson(data.data()));
        // movie.add(DbMovieModel.fromJson(data.data()));
      }
      return movie;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> updateMoviefirebase(DbMovieModel movie) async {
    await _fierstoredb
        .collection(_moviecollection)
        .doc(movie.id)
        .update(movie.toJson());
  }

  Future<List<DbMovieModel>> searchByName(String name) async {
    final result = await _fierstoredb
        .collection(_moviecollection)
        .where('name', isEqualTo: name)
        .get();

    final searchResultList =
        result.docs.map((doc) => DbMovieModel.fromJson(doc.data())).toList();

    return searchResultList;
  }

  Future<void> addGenreToFirebase(CatagoryModel genre) async {
    try {
      await _fierstoredb
          .collection(_genrecollection)
          .doc(genre.id)
          .set(genre.toJson());
      print('Document added successfully');
    } catch (e) {
      print('Error adding document: $e');
    }
  }

  Future<List<CatagoryModel>> fetchGenreNameFromFirebase() async {
    try {
      List<CatagoryModel> movie = [];
      var snapshot = await _fierstoredb.collection(_genrecollection).get();
      for (var data in snapshot.docs) {
        movie.add(CatagoryModel.fromJson(data.data()));
        // movie.add(DbMovieModel.fromJson(data.data()));
      }
      return movie;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> deleteGenreNameFirebase(CatagoryModel genre) async {
    await _fierstoredb.collection(_genrecollection).doc(genre.id).delete();
  }

  Future<void> updateGenreNamefirebase(CatagoryModel genre) async {
    await _fierstoredb
        .collection(_genrecollection)
        .doc(genre.id)
        .update(genre.toJson());
  }

  // Future<List<DbMovieModel>> searchByGenreName(String name) async {
  //   final result = await _fierstoredb
  //       .collection(_moviecollection)
  //       .where('name', isEqualTo: name)
  //       .get();

  //   final searchResultList =
  //       result.docs.map((doc) => DbMovieModel.fromJson(doc.data())).toList();

  //   return searchResultList;
  // }
}
