import 'package:isar/isar.dart';
import 'package:movie_app_use_riverpod/model/dbmoviemodel.dart';
import 'package:movie_app_use_riverpod/model/model.dart';
import 'package:path_provider/path_provider.dart';

class IsarServices {
  late Future<Isar> db;

  IsarServices() {
    db = openDB();
  }

  Future<void> addMovieToIsar(DbMovieModel movie) async {
    final isar = await db;
    isar.writeTxnSync(() => isar.dbMovieModels.putSync(movie));
  }

  Future<Isar> openDB() async {
    final appDirectory = await getApplicationDocumentsDirectory();
    final dbPath = appDirectory.path;
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([MovieModelSchema, DbMovieModelSchema],
          directory: dbPath);
    }
    return await Future.value(Isar.getInstance());
  }

  void saveMoviesToIsar(List<MovieModel> movies) async {
    final isar = await db;
    isar.writeTxn(() async {
      isar.movieModels.putAll(movies).then(
            (value) => print(movies),
          );
    });
  }

  Future<List<MovieModel>> fetchDataIsar() async {
    final isar = await db;
    return await isar.movieModels.where().findAll();
  }

  // Future<void> watchListMovieSaveToIsar(MovieModel movies) async {
  //   final isar = await db;
  //   isar.writeTxn(() async {
  //     isar.movieModels.putAll(movies).then(
  //           (value) => print(movies),
  //         );
  //   });
  // }

  Future<List<DbMovieModel>> fetchDataWatchListFormIsar() async {
    final isar = await db;
    return await isar.dbMovieModels.where().findAll();
  }

  Future<void> deleteMovieFromIsar(DbMovieModel movie) async {
    final isar = await db;
    await isar.writeTxn(() async {
      bool result = await isar.dbMovieModels.delete(movie.isarId);
      print("Item deleted: $result");
    });
  }
}
