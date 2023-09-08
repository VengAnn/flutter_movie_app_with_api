import 'package:flutter/material.dart';
import 'package:movie_app_with_api/movie/pages/movie_detail_page.dart';
import 'package:movie_app_with_api/movie/provider/movie_get_now_playing_provider.dart';
import 'package:provider/provider.dart';
import '../../widgets/image_widget.dart';

class MovieNowPlayingComponent extends StatefulWidget {
  const MovieNowPlayingComponent({super.key});

  @override
  State<MovieNowPlayingComponent> createState() =>
      _MovieNowPlayingComponentState();
}

class _MovieNowPlayingComponentState extends State<MovieNowPlayingComponent> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieGetNowPlayingProvider>().getNowPlaying(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<MovieGetNowPlayingProvider>(
        builder: (_, provider, __) {
          if (provider.isLoading) {
            return const Center(
              child: Text("Loading..."),
            );
          }
          if (provider.movies.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SizedBox(
                height: 220,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.movies.length,
                    itemBuilder: (context, index) {
                      final movie = provider.movies[index];
                      return Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 220,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black12,
                                ],
                              ),
                              border:
                                  Border.all(width: 1, color: Colors.black12),
                            ),
                            child: Row(
                              children: [
                                ImageNetworkWidget(
                                  imageSrc: "${movie.posterPath}",
                                  hieght: 200,
                                  width: 120,
                                  radius: 15.0,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          // ignore: unnecessary_string_interpolations
                                          "${movie.title}",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        //
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            Text(
                                              "${movie.voteAverage}",
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10.0,
                                            ),
                                            Text(
                                              "(${movie.voteCount})",
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        //
                                        Text(
                                          // ignore: unnecessary_string_interpolations
                                          "${movie.overview}",
                                          maxLines: 4,
                                          //textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //when click on item on now playing go to detail screen
                          Positioned.fill(
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => MovieDetailpPage(
                                          id: provider.movies[index].id),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(
                      width: 10,
                    ),
                  ),
                ),
              ),
            );
          }
          //if isEmpty show
          return const Center(
            child: Text("Not found Now Playing Movies"),
          );
        },
      ),
    );
  }
}
