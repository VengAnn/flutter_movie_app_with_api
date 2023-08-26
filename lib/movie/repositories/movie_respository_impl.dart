import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie_app_with_api/movie/models/movie_model.dart';
import 'package:movie_app_with_api/movie/repositories/movie_respository.dart';

class MovieRespositoryImpl implements MovieRespository {
  final Dio? dio;
  //Constuctor
  MovieRespositoryImpl({this.dio});
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
}
