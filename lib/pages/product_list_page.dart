library product_list;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../application/products/product_bloc.dart';

part 'product_list_view.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => ProductListPageState();
}

class ProductListPageState extends State<ProductListPage> {


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return ProductListView(
      pageState: this,
    );
  }
}
