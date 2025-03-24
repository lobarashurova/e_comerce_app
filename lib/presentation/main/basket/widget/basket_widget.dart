import 'package:e_comerce_app/common/extensions/text_extensions.dart';
import 'package:e_comerce_app/common/extensions/theme_extensions.dart';
import 'package:e_comerce_app/common/extensions/widget.dart';
import 'package:e_comerce_app/data/api_models/product/product_model.dart';
import 'package:e_comerce_app/data/local_models/basket_model/basket_model.dart';
import 'package:e_comerce_app/presentation/app_widgets/cached_image_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BasketWidget extends StatelessWidget {
  final BasketLocalModel productModel;
  final int count;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const BasketWidget({
    Key? key,
    required this.productModel,
    this.count = 1,
    required this.onIncrement,
    required this.onDecrement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1F2E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: CachedImageView(
             imageUrl:  productModel.image ?? "",
             width: 60.w,
             height: 60.h,
            ),
          ),
          12.kw,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (productModel.name ?? "")
                    .s(13)
                    .w(400)
                    .c(context.colors.onPrimary)
                    .sfDisplay(),
                4.kh,
                "${productModel.price} монет"
                    .s(15)
                    .w(600)
                    .c(context.colors.onPrimary)
                    .sfDisplay(),
              ],
            ),
          ),
          Row(
            children: [
              InkWell(
                onTap: onDecrement,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: context.colors.primary2,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child:  Icon(
                    CupertinoIcons.minus,
                    color: Colors.white,
                  ),
                ),
              ),

              // Item count
              SizedBox(
                width: 40,
                child: Center(
                  child: "$count"
                      .s(16)
                      .w(600)
                      .c(context.colors.onPrimary)
                      .sfDisplay(),
                ),
              ),

              // Increment button
              InkWell(
                onTap: onIncrement,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: context.colors.primary2,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child:  Icon(
                    CupertinoIcons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
