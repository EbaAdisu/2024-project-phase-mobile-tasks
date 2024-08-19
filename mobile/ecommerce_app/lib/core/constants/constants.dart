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
}

const cachedProducts = 'CACHED_PRODUCTS';
