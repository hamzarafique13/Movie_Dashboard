import 'package:movie_app_use_riverpod/services/api_services.dart';
import 'package:movie_app_use_riverpod/services/isar_services.dart';
import 'package:riverpod/riverpod.dart';
import '../model/moviesmodel.dart';

final treadingMovieListProvider =
    StateNotifierProvider<TreadingListNotifier, List<MovieModel>>(
  (ref) => TreadingListNotifier([]),
);

int fastHash(String string) {
  var hash = 0xcbf29ce484222325;

  var i = 0;
  while (i < string.length) {
    final codeUnit = string.codeUnitAt(i++);
    hash ^= codeUnit >> 8;
    hash *= 0x100000001b3;
    hash ^= codeUnit & 0xFF;
    hash *= 0x100000001b3;
  }

  return hash;
}

final ApidataServices _apidataServices = ApidataServices();
final isarservices = IsarServices();

class TreadingListNotifier extends StateNotifier<List<MovieModel>> {
  TreadingListNotifier([List<MovieModel>? initialMOvieHomePage])
      : super(initialMOvieHomePage ?? []);

  void trendinglist() async {
    state = await _apidataServices.getApiData();
  }

  Future<void> fetchMovieFromIsar() async {
    state = await isarservices.fetchDataIsar();
    if (state.isEmpty) {
      List<MovieModel> movies = await _apidataServices.getApiData();
      state = movies;
      isarservices.saveMoviesToIsar(movies);
    } else {
      state = await _apidataServices.getApiData();
    }
  }
}
