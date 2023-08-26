import 'package:flutter/material.dart';
import 'package:movie_app_with_api/movie/pages/movie_pagination_page.dart';
import 'package:movie_app_with_api/movie/provider/movie_get_discover_provider.dart';
import 'package:movie_app_with_api/widgets/item_movie_widget.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          //surfaceTintColor: Colors.black,
          elevation: 0,
          centerTitle: true,
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
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Discover Movies",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (_) {
                            return const MoviePaginationPage();
                          },
                        ));
                      },
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
              ),
            ),
            const _WidgetDiscoverMovies(),
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
                return ItemMovieWidget(
                  movie: movie,
                  provider: provider,
                  currentIndex: currentIndex,
                  hieghtBackdrop: 300,
                  widthBackdrop: double.infinity,
                  heightposter: 160,
                  widthPoster: 100,
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
