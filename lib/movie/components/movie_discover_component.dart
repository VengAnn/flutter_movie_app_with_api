import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_with_api/movie/pages/movie_detail_page.dart';
import 'package:provider/provider.dart';
import '../../widgets/item_movie_widget.dart';
import '../provider/movie_get_discover_provider.dart';

class MovieDiscoverComponent extends StatefulWidget {
  const MovieDiscoverComponent({super.key});

  @override
  State<MovieDiscoverComponent> createState() => _MovieDiscoverComponentState();
}

class _MovieDiscoverComponentState extends State<MovieDiscoverComponent> {
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
              height: 300,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(child: Text("Loading")),
            );
          }

          if (provider.movies.isNotEmpty) {
            return CarouselSlider.builder(
              itemCount: provider.movies.length,
              itemBuilder: (_, index, __) {
                final movie = provider.movies[index];
                return Stack(
                  children: [
                    ItemMovieWidget(
                      movie: movie,
                      // provider: provider,
                      // currentIndex: currentIndex,
                      hieghtBackdrop: 300,
                      widthBackdrop: double.infinity,
                      heightposter: 160,
                      widthPoster: 100,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return MovieDetailpPage(id: movie.id);
                            },
                          ),
                        );
                      },
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Row(
                        children: provider.movies
                            .asMap()
                            .entries
                            .map<Widget>((entry) {
                          final index = entry.key;
                          //final movieItem = entry.value;
                          // print(entry);

                          //print(index);
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
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  currentIndex = index;
                },
                scrollDirection: Axis.horizontal,
              ),
            );
          }
          //if data isEmpty show
          // ignore: avoid_unnecessary_containers
          return Container(
            height: 300,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(child: Text("No Found Discover Movies")),
          );
        },
      ),
    );
  }
}
