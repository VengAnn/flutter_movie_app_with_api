import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie_app_with_api/movie/models/movie_model.dart';
import 'package:movie_app_with_api/movie/repositories/movie_respository.dart';

class MovieGetDiscoverProvider with ChangeNotifier {
  final MovieRespository? movieResposity;
  MovieGetDiscoverProvider({this.movieResposity});

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final List<MovieModel> _movies = [];
  List<MovieModel> get movies => _movies;

  void getDiscover(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final result = await movieResposity!.getDiscover();
    //print(result);
    result.fold(
      (errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorMessage),
        ));
        // ignore: avoid_print
        print(errorMessage); ////
        _isLoading = false;
        notifyListeners();
        return;
      },
      (response) {
        _movies.clear();
        _movies.addAll(response.results);
        _isLoading = false;
        notifyListeners();
        return null;
      },
    );
  }

  //
  void getDiscoverWithPagination(
    BuildContext context, {
    required PagingController pagingController,
    required int page,
  }) async {
    final result = await movieResposity!.getDiscover(page: page);
    result.fold(
      (errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorMessage),
        ));

        pagingController.error = errorMessage;
        // print("error this: $errorMessage");
        return;
      },
      (response) {
        if (response.results.length < 20) {
          pagingController.appendLastPage(response.results);
        } else {
          pagingController.appendPage(response.results, page + 1);
        }
        return null;
      },
    );
  }
}
