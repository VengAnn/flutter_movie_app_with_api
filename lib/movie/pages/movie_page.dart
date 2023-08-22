import 'package:flutter/material.dart';
import 'package:movie_app_with_api/app_constant.dart';
import 'package:movie_app_with_api/movie/provider/movie_get_discover_provider.dart';
import 'package:movie_app_with_api/widgets/image_widget.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Movie Database api themoviedb"),
        ),
        body: const CustomScrollView(
          slivers: [
            //const SliverAppBar(),

            _WidgetDiscoverMovies(),
          ],
        ));
  }
}

class _WidgetDiscoverMovies extends StatefulWidget {
  // ignore: unused_element
  const _WidgetDiscoverMovies({super.key});

  @override
  State<_WidgetDiscoverMovies> createState() => __WidgetDiscoverMoviesState();
}

class __WidgetDiscoverMoviesState extends State<_WidgetDiscoverMovies> {
  final CarouselController _carouselController = CarouselController();
  int currentIndex = 0;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieGetDiscoverProvider>().getDiscover(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<MovieGetDiscoverProvider>(
        builder: (_, provider, __) {
          if (provider.isLoading) {
            // ignore: avoid_unnecessary_containers
            return Container(
              child: const Text("Loading"),
            );
          }

          if (provider.movies.isNotEmpty) {
            return CarouselSlider.builder(
              itemCount: provider.movies.length,
              itemBuilder: (_, index, __) {
                final movie = provider.movies[index];
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: ImageNetwork(
                        imageSrc: "${movie.backdropPath}",
                        hieght: 300,
                        width: double.infinity,
                        radius: 10,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.transparent, Colors.black87],
                        ),
                      ),
                    ),
                    //
                    Positioned(
                      bottom: 20,
                      left: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ImageNetwork(
                            imageSrc: "${movie.posterPath}",
                            width: 100,
                            hieght: 150,
                            radius: 10,
                          ),
                          Text(
                            // ignore: unnecessary_string_interpolations
                            "${movie.title}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star_border_outlined,
                                color: Colors.amber,
                              ),
                              Text(
                                "${movie.voteAverage}",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                "(${movie.voteCount})",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Row(
                        children: provider.movies.asMap().entries.map((entry) {
                          final index = entry.key;
                          //final movieItem = entry.value;
                          // print(entry);
                          print(index);
                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: currentIndex == index ? 17 : 7,
                              height: 7,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 3.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: currentIndex == index
                                    ? Colors.red
                                    : Colors.grey,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                );
              },
              carouselController: _carouselController,
              options: CarouselOptions(
                height: 300,
                viewportFraction: 0.85,
                // reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  currentIndex = index;
                },
                // enlargeFactor: 0.3,
                scrollDirection: Axis.horizontal,
              ),
            );
          }
          //if data isEmpty show
          return Container(
            child: const Text("No Found Discover Movies"),
          );
        },
      ),
    );
  }
}
