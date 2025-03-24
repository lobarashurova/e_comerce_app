import 'package:auto_route/auto_route.dart';
import 'package:e_comerce_app/common/extensions/theme_extensions.dart';
import 'package:e_comerce_app/common/gen/assets.gen.dart';
import 'package:e_comerce_app/common/router/app_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: AutoTabsScaffold(
        routes: const [HomeRoute(),  BasketRoute(), BranchesRoute(), ProfileRoute()],
        bottomNavigationBuilder: (context, tabsRouter) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            showSelectedLabels: true,
            selectedLabelStyle: TextStyle(
              color: context.colors.primary,
              fontWeight: FontWeight.w600,
              fontFamily: 'SF Pro Text',
              fontSize: 10,
            ),
            unselectedLabelStyle: TextStyle(
              color: context.colors.title,
              fontWeight: FontWeight.w600,
              fontFamily: 'SF Pro Text',
              fontSize: 10,
            ),
            selectedItemColor: context.colors.primary,
            unselectedItemColor: context.colors.title,
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                activeIcon:
                Assets.icons.homeUnselected.svg(color: context.colors.primary),
                icon: Assets.icons.homeUnselected.svg(),
                label: "Главная",
              ),
              BottomNavigationBarItem(
                activeIcon:Icon(CupertinoIcons.shopping_cart, color: context.colors.primary,),
                icon:  Icon(CupertinoIcons.shopping_cart),
                label: "Корзинка",
              ),
              BottomNavigationBarItem(
                activeIcon:Icon(CupertinoIcons.map_fill, color: context.colors.primary,),
                icon:  Icon(CupertinoIcons.map_fill),
                label: "Карта",
              ),
              BottomNavigationBarItem(
                activeIcon: Icon(CupertinoIcons.line_horizontal_3, color: context.colors.primary,),
                icon: Icon(CupertinoIcons.line_horizontal_3),
                label: "Меню",
              ),
            ],
          );
        },
      ),
    );
  }
}
