import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app_use_riverpod/model/moviesmodel.dart';
import 'package:movie_app_use_riverpod/services/api_services.dart';
import 'package:movie_app_use_riverpod/services/isar_services.dart';

final upComingmoviePageProvider =
    StateNotifierProvider<UpComingListNotifier, List<MovieModel>>(
  (ref) => UpComingListNotifier([]),
);

final ApidataServices _apidataServices = ApidataServices();
final isarservices = IsarServices();

class UpComingListNotifier extends StateNotifier<List<MovieModel>> {
  UpComingListNotifier([List<MovieModel>? initialMOvieHomePage])
      : super(initialMOvieHomePage ?? []);

  void upcominglist() async {
    state = await _apidataServices.getApiUpComing();
  }

  Future<void> fetchMovieFromIsar() async {
    state = await isarservices.fetchDataIsar();
    if (state.isEmpty) {
      List<MovieModel> movies = await _apidataServices.getApiUpComing();
      state = movies;
      isarservices.saveMoviesToIsar(movies);
    } else {
      state = await _apidataServices.getApiUpComing();
    }
  }
}
