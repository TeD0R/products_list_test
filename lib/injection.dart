import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:products_list_test/api/client/custom_http_client.dart';
import 'package:products_list_test/api/repo/product_repository.dart';
import 'package:products_list_test/api/services/product_service.dart';

import 'application/products/product_bloc.dart';

final GetIt getIt = GetIt.instance;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

Future<void> setup() async {
  getIt
    ..registerSingleton<CustomHttpClient>(CustomHttpClient(http.Client()))
    ..registerLazySingleton<ProductService>(() => ProductService())
    ..registerLazySingleton<ProductRepository>(() => ProductRepository())
    ..registerLazySingleton<ProductBloc>(() => ProductBloc());
}
