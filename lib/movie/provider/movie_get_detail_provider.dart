import 'package:flutter/material.dart';
import '../models/movie_detial_model.dart';
import '../repositories/movie_repository.dart';

class MovieGetDetailProvider with ChangeNotifier {
  final MovieRepository movieRepository;

  MovieGetDetailProvider(this.movieRepository);

  MovieDetailModel? _movie;
  MovieDetailModel? get movie => _movie;

  void getDetail(BuildContext context, {required int id}) async {
    _movie = null;
    notifyListeners();

    final result = await movieRepository.getDetail(id: id);
    result.fold(
      (messageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(messageError)),
        );
      },
      (response) {
        _movie = response;
      },
    );

    notifyListeners();
  }
}
