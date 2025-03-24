import 'package:e_comerce_app/common/router/app_router.dart';
import 'package:e_comerce_app/di/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';


final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  await getIt.init();
  getIt.registerLazySingleton(() => AppRouter());
}
