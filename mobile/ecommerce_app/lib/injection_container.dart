import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'core/platform/network_info.dart';
import 'data/data_sources/local_data_source.dart';
import 'data/data_sources/remote_data_source.dart';
import 'data/repositories/product_repository_impl.dart';
import 'domain/repositories/product_repository.dart';
import 'domain/usecases/create_product.dart';
import 'domain/usecases/delete_product.dart';
import 'domain/usecases/update_product.dart';
import 'domain/usecases/view_all_product.dart';
import 'domain/usecases/view_specific_product.dart';
import 'presentation/bloc/product_bloc.dart';

final locator = GetIt.instance;

void setUpLocator() {
  //bloc
  locator.registerFactory(() => ProductBloc(
        createProductUsecase: locator(),
        deleteProductUsecase: locator(),
        viewProductUsecase: locator(),
        viewAllProductsUsecase: locator(),
        updateProductUsecase: locator(),
      ));
  // uscases
  locator.registerLazySingleton(() => CreateProductUsecase(locator()));
  locator.registerLazySingleton(() => DeleteProductUsecase(locator()));
  locator.registerLazySingleton(() => ViewProductUsecase(locator()));
  locator.registerLazySingleton(() => ViewAllProductsUsecase(locator()));
  locator.registerLazySingleton(() => UpdateProductUsecase(locator()));

  // repository
  locator.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(
        networkInfo: locator(),
        productRemoteDataSource: locator(),
        productLocalDataSource: locator(),
      ));

  // data sources
  locator.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(client: locator()));

  locator.registerLazySingleton<ProductLocalDataSource>(
      () => ProductLocalDataSourceImpl(sharedPreferences: locator()));

  // core
  locator.registerLazySingleton(() => NetworkInfoImpl(locator()));

  // external
  locator.registerLazySingleton(() => http.Client());

  // locator.registerLazySingleton(() => SharedPreferences.getInstance());
  locator.registerLazySingletonAsync<SharedPreferences>(
      () async => await SharedPreferences.getInstance());
}
