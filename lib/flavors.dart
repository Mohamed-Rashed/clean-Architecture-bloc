enum Flavor {
  pro,
  dev,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.pro:
        return 'clean';
      case Flavor.dev:
        return 'clean Dev';
      default:
        return 'title';
    }
  }

}
