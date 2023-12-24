import 'package:cleanex/flavors.dart';

class ApiConstance{
  static String baseUrl = F.appFlavor == Flavor.pro
      ? "https://jsonplaceholder.typicode.com/"
      : "https://jsonplaceholder.typicode.com/";
  static String getAppBaseUrl() => baseUrl;


  static const String posts = "posts";
}