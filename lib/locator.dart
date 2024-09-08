import 'package:ecommerce_app/helpers/navigation_helper.dart';
import 'package:get_it/get_it.dart';


GetIt locator = GetIt.instance;
void setupLocator() {
 // locator.registerLazySingleton(() => AppLocalizationsEn());
  locator.registerLazySingleton(() => NavigationHelper());
}


