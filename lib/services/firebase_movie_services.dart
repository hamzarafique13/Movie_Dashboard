import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/model/freezedmoviemodel.dart';

class Firebaseservices {
  final _fierstoredb = FirebaseFirestore.instance;
  final String _moviecollection = 'movie';

  Future<void> addToFirebase(DbMovieModel movie) async {
    await _fierstoredb
        .collection(_moviecollection)
        .doc(movie.id)
        .set(movie.toJson());
  }

  Future<void> deletefirebase(DbMovieModel movie) async {
    await _fierstoredb.collection(_moviecollection).doc(movie.id).delete();
  }

  Future<List<DbMovieModel>> fetchMovieFromFirebase() async {
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

  // Future<List<Student>>? fetchstudentFromFirebase() async {
  //   try {
  //     List<Student> student = [];
  //     var snapshot = await fierstoredb.collection('students').get();
  //     for (var data in snapshot.docs) {
  //       _studentlist.add(Student.fromJson(data.data()));
  //       student.add(Student.fromJson(data.data()));
  //     }
  //     notifyListeners();
  //     return student;
  //   } catch (e) {
  //     print(e);
  //     return [];
  //   }
  // }

  // Future<void> deletefirebase(Student student) async {
  //   await fierstoredb.collection('students').doc(student.id).delete();
  //   notifyListeners();
  // }
}
