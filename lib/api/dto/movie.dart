import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie {
  final String id;
  final String title;
  final String year;
  final List<String> genres;
  final List<double> ratings;
  final String? poster;
  final String? contentRating;

  @_DurationConverter()
  final Duration? duration;

  @JsonKey(fromJson: _releaseDateFromJson, toJson: _releaseDateToJson)
  final DateTime? releaseDate;

  final double? averageRating;
  final String? originalTitle;
  final String? storyline;
  final List<String> actors;

  @JsonKey(fromJson: _imdbRatingFromJson, toJson: _imdbRatingToJson)
  final String imdbRating;


  final String? posterUrl;

  Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.genres,
    required this.ratings,
    this.poster,
    this.contentRating,
    this.duration,
    this.releaseDate,
    this.averageRating,
    this.originalTitle,
    this.storyline,
    required this.actors,
    required this.imdbRating,
    this.posterUrl,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  Map<String, dynamic> toJson() => _$MovieToJson(this);

  // DateTime converter
  static DateTime? _releaseDateFromJson(String? date) =>
      date != null ? DateTime.tryParse(date) : null;
  static String? _releaseDateToJson(DateTime? date) => date?.toIso8601String();

  // IMDb rating conversion
  static String _imdbRatingFromJson(dynamic value) => value.toString();
  static dynamic _imdbRatingToJson(String value) => value;
}

// Duration converter
class _DurationConverter implements JsonConverter<Duration?, String?> {
  const _DurationConverter();

  @override
  Duration? fromJson(String? json) {
    if (json == null) return null;
    final regex = RegExp(r'PT(\d+)M');
    final match = regex.firstMatch(json);
    return match != null ? Duration(minutes: int.parse(match.group(1)!)) : null;
  }

  @override
  String? toJson(Duration? object) => object != null ? 'PT${object.inMinutes}M' : null;
}
