import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/platform/client.dart';
import 'core/platform/network_info.dart';
import 'features/auth/data/datasources/auth_local_data_source.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/get_user.dart';
import 'features/auth/domain/usecases/login.dart';
import 'features/auth/domain/usecases/logout.dart';
import 'features/auth/domain/usecases/register.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/product/data/data_sources/local_data_source.dart';
import 'features/product/data/data_sources/remote_data_source.dart';
import 'features/product/data/repositories/product_repository_impl.dart';
import 'features/product/domain/repositories/product_repository.dart';
import 'features/product/domain/usecases/create_product.dart';
import 'features/product/domain/usecases/delete_product.dart';
import 'features/product/domain/usecases/update_product.dart';
import 'features/product/domain/usecases/view_all_product.dart';
import 'features/product/domain/usecases/view_specific_product.dart';
import 'features/product/presentation/bloc/product_bloc.dart';

final locator = GetIt.instance;

Future<void> setUpLocator() async {
  // External dependencies
  locator.registerLazySingleton(() => http.Client());
  final shared = await SharedPreferences.getInstance();
  locator.registerLazySingleton<SharedPreferences>(() => shared);
  locator.registerLazySingleton(() => InternetConnectionChecker());

  // Core
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  // Data sources
  locator.registerLazySingleton<Client>(
      () => ClientImpl(client: locator(), authLocalDataSource: locator()));

  locator.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(sharedPreferences: locator()));
  locator.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(client: locator()));

  locator.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<ProductLocalDataSource>(
      () => ProductLocalDataSourceImpl(sharedPreferences: locator()));

  // Repository

  locator.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        remoteDataSource: locator(),
        localDataSource: locator(),
        networkInfo: locator(),
      ));
  locator.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(
        networkInfo: locator(),
        productRemoteDataSource: locator(),
        productLocalDataSource: locator(),
      ));

  // Use cases

  locator.registerLazySingleton(() => LoginUsecase(locator()));
  locator.registerLazySingleton(() => LogoutUsecase(locator()));
  locator.registerLazySingleton(() => RegisterUsecase(locator()));
  locator.registerLazySingleton(() => GetUserUsecase(locator()));

  locator.registerLazySingleton(() => CreateProductUsecase(locator()));
  locator.registerLazySingleton(() => DeleteProductUsecase(locator()));
  locator.registerLazySingleton(() => ViewProductUsecase(locator()));
  locator.registerLazySingleton(() => ViewAllProductsUsecase(locator()));
  locator.registerLazySingleton(() => UpdateProductUsecase(locator()));

  // Bloc
  locator.registerFactory(() => ProductBloc(
        createProductUsecase: locator(),
        deleteProductUsecase: locator(),
        viewProductUsecase: locator(),
        viewAllProductsUsecase: locator(),
        updateProductUsecase: locator(),
      ));
  locator.registerFactory(() => AuthBloc(
        locator(),
        locator(),
        locator(),
        locator(),
      ));
}
