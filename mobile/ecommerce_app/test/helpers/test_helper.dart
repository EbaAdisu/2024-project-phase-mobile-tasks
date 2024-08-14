import 'package:ecommerce_app/core/platform/network_info.dart';
import 'package:ecommerce_app/data/data_sources/local_data_source.dart';
import 'package:ecommerce_app/data/data_sources/remote_data_source.dart';
import 'package:ecommerce_app/domain/repositories/product_repository.dart';
import 'package:ecommerce_app/domain/usecases/create_product.dart';
import 'package:ecommerce_app/domain/usecases/delete_product.dart';
import 'package:ecommerce_app/domain/usecases/update_product.dart';
import 'package:ecommerce_app/domain/usecases/view_all_product.dart';
import 'package:ecommerce_app/domain/usecases/view_specific_product.dart';
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
  ],
  customMocks: [
    MockSpec<http.Client>(as: #MockHttpClient),
  ],
)
void main() {}
