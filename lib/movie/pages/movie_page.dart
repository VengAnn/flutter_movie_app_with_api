import 'package:flutter/material.dart';
import 'package:movie_app_with_api/movie/components/movie_now_playig_component.dart';
import 'package:movie_app_with_api/movie/components/movie_top_rated_component.dart';
import 'package:movie_app_with_api/movie/pages/movie_pagination_page.dart';
import '../components/movie_discover_component.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            snap: true,
            centerTitle: true,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    // backgroundImage: AssetImage("assets/images/logo.png"),
                    child: Image.asset("assets/images/logo.png"),
                  ),
                ),
                const Text("Movies DB api"),
              ],
            ),
          ),
          _WigetTitle(
            title: 'Discover Movies',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return const MoviePaginationPage(
                      type: TypeMovie.discover,
                    );
                  },
                ),
              );
            },
          ),
          //
          const MovieDiscoverComponent(),
          //
          _WigetTitle(
            title: 'Top Rated Movies',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return const MoviePaginationPage(
                      type: TypeMovie.topRated,
                    );
                  },
                ),
              );
            },
          ),
          //
          const MovieTopRatedComponent(),
          //
          _WigetTitle(
            title: 'Now Playing Movies',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return const MoviePaginationPage(
                      type: TypeMovie.nowPlaying,
                    );
                  },
                ),
              );
            },
          ),
          //
          const MovieNowPlayingComponent(),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}

class _WigetTitle extends SliverToBoxAdapter {
  final String title;
  final void Function() onPressed;

  const _WigetTitle({
    required this.title,
    required this.onPressed,
  });
  @override
  Widget? get child => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            //
            OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.black54,
                shape: const StadiumBorder(),
                side: const BorderSide(
                  color: Colors.black54,
                ),
              ),
              child: const Text("See All"),
            ),
          ],
        ),
      );
}
