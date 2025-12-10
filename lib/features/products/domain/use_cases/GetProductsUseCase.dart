import 'package:dartz/dartz.dart';
import 'package:open_store/core/error/Failure.dart';
import 'package:open_store/features/products/domain/entities/Product.dart';
import 'package:open_store/features/products/domain/repository/product_repository.dart';

class GetProductUseCase {
  final ProductRepository repository;

  GetProductUseCase(this.repository);

  Future<Either<Failure, List<Product>>> call() async {
    return await repository.getProducts();
  }
}
