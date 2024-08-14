part of 'product_bloc.dart';

@freezed
abstract class ProductEvent with _$ProductEvent {
  const factory ProductEvent.fetchProducts() = FetchProducts;
  const factory ProductEvent.forceUpdate() = ForceUpdate;
}