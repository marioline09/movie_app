// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movie_app/movie/models/movie_model.dart';
import 'package:movie_app/movie/repostories/movie_repository.dart';

class MovieGetDiscoverProvider with ChangeNotifier {
  final MovieRepository _movieRepository;

  MovieGetDiscoverProvider(this._movieRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<MovieModel> _movies = [];
  List<MovieModel> get movies => _movies;

  void getDiscover(BuildContext context) async {
    _isLoading = true;
    await Future.delayed(Duration.zero);
    notifyListeners();

    final result = await _movieRepository.getDiscover();

    result.fold(
      (errorMessage) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errorMessage)));

        _isLoading = false;
        notifyListeners();
        return;
      },
      (response) {
        _movies.clear();
        _movies.addAll(response.results);
        _isLoading = false;
        notifyListeners();
        return;
      },
    );
  }

  void getDiscoverWithPaging(
    BuildContext context, {
    required PagingController pagingController,
    required page,
  }) async {
    final result = await _movieRepository.getDiscover(page: page);

    result.fold(
      (errorMessage) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errorMessage)));

        pagingController.error = errorMessage;

        return;
      },
      (response) {
        if (response.results.length < 20) {
          pagingController.appendLastPage(response.results);
        } else {
          pagingController.appendPage(response.results, page + 1);
        }

        return null;
        // _movies.addAll(response.results); // Jangan gunakan clear untuk paging
        // notifyListeners();
      },
    );
  }
}