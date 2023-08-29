import 'package:flutter/material.dart';
import 'package:movie_app_with_api/movie/models/movie_detial_model.dart';
import '../repositories/movie_repository.dart';

class MovieDetailProvider extends ChangeNotifier {
  final MovieRepository? movieRepository;

  MovieDetailProvider({this.movieRepository});

  // ignore: unused_field
  MovieDetailModel? _movie;
  // ignore: recursive_getters
  MovieDetailModel get movie => movie;

  void getDetail(BuildContext context, {required int id}) async {
    _movie = null;
    notifyListeners();
    final result = await movieRepository!.getDetail(id: id);

    result.fold(
      (messageError) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(messageError)));
        _movie = null;
        notifyListeners();
        return;
      },
      (response) {
        _movie = response;
        notifyListeners();
        return;
      },
    );
  }
}
