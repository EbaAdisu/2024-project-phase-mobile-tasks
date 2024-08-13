import 'package:ecommerce_app/core/platform/network_info.dart';
import 'package:ecommerce_app/data/data_sources/local_data_source.dart';
import 'package:ecommerce_app/data/data_sources/remote_data_source.dart';
import 'package:ecommerce_app/domain/repositories/product_repository.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';

@GenerateMocks(
  [
    ProductRepository,
    ProductRemoteDataSource,
    ProductLocalDataSource,
    SharedPreferences,
    NetworkInfo
  ],
  customMocks: [
    MockSpec<http.Client>(as: #MockHttpClient),
  ],
)
void main() {}
