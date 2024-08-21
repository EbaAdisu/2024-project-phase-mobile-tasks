import 'package:ecommerce_app/core/platform/client.dart';
import 'package:ecommerce_app/core/platform/network_info.dart';
import 'package:ecommerce_app/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:ecommerce_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:ecommerce_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/get_user.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/login.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/logout.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/register.dart';
import 'package:ecommerce_app/features/product/data/data_sources/local_data_source.dart';
import 'package:ecommerce_app/features/product/data/data_sources/remote_data_source.dart';
import 'package:ecommerce_app/features/product/domain/repositories/product_repository.dart';
import 'package:ecommerce_app/features/product/domain/usecases/create_product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/delete_product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/update_product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/view_all_product.dart';
import 'package:ecommerce_app/features/product/domain/usecases/view_specific_product.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';

@GenerateMocks(
  [
    ProductRepository,
    ProductRemoteDataSource,
    ProductLocalDataSource,
    InternetConnectionChecker,
    SharedPreferences,
    NetworkInfo,
    ViewProductUsecase,
    CreateProductUsecase,
    UpdateProductUsecase,
    ViewAllProductsUsecase,
    DeleteProductUsecase,
    Client,
    AuthRepository,
    AuthRemoteDataSource,
    AuthLocalDataSource,
    LoginUsecase,
    RegisterUsecase,
    LogoutUsecase,
    GetUserUsecase
  ],
  customMocks: [
    MockSpec<http.Client>(as: #MockHttpClient),
  ],
)
void main() {}
