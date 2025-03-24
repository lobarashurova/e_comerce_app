import 'package:auto_route/auto_route.dart';
import 'package:e_comerce_app/common/extensions/navigation_extensions.dart';
import 'package:e_comerce_app/common/extensions/text_extensions.dart';
import 'package:e_comerce_app/common/extensions/theme_extensions.dart';
import 'package:e_comerce_app/common/extensions/widget.dart';
import 'package:e_comerce_app/common/gen/assets.gen.dart';
import 'package:e_comerce_app/data/api_models/product/product_model.dart';
import 'package:e_comerce_app/presentation/favourite/fav_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc/product_bloc.dart';
import 'bloc/product_event.dart';
import 'bloc/product_state.dart';
import 'widget/product_item_widget.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom() &&
        context.read<ProductBloc>().state is ProductLoaded &&
        !(context.read<ProductBloc>().state as ProductLoaded).hasReachedMax) {
      context.read<ProductBloc>().add(FetchMoreProductsEvent());
    }
  }

  bool _isBottom() {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    // print("maxScroll :: $maxScroll :: \n :: $currentScroll");
    return currentScroll >= (maxScroll * 0.8);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is ProductError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.message}')),
          );
        }
      },
      builder: (context, state) {
        List<ProductModel> products = [];
        bool isLoading = false;
        if (state is ProductLoaded) {
          products = state.products;
        } else if (state is ProductLoading) {
          products = state.oldProducts;
          isLoading = true;
        } else if (state is ProductError) {
          products = state.oldProducts;
        }
        return Scaffold(
          backgroundColor: context.colors.primary01,
          body: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                title: 'Фреш'.s(16).w(400).sfDisplay(),
                backgroundColor: context.colors.primary01,
                pinned: true,
                elevation: 0,
                expandedHeight: 400.h,
                flexibleSpace: FlexibleSpaceBar(
                  background: Assets.images.lemon.image(fit: BoxFit.cover),
                ),
                actions: [
                  IconButton(
                    icon: Icon(CupertinoIcons.heart_fill, color: context.colors.warningDark,),
                    onPressed: () {
                      context.push(const FavouritePage());
                      // context.read<ProductBloc>().add(const FetchProductsEvent(refresh: true));
                    },
                  ),
                ],
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.73,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      if (index >= products.length) {
                        return  SizedBox(
                            width: 1.sw,
                            child: Center(child: CupertinoActivityIndicator(color: context.colors.primary, radius: 15,)));
                      }
                      final drink = products[index];
                      return ProductItemWidget(
                        productModel: drink,
                      );
                    },
                    childCount: (state is ProductLoaded && !state.hasReachedMax || isLoading)
                        ? products.length + 1
                        : products.length,
                  ),
                ),
              ),
              // if (state is ProductLoading && state.isFirstFetch)
              //    SliverFillRemaining(
              //     child: Center(child: CupertinoActivityIndicator(color: context.colors.primary, radius: 15,)),
              //   ),
              if (products.isEmpty && !(state is ProductLoading && state.isFirstFetch))
                SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        "Товаров не осталось".s(16).w(500).c(context.colors.primary2).sfDisplay(),
                        16.kh,
                        ElevatedButton(
                          onPressed: () {
                            context.read<ProductBloc>().add(const FetchProductsEvent(refresh: true));
                          },
                          child: "Обновить".s(14).sfDisplay().w(500),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
