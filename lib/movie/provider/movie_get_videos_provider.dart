import 'package:flutter/material.dart';
import 'package:movie_app_with_api/movie/models/movie_video_model.dart';
import 'package:movie_app_with_api/movie/repositories/movie_repository.dart';

class MovieGetVideosProvider with ChangeNotifier {
  final MovieRepository? movieRepository;

  MovieGetVideosProvider({this.movieRepository});

  MovieVideoModel? _videos;
  MovieVideoModel? get videos => _videos;

  //Create method get videos from method on respositories
  void getVideos(BuildContext context, {required int id}) async {
    _videos = null;
    notifyListeners();

    final result = await movieRepository!.getVideos(id: id);
    result.fold(
      (messageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(messageError),
          ),
        );
        _videos = null;
        notifyListeners();
      },
      (response) {
        _videos = response;
        notifyListeners();
        return;
      },
    );
  }
}
