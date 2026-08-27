enum Flavor { dev, prod }

class F {
  static late final Flavor appFlavor;

  static String get name => appFlavor.name;

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'Dev App';
      case Flavor.prod:
        return 'Prod App';
    }
  }

  static String get apiUrl {
    switch (appFlavor) {
      case Flavor.dev:
        return 'https://api.thedogapi.com/v1/breeds/1';
      case Flavor.prod:
        return 'https://api.thedogapi.com/v1/breeds/2';
    }
  }
}
