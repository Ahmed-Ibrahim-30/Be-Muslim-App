import 'View/Azquar_Night.dart';
import 'View/Azquar_Sapah.dart';
import 'View/Doaa_istikhaarah.dart';
import 'View/home_page.dart';

typedef T Constructor<T>();

final Map<String, Constructor<Object>> _constructors =
<String, Constructor<Object>>{};

void register<T>(Constructor<T> constructor) {
  _constructors[T.toString()] = constructor;
}

class ClassBuilder {
  static void registerClasses() {
    register<Home_Page>(() => Home_Page());
    register<Azquary_screen>(() => Azquary_screen());
    register<Night_Azquar>(() => Night_Azquar());
    register<Doaa_istikhaarah>(() => Doaa_istikhaarah());
  }

  static dynamic fromString(String type) {
    return _constructors[type]();
  }
}