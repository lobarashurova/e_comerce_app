import 'package:auto_route/auto_route.dart';
import 'package:e_comerce_app/common/base/base_app_bar.dart';
import 'package:e_comerce_app/common/extensions/number_extensions.dart';
import 'package:e_comerce_app/common/extensions/text_extensions.dart';
import 'package:e_comerce_app/common/extensions/theme_extensions.dart';
import 'package:e_comerce_app/common/extensions/widget.dart';
import 'package:e_comerce_app/common/gen/assets.gen.dart';
import 'package:e_comerce_app/data/api_models/product/product_model.dart';
import 'package:e_comerce_app/data/local_models/basket_model/basket_model.dart';
import 'package:e_comerce_app/presentation/app_widgets/common_button.dart';
import 'package:e_comerce_app/presentation/main/basket/bloc/basket_bloc.dart';
import 'package:e_comerce_app/presentation/main/basket/widget/basket_widget.dart';
import 'package:e_comerce_app/presentation/main/basket/widget/clear_basket_dialog.dart';
import 'package:e_comerce_app/presentation/main/basket/widget/success_placed_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bloc/basket_event.dart';
import 'bloc/basket_state.dart';

@RoutePage()
class BasketPage extends StatefulWidget {
  const BasketPage({Key? key}) : super(key: key);

  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C111D),
      appBar: BaseAppBar(
        title: "Корзина",
        actions: [
          GestureDetector(
            onTap: () => showDialog(
                context: context,
                builder: (context) => const ClearBasketDialog()),
            child: Assets.icons.delete.svg(),
          ),
          12.kw
        ],
      ),
      body: BlocBuilder<BasketBloc, BasketState>(
        builder: (context, state) {
          if (state is BasketLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BasketLoaded) {
            if (state.basketItems.isEmpty) {
              return _buildEmptyBasket();
            }
            return _buildBasketContent(state);
          } else if (state is BasketError) {
            return Center(
                child: "Error: ${state.message}"
                    .s(16)
                    .c(context.colors.onPrimary)
                    .sfDisplay());
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildEmptyBasket() {
    return Center(
      child: Assets.images.empty.image(width: 1.sw, height: 350.h),
    );
  }

  Widget _buildBasketContent(BasketLoaded state) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  children: [
                    ...state.basketItems.map((item) => BasketWidget(
                          productModel: BasketLocalModel(
                              id: item.id,
                              name: "${item.name}",
                              price: item.price,
                              image: item.image,
                              count: item.count),
                          count: item.count ?? 0,
                          onIncrement: () =>
                              _updateItemCount(item, (item.count ?? 0) + 1),
                          onDecrement: () {
                            if ((item.count ?? 0) > 1) {
                              _updateItemCount(item, (item.count ?? 0) - 1);
                            }
                          },
                        )),
                    _buildSummaryCard(state),
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 16,
          right: 16,
          left: 16,
          child: CommonButton.elevated(
            text: "Оффармиления заказ",
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => SuccessPlacedDialog());
            },
          ),
        )
      ],
    );
  }

  Widget _buildSummaryCard(BasketLoaded state) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1F2E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              "Товары, ${state.basketItems.length} шт."
                  .s(15)
                  .w(400)
                  .c(context.colors.title)
                  .sfDisplay(),
              "${(state.totalAmount.toFormattedString())} монет"
                  .s(13)
                  .w(500)
                  .c(context.colors.onPrimary)
                  .sfDisplay(),
            ],
          ),
          12.kh,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              "Скидка".s(15).w(400).c(context.colors.title).sfDisplay(),
              "0 монет".s(13).w(500).c(context.colors.onPrimary).sfDisplay(),
            ],
          ),
          const Divider(height: 32, color: Color(0xFF292D3E)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              "Итого к оплате"
                  .s(16)
                  .w(600)
                  .c(context.colors.onPrimary)
                  .sfDisplay(),
              "${state.totalAmount.toFormattedString()} монет"
                  .s(16)
                  .w(500)
                  .c(context.colors.onPrimary)
                  .sfDisplay(),
            ],
          ),
        ],
      ),
    );
  }

  void _updateItemCount(BasketLocalModel item, int newCount) {
    final updatedItem = BasketLocalModel(
      id: item.id,
      name: item.name,
      image: item.image,
      price: item.price,
      count: newCount,
    );
    context.read<BasketBloc>().add(UpdateProductCountEvent(updatedItem));
  }
}
