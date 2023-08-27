import 'package:dartz/dartz.dart';
import 'package:movie_app_with_api/movie/models/movie_model.dart';

abstract class MovieRespository {
  Future<Either<String, MovieResponseModel>> getDiscover({int page = 1});
  Future<Either<String, MovieResponseModel>> getTopRated({int page = 1});
}
