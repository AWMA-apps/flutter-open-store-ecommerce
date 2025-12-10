import 'dart:async';
import 'package:open_store/core/network/DioClient.dart';
import 'package:open_store/features/products/data/data_source/product_remote_data_source.dart';
import 'package:open_store/features/products/data/repositories/product_repository_impl.dart';
import 'package:open_store/features/products/domain/entities/Product.dart';
import 'package:open_store/features/products/domain/repository/product_repository.dart';
import 'package:open_store/features/products/domain/use_cases/GetProductsUseCase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient();
});

final productRemoteDataSourceProvider = Provider<ProductRemoteDataSource>((
  ref,
) {
  return ProductRemoteDataSourceImpl(ref.read(dioClientProvider));
});

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepositoryImpl(ref.read(productRemoteDataSourceProvider));
});

final getProductsUseCaseProvider = Provider<GetProductUseCase>((ref) {
  return GetProductUseCase(ref.read(productRepositoryProvider));
});

class ProductsNotifier extends AsyncNotifier<List<Product>> {
  @override
  FutureOr<List<Product>> build() {
    return _fetchProducts();
  }

  Future<List<Product>> _fetchProducts() async {
    final getProductsUseCase = ref.read(getProductsUseCaseProvider);

    final result = await getProductsUseCase.call();

    return result.fold(
      (failure) => throw Exception("Server Error"),
      (products) => products,
    );
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchProducts());
  }
}

final productProvider = AsyncNotifierProvider<ProductsNotifier, List<Product>>(
  () => ProductsNotifier(),
);
