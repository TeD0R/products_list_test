import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:products_list_test/injection.dart';

import '../../api/dto/movie.dart';
import '../../api/repo/product_repository.dart';

part 'movie_bloc.freezed.dart';
part 'movie_event.dart';
part 'movie_state.dart';

@LazySingleton()
class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository _movieRepository = getIt<MovieRepository>();

  MovieBloc() : super(const MovieState.initial()) {
    on<FetchMovies>(_onFetchMovies);
    on<ForceUpdate>(_onForceRefresh);
  }

  Future<void> _onForceRefresh(
      ForceUpdate event, Emitter<MovieState> emit) async {
    await _fetchMovies(event, emit, forceRefresh: true);
  }

  Future<void> _onFetchMovies(
      FetchMovies event, Emitter<MovieState> emit) async {
    await _fetchMovies(event, emit, forceRefresh: false);
  }

  Future<void> _fetchMovies(MovieEvent event, Emitter<MovieState> emit,
      {bool forceRefresh = false}) async {
    emit(const MovieState.loading());

    final Either<String, List<Movie>> result =
        await _movieRepository.getMovies(forceRefresh: forceRefresh);

    result.fold(
      (error) => emit(MovieState.error(error)),
      (products) => emit(MovieState.loaded(products)),
    );
  }
}
