import 'package:auto_route/auto_route.dart';
import 'package:e_comerce_app/data/api_models/product/product_model.dart';
import 'package:e_comerce_app/presentation/food_detail/food_detail_page.dart';
import 'package:e_comerce_app/presentation/main/basket/basket_page.dart';
import 'package:e_comerce_app/presentation/main/branches/branches_page.dart';
import 'package:e_comerce_app/presentation/main/home/home_page.dart';
import 'package:e_comerce_app/presentation/main/main_page.dart';
import 'package:e_comerce_app/presentation/main/profile/profile_page.dart';
import 'package:flutter/cupertino.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  final List<AutoRoute> routes = [
    /// Main
    AutoRoute(
      initial: true,
      page: MainRoute.page,
      children: [
        CustomRoute(
          page: HomeRoute.page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          durationInMilliseconds: 300,
        ),
        CustomRoute(
            page: BasketRoute.page,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: BranchesRoute.page,
            transitionsBuilder: TransitionsBuilders.fadeIn),
        CustomRoute(
            page: ProfileRoute.page,
            transitionsBuilder: TransitionsBuilders.fadeIn),
      ],
    ),
    AutoRoute(page: BranchesRoute.page)
  ];
}
