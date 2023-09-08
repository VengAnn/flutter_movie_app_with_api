import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:movie_app_with_api/injector.dart';
import 'package:movie_app_with_api/movie/pages/movie_page.dart';
import 'package:movie_app_with_api/movie/provider/movie_get_discover_provider.dart';
import 'package:movie_app_with_api/movie/provider/movie_get_now_playing_provider.dart';
import 'package:movie_app_with_api/movie/provider/movie_get_top_rated_provider.dart';
import 'package:movie_app_with_api/movie/provider/movie_search_provider.dart';
import 'package:provider/provider.dart';
import 'movie/repositories/movie_repository.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  setUp();
  runApp(const App());
  FlutterNativeSplash.remove();
}

class App extends StatelessWidget {
  const App({this.movieRepository, super.key});
  final MovieRepository? movieRepository;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => sl<MovieGetDiscoverProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => sl<MovieGetTopRatedProvider>(),
        ),
        //
        ChangeNotifierProvider(
          create: (_) => sl<MovieGetNowPlayingProvider>(),
        ),
        //
        ChangeNotifierProvider(
          create: (_) => sl<MovieSearchProvider>(),
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
