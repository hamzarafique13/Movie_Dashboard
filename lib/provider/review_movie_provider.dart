import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:movie_app_use_riverpod/model/moviedetailmodel.dart';
import 'package:movie_app_use_riverpod/services/api_services.dart';

final reviewsListmoviePageProvider =
    StateNotifierProvider<ReviewsNotifier, List<MovieReviews>>(
  (ref) => ReviewsNotifier([]),
);

final ApidataServices _apidataServices = ApidataServices();

class ReviewsNotifier extends StateNotifier<List<MovieReviews>> {
  ReviewsNotifier([List<MovieReviews>? initialMOvieHomePage])
      : super(initialMOvieHomePage ?? []);

  void movieReviews(int id) async {
    state = await _apidataServices.getApiReviews(id);
  }
}
