import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie_app_with_api/movie/models/movie_model.dart';
import 'package:movie_app_with_api/movie/repositories/movie_respository.dart';

class MovieGetTopRatedProvider with ChangeNotifier {
  final MovieRespository? movieRespository;

  MovieGetTopRatedProvider({this.movieRespository});

  // ignore: prefer_final_fields
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<MovieModel> _movies = [];
  List<MovieModel> get movies => _movies;

  void getTopRated(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    final result = await movieRespository!.getTopRated();

    result.fold(
      (messageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(messageError),
          ),
        );
        _isLoading = false;
        notifyListeners();
        return;
      },
      (response) {
        _movies.clear();
        _movies.addAll(response.results);
        _isLoading = false;
        notifyListeners();
        return;
      },
    );
  }

  void getTopRatedWithPagination(
    BuildContext context, {
    required PagingController pagingController,
    required int page,
  }) async {
    final result = await movieRespository!.getTopRated(page: page);
    result.fold(
      (messageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(messageError),
          ),
        );

        pagingController.error = messageError;

        return;
      },
      (response) {
        if (response.results.length < 20) {
          pagingController.appendLastPage(response.results);
        } else {
          pagingController.appendPage(response.results, page + 1);
        }
        return;
      },
    );
  }
}
