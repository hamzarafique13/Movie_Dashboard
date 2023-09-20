import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app_use_riverpod/model/moviesmodel.dart';
import 'package:movie_app_use_riverpod/services/api_services.dart';
import 'package:movie_app_use_riverpod/services/isar_services.dart';

final topRatedlistmoviePageProvider =
    StateNotifierProvider<TopRatedMovieNotifier, List<MovieModel>>(
  (ref) => TopRatedMovieNotifier([]),
);

final ApidataServices _apidataServices = ApidataServices();
final isarservices = IsarServices();

class TopRatedMovieNotifier extends StateNotifier<List<MovieModel>> {
  TopRatedMovieNotifier([List<MovieModel>? initialMOvieHomePage])
      : super(initialMOvieHomePage ?? []);

  void topratedlist() async {
    state = await _apidataServices.getApiTopRated();
  }

  Future<void> fetchMovieFromIsar() async {
    state = await isarservices.fetchDataIsar();
    if (state.isEmpty) {
      List<MovieModel> movies = await _apidataServices.getApiTopRated();
      state = movies;
      isarservices.saveMoviesToIsar(movies);
    } else {
      state = await _apidataServices.getApiTopRated();
    }
  }
}
