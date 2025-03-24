import 'package:dartz/dartz.dart';
import 'package:products_list_test/api/client/custom_http_client.dart';

import '../../injection.dart';
import '../dto/movie.dart';

class MovieService {
  final _httpClient = getIt<CustomHttpClient>();
  static const String _movieUrl = 'https://raw.githubusercontent.com/FEND16/movie-json-data/master/json/movies-coming-soon.json';

  Future<Either<String, List<Movie>>> fetchProducts() async {
    final Uri url = Uri.parse(_movieUrl);

    final Either<String, List<dynamic>> result =
        await _httpClient.getJsonList(url);

    return result.fold(
      (error) => left(error),
      (data) {
        final List<Movie> movies =
            data.map((json) => Movie.fromJson(json)).toList();

        return right(movies);
      },
    );
  }
}
