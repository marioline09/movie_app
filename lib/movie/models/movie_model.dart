// import 'package:meta/meta.dart';
// import 'dart:convert';

class MovieResponseModel {
    final int page;
    final List<MovieModel> results;
    final int totalPages;
    final int totalResults;

    MovieResponseModel({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    // factory MovieResponseModel.fromJson(String str) => MovieResponseModel.fromMap(json.decode(str));

    // String toJson() => json.encode(toMap());

    factory MovieResponseModel.fromMap(Map<String, dynamic> json) => MovieResponseModel(
        page: json["page"],
        results: List<MovieModel>.from(json["results"].map((x) => MovieModel.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

    // Map<String, dynamic> toMap() => {
    //     "page": page,
    //     "results": List<dynamic>.from(results.map((x) => x.toMap())),
    //     "total_pages": totalPages,
    //     "total_results": totalResults,
    // };
}

class MovieModel {
    // final bool adult;
    final String? backdropPath;
    // final List<int> genreIds;
    final int id;
    // final String originalLanguage;
    // final String originalTitle;
    final String overview;
    final double popularity;
    final String? posterPath;
    // final DateTime releaseDate;
    final String title;
    // final bool video;
    final double voteAverage;
    final int voteCount;

    MovieModel({
        // required this.adult,
        this.backdropPath,
        // required this.genreIds,
        required this.id,
        // required this.originalLanguage,
        // required this.originalTitle,
        required this.overview,
        required this.popularity,
        this.posterPath,
        // required this.releaseDate,
        required this.title,
        // required this.video,
        required this.voteAverage,
        required this.voteCount,
    });

    // factory MovieModel.fromJson(String str) => MovieModel.fromMap(json.decode(str));

    // String toJson() => json.encode(toMap());

    factory MovieModel.fromMap(Map<String, dynamic> json) => MovieModel(
        // adult: json["adult"],
        backdropPath: json["backdrop_path"] ?? '',
        // genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        // originalLanguage: json["original_language"],
        // originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"] ?? '',
        // releaseDate: DateTime.parse(json["release_date"]),
        title: json["title"],
        // video: json["video"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
    );

    // Map<String, dynamic> toMap() => {
    //     "adult": adult,
    //     "backdrop_path": backdropPath,
    //     "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
    //     "id": id,
    //     "original_language": originalLanguage,
    //     "original_title": originalTitle,
    //     "overview": overview,
    //     "popularity": popularity,
    //     "poster_path": posterPath,
    //     "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
    //     "title": title,
    //     "video": video,
    //     "vote_average": voteAverage,
    //     "vote_count": voteCount,
    // };
}
