library product_list;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../application/products/movie_bloc.dart';

part 'movie_list_view.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({super.key});

  @override
  State<MovieListPage> createState() => MovieListPageState();
}

class MovieListPageState extends State<MovieListPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MovieListView(
      pageState: this,
    );
  }
}
