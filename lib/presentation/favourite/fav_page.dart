import 'package:e_comerce_app/common/base/base_app_bar.dart';
import 'package:e_comerce_app/common/extensions/text_extensions.dart';
import 'package:e_comerce_app/common/extensions/theme_extensions.dart';
import 'package:e_comerce_app/common/gen/assets.gen.dart';
import 'package:e_comerce_app/common/theme/default_theme_colors.dart';
import 'package:e_comerce_app/data/api_models/product/product_model.dart';
import 'package:e_comerce_app/presentation/main/basket/bloc/basket_bloc.dart';
import 'package:e_comerce_app/presentation/main/basket/bloc/basket_event.dart';
import 'package:e_comerce_app/presentation/main/basket/bloc/basket_state.dart';
import 'package:e_comerce_app/presentation/main/home/widget/product_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
  return  BlocBuilder<BasketBloc, BasketState>(
      builder: (context, state) {
        if (state is BasketLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is BasketLoaded) {
          if (state.favoriteItems.isEmpty) {
            return Center(
              child: Assets.images.empty.image(),
            );
          }
          return Scaffold(
            backgroundColor: StaticColors.midnight,
            appBar: BaseAppBar(
              title: "Избранное",
            ),
            body: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.70,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: state.favoriteItems.length,
              itemBuilder: (context, index) {
                final item = state.favoriteItems[index];
                return ProductItemWidget(
                productModel: ProductModel(
                  id: item.id,
                  thumbnail: item.image,
                  title: item.name,
                  price: item.price
                ),
                );
              },
            ),
          );;
        } else if (state is BasketError) {
          return Center(child: "Error: ${state.message}".s(16).c(context.colors.onPrimary).sfDisplay());
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
