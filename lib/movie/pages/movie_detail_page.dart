// ignore_for_file: override_on_non_overriding_member

import 'package:flutter/material.dart';
import 'package:movie_app_with_api/widgets/item_movie_widget.dart';
import 'package:provider/provider.dart';
import '../../injector.dart';
import '../provider/movie_get_detail_provider.dart';

class MovieDetailpPage extends StatelessWidget {
  const MovieDetailpPage({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MovieGetDetailProvider>(
      create: (_) => sl<MovieGetDetailProvider>()..getDetail(context, id: id),
      builder: (_, __) => Scaffold(
        body: CustomScrollView(
          slivers: [
            _WidgetAppBar(context: context),
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.public),
            ),
          ),
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

class _WidgetSummary extends SliverToBoxAdapter {
  Widget _content({required String title, required Widget body}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          // ignore: unnecessary_brace_in_string_interps, unnecessary_string_interpolations
          "${title}",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(height: 10.0),
        body,
        const SizedBox(
          height: 10.0,
        ),
      ],
    );
  }

  TableRow _tableContent({required String title, required String content}) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          // ignore: unnecessary_brace_in_string_interps, unnecessary_string_interpolations
          child: Text(title),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(content),
        ),
      ],
    );
  }

  @override
  Widget? get child => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<MovieGetDetailProvider>(
          builder: (_, provider, __) {
            final movie = provider.movie;
            if (movie != null) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _content(
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
                  _content(
                    title: "Genres",
                    body: Wrap(
                      spacing: 6.0,
                      children: movie.genres
                          .map((e) => Chip(label: Text(e.name)))
                          .toList(),
                    ),
                  ),
                  //
                  _content(
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
                  _content(
                    title: "Summary",
                    body: Table(
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
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
        ),
      );
}
