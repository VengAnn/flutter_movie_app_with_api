import 'package:flutter/material.dart';
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
            const SliverAppBar(
              title: Text("Movie Detail"),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, __) {
                  return Consumer<MovieGetDetailProvider>(
                    builder: (_, provider, __) {
                      final movie = provider.movie;
                      return ListTile(
                        title: Text(
                          // ignore: unnecessary_string_interpolations
                          "${movie?.title ?? ''}",
                        ),
                      );
                    },
                  );
                },
                childCount: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
