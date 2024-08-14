part of 'product_bloc.dart';

@freezed
abstract class ProductState with _$ProductState {
  const factory ProductState.initial() = Initial;
  const factory ProductState.loading() = Loading;
  const factory ProductState.loaded(List<Product> products) = Loaded;
  const factory ProductState.error(String error) = Error;
}