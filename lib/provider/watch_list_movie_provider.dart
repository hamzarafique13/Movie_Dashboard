import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app_use_riverpod/model/dbmoviemodel.dart';
import 'package:movie_app_use_riverpod/model/moviesmodel.dart';
import 'package:movie_app_use_riverpod/services/isar_services.dart';
import 'package:collection/collection.dart';

final watchListmoviePageProvider =
    ChangeNotifierProvider<WatchListNotifier>((ref) {
  return WatchListNotifier();
});

class WatchListNotifier extends ChangeNotifier {
  List<DbMovieModel> _watchlist = [];
  final isarServices = IsarServices();

  List<DbMovieModel> get watchlist => _watchlist;

  void addToWatchList(DbMovieModel movie) {
    _watchlist.add(movie);
    isarServices.addMovieToIsar(movie);
    notifyListeners();
  }

  void fetchWatchListIsar() async {
    _watchlist = await isarServices.fetchDataWatchListFormIsar();
  }

  void removeMovieToWatchList(DbMovieModel movie) {
    _watchlist.remove(movie);
    isarServices.deleteMovieFromIsar(movie);
    notifyListeners();
  }

  void sortDecsendRatingWatchList() {
    _watchlist.sort((a, b) => b.rating!.compareTo(a.rating!));
    notifyListeners();
  }

  void sortAccsendingRatingWatchList() {
    _watchlist.sort((a, b) => a.rating!.compareTo(b.rating!));
    notifyListeners();
  }

  bool checkMovieAddOrNotToList(int id) {
    DbMovieModel? movie = _watchlist.firstWhereOrNull(
      (element) => element.id == id,
    );
    notifyListeners();
    if (movie == null) {
      return false;
    } else {
      return true;
    }
  }

  // bool checkMovieAddOrNotToList(int id) {
  //   return _watchlist.any((element) => element.id == id);
  // }

  // void removeMovieFromIsar(DbMovieModel movie) async {
  //   await isarServices.deleteMovieFromIsar(movie);
  // }

  // Future<void> fetchFromIsar() async {
  //   state = await isarServices.fetchDataIsar();
  // }

  // void addTaskList(MovieModel movie) {
  //   state = [
  //     ...state,
  //     task,
  //   ];
  //   isarServices.fetchDataIsar(movie);
  // }
}
