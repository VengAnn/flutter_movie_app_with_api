import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie_app_with_api/movie/models/movie_model.dart';
import 'package:movie_app_with_api/movie/provider/movie_get_discover_provider.dart';
import 'package:movie_app_with_api/movie/provider/movie_get_now_playing_provider.dart';
import 'package:movie_app_with_api/movie/provider/movie_get_top_rated_provider.dart';
import 'package:movie_app_with_api/widgets/item_movie_widget.dart';
import 'package:provider/provider.dart';

enum TypeMovie { discover, topRated, nowPlaying }

class MoviePaginationPage extends StatefulWidget {
  const MoviePaginationPage({super.key, required this.type});
  final TypeMovie type;
  @override
  State<MoviePaginationPage> createState() => _MoviePaginationPageState();
}

class _MoviePaginationPageState extends State<MoviePaginationPage> {
  final PagingController<int, MovieModel> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener(
      (pageKey) {
        switch (widget.type) {
          case TypeMovie.discover:
            context.read<MovieGetDiscoverProvider>().getDiscoverWithPagination(
                  context,
                  pagingController: _pagingController,
                  page: pageKey,
                );
            break;
          case TypeMovie.topRated:
            context.read<MovieGetTopRatedProvider>().getTopRatedWithPagination(
                  context,
                  pagingController: _pagingController,
                  page: pageKey,
                );
            break;
          case TypeMovie.nowPlaying:
            context
                .read<MovieGetNowPlayingProvider>()
                .getNowPlayingWithPagination(
                  context,
                  pagingController: _pagingController,
                  page: pageKey,
                );
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Builder(
          builder: (_) {
            switch (widget.type) {
              case TypeMovie.discover:
                return const Text("Discover Movie");

              case TypeMovie.topRated:
                return const Text("TopRated Movie");
              case TypeMovie.nowPlaying:
                return const Text("NowPlaying Movie");
            }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PagedListView.separated(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<MovieModel>(
            itemBuilder: (context, item, index) => ItemMovieWidget(
              movie: item,
              provider: MovieGetDiscoverProvider(),
              hieghtBackdrop: 300,
              widthBackdrop: double.infinity,
              heightposter: 160,
              widthPoster: 100,
            ),
          ),
          separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
        ),
      ),
    );
  }

  //
  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
