import 'package:flutter/material.dart';
import 'package:movie_app_with_api/movie/provider/movie_get_videos_provider.dart';
import 'package:movie_app_with_api/widgets/image_widget.dart';
import 'package:movie_app_with_api/widgets/item_movie_widget.dart';
import 'package:movie_app_with_api/widgets/youtube_player_widget.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../injector.dart';
import '../../widgets/webview_app_widget.dart';
import '../provider/movie_get_detail_provider.dart';

class MovieDetailpPage extends StatelessWidget {
  const MovieDetailpPage({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MovieGetDetailProvider>(
          create: (_) =>
              sl<MovieGetDetailProvider>()..getDetail(context, id: id),
        ),
        // (
        //   create: (_) =>
        //       sl<MovieGetVideosProvider>()..getVideos(context, id: id),
        // ),
        ChangeNotifierProvider<MovieGetVideosProvider>.value(
          value: sl<MovieGetVideosProvider>()..getVideos(context, id: id),
        ),
      ],
      builder: (context, child) => Scaffold(
        body: CustomScrollView(
          slivers: [
            _WidgetAppBar(context: context),
            Consumer<MovieGetVideosProvider>(
              builder: (_, provider, __) {
                final video = provider.videos;
                // if (video == null) {
                //   return Container();
                // }

                // ignore: unnecessary_null_comparison
                if (video != null) {
                  return SliverToBoxAdapter(
                    child: _Content(
                      title: "Trailer",
                      body: SizedBox(
                        height: 200,
                        child: ListView.builder(
                          // padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          scrollDirection: Axis.horizontal,
                          itemCount: video.results!.length,
                          itemBuilder: (_, index) {
                            final vidio = video.results![index];
                            return Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Image.network(
                                    YoutubePlayer.getThumbnail(
                                      videoId: vidio.key ??
                                          "", // Ensure vidio.key is not null
                                    ),
                                    scale: 1.0,
                                    errorBuilder: (context, error, stackTrace) {
                                      // Display a container when an error occurs
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width:
                                                100, // Specify the width and height of the container
                                            height: 100,
                                            color: Colors
                                                .grey, // You can set any color you prefer
                                            child: const Center(
                                              child: Icon(
                                                Icons.error,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                //Design Buttom on thumbnail photo Icon play and
                                Positioned.fill(
                                  child: Center(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        color: Colors.red,
                                      ),
                                      child: const Icon(
                                        Icons.play_arrow,
                                        color: Colors.white,
                                        size: 35.0,
                                      ),
                                    ),
                                  ),
                                ),
                                //when click on trailer call class youtube player to show videos on youtube
                                Positioned.fill(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                YouTuberPlayerWidget(
                                                    youtubeKey: "${vidio.key}"),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  );
                }
                //if data null show
                return const SliverToBoxAdapter();
              },
            ),
            _WidgetSummary(),
          ],
        ),
      ),
    );
  }
}

class _WidgetAppBar extends SliverAppBar {
  final BuildContext context;
  const _WidgetAppBar({required this.context});

  @override
  Color? get foregroundColor => Colors.black;

  @override
  Color? get backgroundColor => Colors.white;

  @override
  Widget? get leading => Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
      );

  @override
  List<Widget>? get actions => [
        Consumer<MovieGetDetailProvider>(
          builder: (_, provider, __) {
            final movie = provider.movie;
            if (movie != null) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return WebViewAppWidget(
                              url: "${movie.homepage}",
                              title: "${movie.title}",
                            );
                          },
                        ),
                      );
                    },
                    icon: const Icon(Icons.public),
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ];
  @override
  double? get expandedHeight => 300;

  @override
  Widget? get flexibleSpace => Consumer<MovieGetDetailProvider>(
        builder: (_, provider, __) {
          final movie = provider.movie;
          if (movie != null) {
            return ItemMovieWidget(
              hieghtBackdrop: double.infinity,
              widthBackdrop: double.infinity,
              heightposter: 160,
              widthPoster: 100,
              movieDetail: movie,
            );
          }
          return Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.grey[300],
          );
        },
      );
}

// ignore: unused_element
class _Content extends StatelessWidget {
  // ignore: unused_element
  const _Content({super.key, required this.title, required this.body});
  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            // ignore: unnecessary_brace_in_string_interps, unnecessary_string_interpolations
            "${title}",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        const SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: body,
        ),
        const SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
}

class _WidgetSummary extends SliverToBoxAdapter {
  TableRow _tableContent({required String title, required String content}) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(title),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(content),
        ),
      ],
    );
  }

  @override
  Widget? get child => Consumer<MovieGetDetailProvider>(
        builder: (_, provider, __) {
          final movie = provider.movie;
          if (movie != null) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Content(
                  title: "Release Date",
                  body: Row(
                    children: [
                      const Icon(
                        Icons.calendar_month_outlined,
                        size: 30,
                      ),
                      //
                      const SizedBox(
                        width: 6.0,
                      ),
                      Text(
                        // ignore: unnecessary_string_interpolations
                        "${movie.releaseDate.toString().split(' ').first}",
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                //
                _Content(
                  title: "Genres",
                  body: Wrap(
                    spacing: 6.0,
                    children: movie.genres!
                        .map((e) => Chip(label: Text(e.name)))
                        .toList(),
                  ),
                ),
                //
                _Content(
                  title: "OverView",
                  body: Text(
                    // ignore: unnecessary_string_interpolations
                    "${movie.overview}",
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                _Content(
                  title: "Summary",
                  body: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(2),
                    },
                    border: TableBorder.all(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    children: [
                      TableRow(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Adult"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(movie.adult ? "yes" : "No"),
                          ),
                        ],
                      ),
                      //
                      _tableContent(
                        title: "Popularity",
                        content: "${movie.popularity}",
                      ),
                      //
                      _tableContent(
                        title: "Status",
                        // ignore: unnecessary_string_interpolations
                        content: "${movie.status}",
                      ),
                      //
                      _tableContent(
                        title: "Budget",
                        content: "${movie.budget}",
                      ),
                      //
                      _tableContent(
                        title: "Revenue",
                        content: "${movie.revenue}",
                      ),
                      //
                      _tableContent(
                        title: "TagLine",
                        // ignore: unnecessary_string_interpolations
                        content: "${movie.tagline}",
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return Container();
        },
      );
}
