
class GeneralSingleton {
  static final GeneralSingleton _singleton = GeneralSingleton._internal();
  factory GeneralSingleton() {
    return _singleton;
  }

  GeneralSingleton._internal();
  // Create a shared varible

  String postsEnd = "";


}
