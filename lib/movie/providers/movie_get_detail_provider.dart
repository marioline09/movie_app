import 'package:flutter/material.dart';
import 'package:movie_app/movie/models/movie_detail_model.dart';
import 'package:movie_app/movie/repostories/movie_repository.dart';

class MovieGetDetailProvider with ChangeNotifier {
  final MovieRepository _movieRepository;

  MovieGetDetailProvider(this._movieRepository);

  MovieDetailModel? _movie;
  MovieDetailModel? get movie => _movie; // Mengembalikan _movie, bukan getter-nya sendiri

  Future<void> getDetail(BuildContext context, {required int id}) async {
    _movie = null;
    notifyListeners();
    final result = await _movieRepository.getDetail(id: id);
    result.fold(
      (messageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(messageError)),
        );
        _movie = null;
        notifyListeners();
        return;
      },
      (response) {
        // Update nilai _movie dengan data yang diterima
        _movie = response;
        notifyListeners(); // Informasikan perubahan data ke listener
        return;
      },
    );
  }
}
