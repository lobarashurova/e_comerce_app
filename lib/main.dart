import 'package:e_comerce_app/common/extensions/theme_extensions.dart';
import 'package:e_comerce_app/common/router/app_router.dart';
import 'package:e_comerce_app/di/injection.dart';
import 'package:e_comerce_app/presentation/main/basket/bloc/basket_bloc.dart';
import 'package:e_comerce_app/presentation/main/basket/bloc/basket_event.dart';
import 'package:e_comerce_app/presentation/main/branches/bloc/branches_bloc.dart';
import 'package:e_comerce_app/presentation/main/branches/bloc/branches_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'common/theme/material_colors.dart';
import 'presentation/main/home/bloc/product_bloc.dart';
import 'presentation/main/home/bloc/product_event.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value)=>  runApp( MultiBlocProvider(
    providers: [
      BlocProvider<ProductBloc>(
        create: (context) => ProductBloc()..add(const FetchProductsEvent()),  // Load products on initialization
      ),
      BlocProvider<MapBloc>(
        create: (context) => MapBloc()..add(LoadMap()),  // Load products on initialization
      ),
      BlocProvider<BasketBloc>(
        create: (context) => BasketBloc()..add(LoadBasketEvent(),  // Load products on initialization
  )),
    ],
      child: MyApp())));

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp.router(
        title: 'E-commerce',
        debugShowCheckedModeBanner: false,
        routerConfig: getIt<AppRouter>().config(),
        theme: ThemeData(
          useMaterial3: false,
          primarySwatch: MaterialColors.vividCerulean,
          primaryColor: context.colors.primary,
          scaffoldBackgroundColor: context.colors.window,
          shadowColor: context.colors.onPrimary,
          highlightColor: context.colors.onPrimary,
          fontFamily: 'SF-Pro',
        ),
      ),
    );
  }
}


