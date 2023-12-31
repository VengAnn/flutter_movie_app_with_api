import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie_app_with_api/movie/models/movie_model.dart';
import '../repositories/movie_repository.dart';

class MovieGetNowPlayingProvider with ChangeNotifier {
  final MovieRepository? movieRepository;

  MovieGetNowPlayingProvider({this.movieRepository});

  bool _isLoaing = false;
  bool get isLoading => _isLoaing;

  final List<MovieModel> _movie = [];
  List<MovieModel> get movies => _movie;

  void getNowPlaying(BuildContext context) async {
    _isLoaing = true;
    notifyListeners();

    final result = await movieRepository!.getNowPlaying();

    result.fold(
      (messageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(messageError)),
        );

        _isLoaing = false;
        notifyListeners();
      },
      (response) {
        _movie.clear();
        _movie.addAll(response.results);

        _isLoaing = false;
        notifyListeners();
      },
    );
  }

  void getNowPlayingWithPagination(
    BuildContext context, {
    required PagingController pagingController,
    required int page,
  }) async {
    final result = await movieRepository!.getNowPlaying(page: page);

    result.fold(
      (messageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(messageError)),
        );
        pagingController.error = messageError;
      },
      (response) {
        if (response.results.length < 20) {
          pagingController.appendLastPage(response.results);
        } else {
          pagingController.appendPage(response.results, page + 1);
        }
      },
    );
  }
}
