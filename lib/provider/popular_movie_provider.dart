import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app_use_riverpod/model/moviesmodel.dart';
import 'package:movie_app_use_riverpod/services/api_services.dart';
import 'package:movie_app_use_riverpod/services/isar_services.dart';

final popularlistmoviePageProvider =
    StateNotifierProvider<PopularListNotifier, List<MovieModel>>(
  (ref) => PopularListNotifier([]),
);

final ApidataServices _apidataServices = ApidataServices();
final isarservices = IsarServices();

class PopularListNotifier extends StateNotifier<List<MovieModel>> {
  PopularListNotifier([List<MovieModel>? initialMOvieHomePage])
      : super(initialMOvieHomePage ?? []);

  void popularlist() async {
    state = await _apidataServices.getApiPopular();
  }

  Future<void> fetchMovieFromIsar() async {
    state = await isarservices.fetchDataIsar();
    if (state.isEmpty) {
      List<MovieModel> movies = await _apidataServices.getApiPopular();
      state = movies;
      isarservices.saveMoviesToIsar(movies);
    } else {
      state = await _apidataServices.getApiPopular();
    }
  }
}
