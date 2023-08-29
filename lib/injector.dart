import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app_with_api/movie/provider/movie_get_discover_provider.dart';
import 'package:movie_app_with_api/movie/provider/movie_get_now_playing_provider.dart';
import 'package:movie_app_with_api/movie/provider/movie_get_top_rated_provider.dart';
import 'package:movie_app_with_api/movie/repositories/movie_repository.dart';
import 'package:movie_app_with_api/movie/repositories/movie_repository_impl.dart';

import 'app_constant.dart';

final sl = GetIt.instance;
void setUp() {
  //Register Provider
  sl.registerLazySingleton<MovieGetDiscoverProvider>(
    () => MovieGetDiscoverProvider(
      movieResposity: sl(),
    ),
  );
  //
  sl.registerLazySingleton<MovieGetTopRatedProvider>(
    () => MovieGetTopRatedProvider(
      movieRepository: sl(),
    ),
  );
  //
  sl.registerLazySingleton<MovieGetNowPlayingProvider>(
    () => MovieGetNowPlayingProvider(
      movieRepository: sl(),
    ),
  );

  //Register Repository
  sl.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      dio: sl(),
    ),
  );

  // //Register Http Client (DIO)
  sl.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        queryParameters: {'api_key': AppConstants.apikey},
      ),
    ),
  );
}
