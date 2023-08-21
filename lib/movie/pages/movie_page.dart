import 'package:flutter/material.dart';
import 'package:movie_app_with_api/movie/provider/movie_get_discover_provider.dart';
import 'package:provider/provider.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieGetDiscoverProvider>().getDiscover(context);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Database api themoviedb"),
      ),
      body: Consumer<MovieGetDiscoverProvider>(
        builder: (_, provider, __) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (provider.movies.isNotEmpty) {
            return ListView.builder(
              itemCount: provider.movies.length,
              itemBuilder: (context, index) {
                final movie = provider.movies[index];

                return ListTile(
                  title: Text(movie.title),
                  subtitle: Text(movie.overview),
                );
              },
            );
          }
          //if data isEmpty show
          return const Center(child: Text("No Found Discover Movies"));
        },
      ),
    );
  }
}
