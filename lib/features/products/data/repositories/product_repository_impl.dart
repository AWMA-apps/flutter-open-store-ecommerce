import 'package:dartz/dartz.dart';
import 'package:open_store/core/error/Failure.dart';
import 'package:open_store/features/products/data/data_source/product_remote_data_source.dart';
import 'package:open_store/features/products/domain/entities/Product.dart';
import 'package:open_store/features/products/domain/repository/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      return Right(await remoteDataSource.getAllProducts());
    } catch (e) {
      return Left(ServerFailer("Server Failer!"));
    }
  }
}

class ServerFailer extends Failure {
  ServerFailer(super.message);
}
