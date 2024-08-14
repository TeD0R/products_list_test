import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:products_list_test/injection.dart';

import '../../api/dto/product.dart';
import '../../api/repo/product_repository.dart';

part 'product_bloc.freezed.dart';
part 'product_event.dart';
part 'product_state.dart';

@LazySingleton()
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository = getIt<ProductRepository>();

  ProductBloc() : super(const ProductState.initial()) {
    on<FetchProducts>(_onFetchProducts);
    on<ForceUpdate>(_onForceRefresh);
  }

  Future<void> _onForceRefresh(
      ForceUpdate event, Emitter<ProductState> emit) async {
    await _fetchProducts(event, emit, forceRefresh: true);
  }

  Future<void> _onFetchProducts(
      FetchProducts event, Emitter<ProductState> emit) async {
    await _fetchProducts(event, emit, forceRefresh: false);
  }

  Future<void> _fetchProducts(ProductEvent event, Emitter<ProductState> emit,
      {bool forceRefresh = false}) async {
    emit(const ProductState.loading());

    final Either<String, List<Product>> result =
        await _productRepository.getProducts(forceRefresh: forceRefresh);

    result.fold(
      (error) => emit(ProductState.error(error)),
      (products) => emit(ProductState.loaded(products)),
    );
  }
}
