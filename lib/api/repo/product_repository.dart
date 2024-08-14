import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:products_list_test/api/services/product_service.dart';
import 'package:products_list_test/injection.dart';

import '../dto/product.dart';

@LazySingleton()
class ProductRepository {
  final ProductService _productService = getIt<ProductService>();

  List<Product> _cachedProducts = [];

  Future<Either<String, List<Product>>> getProducts(
      {bool forceRefresh = false}) async {

    if (_cachedProducts.isNotEmpty && !forceRefresh) {
      return right(_cachedProducts);
    }

    final result = await _productService.fetchProducts();

    return result.fold(
      (error) => left(error),
      (products) {
        _cachedProducts = products;
        return right(products);
      },
    );

  }

  void clearCache() {
    _cachedProducts.clear();
  }
}
