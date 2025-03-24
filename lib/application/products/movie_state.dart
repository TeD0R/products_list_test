part of 'movie_bloc.dart';

@freezed
abstract class MovieState with _$MovieState {
  const factory MovieState.initial() = Initial;
  const factory MovieState.loading() = Loading;
  const factory MovieState.loaded(List<Movie> movies) = Loaded;
  const factory MovieState.error(String error) = Error;
}