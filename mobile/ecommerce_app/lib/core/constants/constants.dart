class Urls {
  // static const String baseUrL = 'http://localhost:3000/';
  static const String baseUrL =
      'https://g5-flutter-learning-path-be.onrender.com/api/v1';
  static const String apiKey = 'api_key=1f54bd990f1cdfb230adb312546d765d';
  static String productId(String id) {
    return '${baseUrL}/products/$id?$apiKey';
  }

  static String product() {
    return '${baseUrL}/products?$apiKey';
  }

  static String imageUrl =
      'https://res.cloudinary.com/g5-mobile-track/image/upload/v1723932776/images/v6kve2yjfsodtzyhmj5q.png';
  static String authUrl = '${baseUrL}/auth';
}

const cachedProducts = 'CACHED_PRODUCTS';

class ErrorMessages {
  static const String noInternet = 'Failed to connect to the internet';
  static const String somethingWentWrong = 'Something went wrong';
  static const String serverError = 'An error has occurred';
  static const String cacheError = 'Failed to load cache';
  static const String socketError =
      'No Internet connection or server unreachable';
  static const String forbiddenError = 'Invalid Credentials! Please try again';
  static const String userAlreadyExists = 'User Already Exists';
}
