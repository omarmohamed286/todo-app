import 'package:get_it/get_it.dart';
import 'package:todo_app/services/api_service.dart';
import 'package:todo_app/services/cache_service.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingleton<ApiService>(ApiService());
  getIt.registerSingleton<CacheService>(CacheService());
}
