import 'package:flutter/material.dart';
import '../movie/models/movie_model.dart';
import 'image_widget.dart';

class ItemMovieWidget extends Container {
  final MovieModel movie;
  // ignore: prefer_typing_uninitialized_variables
  final provider;
  final int? currentIndex;
  //
  final double hieghtBackdrop;
  final double widthBackdrop;
  final double heightposter;
  final double widthPoster;

  ItemMovieWidget({
    required this.movie,
    this.provider,
    this.currentIndex,
    required this.hieghtBackdrop,
    required this.widthBackdrop,
    required this.heightposter,
    required this.widthPoster,
    super.key,
  });
  //declare this constructor to get value from class infinity have value need
  @override
  Widget? get child => Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ImageNetwork(
              imageSrc: "${movie.backdropPath}",
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
                ImageNetwork(
                  imageSrc: "${movie.posterPath}",
                  width: widthPoster,
                  hieght: heightposter,
                  radius: 10,
                ),
                Text(
                  // ignore: unnecessary_string_interpolations
                  "${movie.title}",
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
                      "${movie.voteAverage}",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      "(${movie.voteCount})",
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
              children: provider.movies.asMap().entries.map<Widget>((entry) {
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
        ],
      );
}
