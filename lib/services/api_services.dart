import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app_use_riverpod/model/moviedetailmodel.dart';
import 'package:movie_app_use_riverpod/model/moviesmodel.dart';
import 'package:uuid/uuid.dart';

class ApidataServices {
  final String url = 'https://api.themoviedb.org/3';
  final String apiKey = '2f524b9d4ecc59568226e745cef4ffe0';
  final String readToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyZjUyNGI5ZDRlY2M1OTU2ODIyNmU3NDVjZWY0ZmZlMCIsInN1YiI6IjYzNmU0MWM2ZDdmYmRhMDBlN2I3Nzc4OSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.pIhLyoiTyNqDfoc0RQqNHVRyb8ZxcsZzDTcD1u29WsI';

  final String authorization =
      'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyZjUyNGI5ZDRlY2M1OTU2ODIyNmU3NDVjZWY0ZmZlMCIsInN1YiI6IjYzNmU0MWM2ZDdmYmRhMDBlN2I3Nzc4OSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.pIhLyoiTyNqDfoc0RQqNHVRyb8ZxcsZzDTcD1u29WsI';

  Future<List<MovieModel>> getApiData() async {
    try {
      var response = await http.get(
        Uri.parse('$url/movie/now_playing?language=en-US&page=1'),
        headers: {
          'accept': 'application/json',
          'Authorization': authorization,
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        print("data: ${data.keys.toString()}");
        List<dynamic> results = data['results'];
        var trendingMovies = results.map((trendingMovie) {
          var uuid = const Uuid().v1();
          return MovieModel.fromJson(trendingMovie, uuid);
        }).toList();

        print("trendingMovies: ${trendingMovies.toString()}");
        return trendingMovies;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<MovieModel>> getApiUpComing() async {
    try {
      var response = await http.get(
        Uri.parse('$url/movie/upcoming?language=en-US&page=1'),
        headers: {
          'accept': 'application/json',
          'Authorization': authorization,
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        print("data: ${data.keys.toString()}");
        List<dynamic> results = data['results'];
        var upComingMovies = results.map((upComingMovies) {
          var uuid = const Uuid().v1();
          return MovieModel.fromJson(upComingMovies, uuid);
        }).toList();

        print("upComingMovies: ${upComingMovies.toString()}");
        return upComingMovies;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<MovieModel>> getApiTopRated() async {
    try {
      var response = await http.get(
        Uri.parse('$url/movie/top_rated?language=en-US&page=1'),
        headers: {
          'accept': 'application/json',
          'Authorization': authorization,
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        print("data: ${data.keys.toString()}");
        List<dynamic> results = data['results'];
        var topRatedMovies = results.map((topRatedMovies) {
          var uuid = const Uuid().v1();
          return MovieModel.fromJson(topRatedMovies, uuid);
        }).toList();

        print("topRatedMovies: ${topRatedMovies.toString()}");
        return topRatedMovies;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<MovieModel>> getApiPopular() async {
    try {
      var response = await http.get(
        Uri.parse('$url/movie/popular?language=en-US&page=1'),
        headers: {
          'accept': 'application/json',
          'Authorization': authorization,
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        print("data: ${data.keys.toString()}");
        List<dynamic> results = data['results'];
        var popularMovies = results.map((popularMovies) {
          var uuid = const Uuid().v1();
          return MovieModel.fromJson(popularMovies, uuid);
        }).toList();

        print("popularMovies: ${popularMovies.toString()}");
        return popularMovies;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<MovieModel>> getApiSearch(String name) async {
    try {
      var response = await http.get(
        Uri.parse(
            '$url/search/movie?query=$name&include_adult=false&language=en-US&page=1'),
        headers: {
          'accept': 'application/json',
          'Authorization': authorization,
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        var uuid = const Uuid().v1();
        final data = json.decode(response.body) as Map<String, dynamic>;
        print("data: ${data.keys.toString()}");
        List<dynamic> results = data['results'];
        var searchMovies = results.map((searchMovie) {
          return MovieModel.fromJson(searchMovie, uuid);
        }).toList();

        print("searchMovies: $searchMovies");
        return searchMovies;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<MovieReviews>> getApiReviews(int id) async {
    try {
      var response = await http.get(
        Uri.parse('$url/movie/$id/reviews?language=en-US&page=1'),
        headers: {
          'accept': 'application/json',
          'Authorization': authorization,
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        print("data: ${data.keys.toString()}");
        List<dynamic> results = data['results'];
        print('results: $results');
        var reviewMovies = results
            .map((reviewMovie) => MovieReviews.fromJson(reviewMovie))
            .toList();

        print("reviewMovies: $reviewMovies");
        return reviewMovies;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }
}
