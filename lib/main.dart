import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:movie_app_with_api/app_constant.dart';
import 'package:movie_app_with_api/movie/pages/movie_page.dart';
import 'package:movie_app_with_api/movie/provider/movie_get_discover_provider.dart';
import 'package:movie_app_with_api/movie/provider/movie_get_now_playing_provider.dart';
import 'package:movie_app_with_api/movie/provider/movie_get_top_rated_provider.dart';
import 'package:movie_app_with_api/movie/repositories/movie_respository.dart';
import 'package:movie_app_with_api/movie/repositories/movie_respository_impl.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final dioOption = BaseOptions(
    baseUrl: AppConstants.baseUrl,
    queryParameters: {'api_key': AppConstants.apikey},
  );
  final Dio dio = Dio(dioOption);
  final MovieRespository movieRespository = MovieRespositoryImpl(dio: dio);
  runApp(App(movieRespository: movieRespository));
  FlutterNativeSplash.remove();
}

class App extends StatelessWidget {
  const App({this.movieRespository, super.key});
  final MovieRespository? movieRespository;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              MovieGetDiscoverProvider(movieResposity: movieRespository),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              MovieGetTopRatedProvider(movieRespository: movieRespository),
        ),
        //
        ChangeNotifierProvider(
          create: (_) =>
              MovieGetNowPlayingProvider(movieRespository: movieRespository),
        ),
      ],
      child: MaterialApp(
        title: "Movie DB API",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        home: const MoviePage(),
      ),
    );
  }
}
