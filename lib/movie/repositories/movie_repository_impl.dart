import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie_app_with_api/movie/models/movie_detial_model.dart';
import 'package:movie_app_with_api/movie/models/movie_model.dart';
import 'package:movie_app_with_api/movie/models/movie_video_model.dart';
import 'package:movie_app_with_api/movie/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final Dio? dio;
  //Constuctor
  MovieRepositoryImpl({this.dio});
  @override
  Future<Either<String, MovieResponseModel>> getDiscover({int page = 1}) async {
    try {
      final result = await dio!.get(
        '/discover/movie',
        queryParameters: {'page': page},
      );
      if (result.statusCode == 200 && result.data != null) {
        final model = MovieResponseModel.fromMap(result.data);
        return Right(model);
      }
      return left('Error get discover movies');
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }

      return const Left('Another error on get discover movies');
      //throw e.toString();
    }
  }

  @override
  Future<Either<String, MovieResponseModel>> getTopRated({int page = 1}) async {
    try {
      final result =
          await dio!.get('/movie/top_rated', queryParameters: {'page': page});
      if (result.statusCode == 200 && result.data != null) {
        final model = MovieResponseModel.fromMap(result.data);
        return right(model);
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      if (e.response != null) {
        return left(e.response.toString());
      }
      //
      return left('Another error on get TopRated movie');
    }
    throw Exception('get TopRated method completed without returning a value');
  }

  //
  @override
  Future<Either<String, MovieResponseModel>> getNowPlaying(
      {int page = 1}) async {
    try {
      final result =
          await dio!.get('/movie/now_playing', queryParameters: {'page': page});
      if (result.statusCode == 200 && result.data != null) {
        final model = MovieResponseModel.fromMap(result.data);
        return Right(model);
      }
      return const Left("Error get Now Playing Movies");
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }
      return const Left("Another Error on get Now Playing");
    }
    //throw Exception("Erro get Now Playing Movies");
  }

  @override
  Future<Either<String, MovieDetailModel>> getDetail({required int id}) async {
    try {
      final result = await dio!.get(
        '/movie/$id',
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = MovieDetailModel.fromJson(result.data);
        return Right(model);
      }

      return const Left('Error get movie detail');
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }

      return const Left('Another error on get movie detail');
    }
  }

  @override
  Future<Either<String, MovieVideoModel>> getVideos({required int id}) async {
    try {
      final result = await dio!.get(
        '/movie/$id/videos',
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = MovieVideoModel.fromJson(result.data);
        return Right(model);
      }

      return const Left('Error get movie videos');
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }

      return const Left('Another error on get movie videos');
    }
  }
}
