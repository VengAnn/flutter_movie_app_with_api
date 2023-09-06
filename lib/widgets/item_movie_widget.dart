import 'package:flutter/material.dart';
import 'package:movie_app_with_api/movie/models/movie_detial_model.dart';
import '../movie/models/movie_model.dart';
import 'image_widget.dart';

// ignore: must_be_immutable
class ItemMovieWidget extends Container {
  final MovieModel? movie;

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

          Positioned.fill(
            child: InkWell(
              onTap: onTap,
            ),
          ),
        ],
      );
}
