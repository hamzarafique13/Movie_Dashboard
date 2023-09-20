import 'package:flutter_application_1/model/movie_model/freezedmoviemodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final filteredGenreMoviesProvider = StateProvider<List<DbMovieModel>>(
  (ref) => [],
);
