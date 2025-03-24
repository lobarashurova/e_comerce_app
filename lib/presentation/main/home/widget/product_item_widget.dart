import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:e_comerce_app/common/extensions/text_extensions.dart';
import 'package:e_comerce_app/common/extensions/theme_extensions.dart';
import 'package:e_comerce_app/common/extensions/widget.dart';
import 'package:e_comerce_app/common/router/app_router.dart';
import 'package:e_comerce_app/data/api_models/product/product_model.dart';
import 'package:e_comerce_app/data/local_models/favourite/favourite_model.dart';
import 'package:e_comerce_app/main.dart';
import 'package:e_comerce_app/presentation/app_widgets/cached_image_widget.dart';
import 'package:e_comerce_app/presentation/food_detail/food_detail_page.dart';
import 'package:e_comerce_app/presentation/main/basket/bloc/basket_bloc.dart';
import 'package:e_comerce_app/presentation/main/basket/bloc/basket_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:like_button/like_button.dart';

class ProductItemWidget extends StatefulWidget {
  const ProductItemWidget({super.key, required this.productModel});
  final ProductModel productModel;

  @override
  State<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
  bool isSelected=false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        showModalBottomSheet(
          context: context,
          builder: (context) => FoodDetailPage(productModel: widget.productModel),
          isScrollControlled: true,
          showDragHandle: false,
          isDismissible: true,
          backgroundColor: Colors.transparent,
          transitionAnimationController: AnimationController(
            vsync: Navigator.of(context),
            duration: const Duration(milliseconds: 500),
          ),
          barrierColor: Colors.black54,
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 58, sigmaY: 58),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            color: Colors.black.withOpacity(0.24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDrinkImage(),
                (widget.productModel.title ?? "").s(16).w(400).c(context.colors.onPrimary).m(1).o(TextOverflow.ellipsis),
                12.kh,
                _buildActionContainer(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDrinkImage() {
    return AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: CachedImageView(
          imageUrl: widget.productModel.thumbnail ?? "",
        ),
      ),
    );
  }

  Widget _buildActionContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: context.colors.primary2.withOpacity(0.24),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child:_buildAddToCartButton(context),
    );
  }


  Widget _buildAddToCartButton(BuildContext context) {
    return Row(
      children: [
        const Icon(CupertinoIcons.add, size: 16, color: Colors.white),
        4.kw,
        Flexible(
          child: ('${widget.productModel.price} монет')
              .s(15)
              .sfDisplay()
              .w(500)
              .c(context.colors.onPrimary).o(TextOverflow.ellipsis).m(1),
        ),
      ],
    );
  }
}
