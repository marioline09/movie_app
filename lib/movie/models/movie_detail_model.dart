// import 'package:meta/meta.dart';
// import 'dart:convert';

class MovieDetailModel {
    final bool adult;
    final String backdropPath;
    final int budget;
    final List<Genre> genres;
    final String homepage;
    final int id;
    final String overview;
    final double popularity;
    final String posterPath;
    final DateTime releaseDate;
    final int revenue;
    final String status;
    final String tagline;
    final String title;
    final double voteAverage;
    final int voteCount;

    MovieDetailModel({
        required this.adult,
        this.backdropPath = '',
        required this.budget,
        required this.genres,
        required this.homepage,
        required this.id,
        required this.overview,
        required this.popularity,
        this.posterPath = '',
        required this.releaseDate,
        required this.revenue,
        required this.status,
        required this.tagline,
        required this.title,
        required this.voteAverage,
        required this.voteCount,
    });

    // factory MovieDetailModel.fromJson(String str) => MovieDetailModel.fromMap(json.decode(str));

    // String toJson() => json.encode(toMap());

    factory MovieDetailModel.fromMap(Map<String, dynamic> json) => MovieDetailModel(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        budget: json["budget"],
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromMap(x))),
        homepage: json["homepage"],
        id: json["id"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        releaseDate: DateTime.parse(json["release_date"]),
        revenue: json["revenue"],
        status: json["status"],
        tagline: json["tagline"],
        title: json["title"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
    );
      @override
  String toString() {
    return 'MovieDetailModel(adult: $adult, backdropPath: $backdropPath, budget: $budget, genres: $genres, homepage: $homepage, id: $id, overview: $overview, popularity: $popularity, posterPath: $posterPath, releaseDate: $releaseDate, revenue: $revenue, status: $status, tagline: $tagline, title: $title, voteAverage: $voteAverage, voteCount: $voteCount)';
  }

    // Map<String, dynamic> toMap() => {
    //     "adult": adult,
    //     "backdrop_path": backdropPath,
    //     "budget": budget,
    //     "genres": List<dynamic>.from(genres.map((x) => x.toMap())),
    //     "homepage": homepage,
    //     "id": id,
    //     "overview": overview,
    //     "popularity": popularity,
    //     "poster_path": posterPath,
    //     "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
    //     "revenue": revenue,
    //     "status": status,
    //     "tagline": tagline,
    //     "title": title,
    //     "vote_average": voteAverage,
    //     "vote_count": voteCount,
    // };
}

class Genre {
    final int id;
    final String name;

    Genre({
        required this.id,
        required this.name,
    });

    // factory Genre.fromJson(String str) => Genre.fromMap(json.decode(str));

    // String toJson() => json.encode(toMap());

    factory Genre.fromMap(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
    );
    @override
    String toString() => 'Genre(id: $id, name: $name)';

    // Map<String, dynamic> toMap() => {
    //     "id": id,
    //     "name": name,
    // };
}
