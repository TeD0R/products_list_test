library product_list;

import 'package:flutter/material.dart';

part 'favorites_view.dart';

class FavoritesPage extends StatefulWidget {

  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => FavoritesPageState();
}

class FavoritesPageState extends State<FavoritesPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FavoritesView(
      state: this,
    );
  }
}
