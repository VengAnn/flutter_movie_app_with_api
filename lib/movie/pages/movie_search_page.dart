import 'package:flutter/material.dart';
import 'package:movie_app_with_api/movie/pages/movie_detail_page.dart';
import 'package:movie_app_with_api/movie/provider/movie_search_provider.dart';
import 'package:movie_app_with_api/widgets/image_widget.dart';
import 'package:provider/provider.dart';

class MovieSearchPage extends SearchDelegate {
  @override
  String? get searchFieldLabel => "Search Movies";
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = "",
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back_ios),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (query.isNotEmpty) {
          context.read<MovieSearchProvider>().search(context, query: query);
        }
      },
    );
    return Consumer<MovieSearchProvider>(
      builder: (_, provider, __) {
        // if (query.isEmpty) {
        //   return const Center(
        //     child: Text("Search Movies"),
        //   );
        // }
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (provider.moive.isEmpty) {
          return const Center(
            child: Text("Movies not found"),
          );
        }
        //otherwise isnot Empty show listview
        return ListView.builder(
          itemCount: provider.moive.length,
          itemBuilder: (context, index) {
            final movie = provider.moive[index];
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      ImageNetworkWidget(
                        imageSrc: "${movie.posterPath}",
                        hieght: 120,
                        width: 80,
                        radius: 0,
                      ),

                      //
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                            const SizedBox(height: 8),
                            Text(
                              movie.overview,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MovieDetailpPage(id: movie.id),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox();
  }
}
