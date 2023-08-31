import 'package:flutter/material.dart';
import 'package:movie_app_with_api/movie/models/movie_detial_model.dart';
import 'package:movie_app_with_api/movie/provider/movie_get_discover_provider.dart';
import '../movie/models/movie_model.dart';
import 'image_widget.dart';

// ignore: must_be_immutable
class ItemMovieWidget extends Container {
  final MovieModel? movie;
  // ignore: prefer_typing_uninitialized_variables
  final provider;
  final int? currentIndex;
  //
  final double hieghtBackdrop;
  final double widthBackdrop;
  final double heightposter;
  final double widthPoster;
  void Function()? onTap;
  final MovieDetailModel? movieDetail;

  ItemMovieWidget({
    required this.hieghtBackdrop,
    required this.widthBackdrop,
    required this.heightposter,
    required this.widthPoster,
    this.movie,
    this.onTap,
    this.provider,
    this.currentIndex,
    this.movieDetail,
    super.key,
  });
  //declare this constructor to get value from class infinity have value need
  @override
  Widget? get child => Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ImageNetworkWidget(
              imageSrc:
                  "${movieDetail != null ? movieDetail!.backdropPath : movie!.backdropPath}",
              hieght: hieghtBackdrop,
              width: widthBackdrop,
              radius: 10,
            ),
          ),

          Container(
            height: hieghtBackdrop,
            width: widthBackdrop,
            margin: const EdgeInsets.only(top: 10),
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
                ImageNetworkWidget(
                  imageSrc:
                      "${movieDetail != null ? movieDetail!.posterPath : movie!.backdropPath}",
                  width: widthPoster,
                  hieght: heightposter,
                  radius: 10,
                ),
                Text(
                  // ignore: unnecessary_string_interpolations
                  "${movieDetail != null ? movieDetail!.title : movie!.title}",
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
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
                      "${movieDetail != null ? movieDetail!.voteAverage : movie!.voteAverage}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      "(${movieDetail != null ? movieDetail!.voteCount : movie!.voteCount})",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
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
              children: MovieGetDiscoverProvider()
                  .movies
                  .asMap()
                  .entries
                  .map<Widget>((entry) {
                final index = entry.key;
                //final movieItem = entry.value;
                // print(entry);
                // ignore: avoid_print
                print(index);
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: currentIndex == index ? 17 : 7,
                    height: 7,
                    margin: const EdgeInsets.symmetric(horizontal: 3.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: currentIndex == index ? Colors.red : Colors.grey,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Positioned.fill(
            child: InkWell(
              onTap: onTap,
            ),
          ),
        ],
      );
}
