import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app_use_riverpod/model/moviesmodel.dart';
import 'package:movie_app_use_riverpod/services/api_services.dart';

final searchListmoviePageProvider =
    StateNotifierProvider<SearchPageNotifier, List<MovieModel>>(
  (ref) => SearchPageNotifier([]),
);

final ApidataServices _apidataServices = ApidataServices();

class SearchPageNotifier extends StateNotifier<List<MovieModel>> {
  SearchPageNotifier([List<MovieModel>? initialMOvieHomePage])
      : super(initialMOvieHomePage ?? []);

  void searchList(String name) async {
    state = await _apidataServices.getApiSearch(name);
  }
}
