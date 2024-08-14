import 'package:dartz/dartz.dart';
import 'package:products_list_test/api/client/custom_http_client.dart';

import '../../injection.dart';
import '../dto/product.dart';

class ProductService {
  final _httpClient = getIt<CustomHttpClient>();
  static const String _productsUrl = 'https://dummyjson.com/products';

  Future<Either<String, List<Product>>> fetchProducts() async {
    final Uri url = Uri.parse(_productsUrl);

    final Either<String, Map<String, dynamic>> result =
        await _httpClient.getJson(url);

    return result.fold(
      (error) => left(error),
      (data) {
        final List<dynamic> productData = data['products'];
        final List<Product> products =
            productData.map((json) => Product.fromJson(json)).toList();

        return right(products);
      },
    );
  }
}
