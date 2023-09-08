import 'package:flutter/material.dart';
import 'package:movie_app_with_api/movie/provider/movie_get_top_rated_provider.dart';
import 'package:provider/provider.dart';
import '../../widgets/image_widget.dart';
import '../pages/movie_detail_page.dart';

class MovieTopRatedComponent extends StatefulWidget {
  const MovieTopRatedComponent({super.key});

  @override
  State<MovieTopRatedComponent> createState() => _MovieTopRatedComponentState();
}

class _MovieTopRatedComponentState extends State<MovieTopRatedComponent> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieGetTopRatedProvider>().getTopRated(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<MovieGetTopRatedProvider>(
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
                height: 200,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: provider.movies.length,
                  itemBuilder: (context, index) {
                    return ImageNetworkWidget(
                      // type: TypeSrcImg.movieDb,
                      imageSrc: "${provider.movies[index].posterPath}",
                      // hieght: 100,
                      width: 120,
                      radius: 15.0,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                MovieDetailpPage(id: provider.movies[index].id),
                          ),
                        );
                      },
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(
                    width: 10,
                  ),
                ),
              ),
            );
          }
          //if isEmpty show
          return const Center(
            child: Text("Not found Top Rated Movie"),
          );
        },
      ),
    );
  }
}
