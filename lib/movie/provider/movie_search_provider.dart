import 'dart:math';
import 'package:flutter/material.dart';
import 'package:movie_app_with_api/movie/models/movie_model.dart';
import 'package:movie_app_with_api/movie/repositories/movie_repository.dart';

class MovieSearchProvider with ChangeNotifier {
  final MovieRepository? movieRepository;
  MovieSearchProvider({this.movieRepository});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<MovieModel> _movie = [];
  List<MovieModel> get moive => _movie;

  void search(BuildContext context, {required String query}) async {
    _isLoading = true;
    notifyListeners();

    final result = await movieRepository!.search(query: query);
    result.fold(
      (messageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: SnackBar(
              content: Text(messageError),
            ),
          ),
        );

        _isLoading = false;
        notifyListeners();
        return;
      },
      (response) {
        _movie.clear();
        _movie.addAll(response.results);
        _isLoading = false;
        notifyListeners();
        return;
      },
    );
  }
}
