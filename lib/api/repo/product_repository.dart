import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:products_list_test/api/services/product_service.dart';
import 'package:products_list_test/injection.dart';

import '../dto/movie.dart';

@LazySingleton()
class MovieRepository {
  final MovieService _movieService = getIt<MovieService>();

  List<Movie> _cachedMovies = [];

  Future<Either<String, List<Movie>>> getMovies(
      {bool forceRefresh = false}) async {

    if (_cachedMovies.isNotEmpty && !forceRefresh) {
      return right(_cachedMovies);
    }

    final result = await _movieService.fetchProducts();

    return result.fold(
      (error) => left(error),
      (movies) {
        _cachedMovies = movies;
        return right(movies);
      },
    );

  }

  void clearCachedMovies() {
    _cachedMovies.clear();
  }
}
