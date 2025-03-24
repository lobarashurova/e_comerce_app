import 'package:e_comerce_app/common/extensions/navigation_extensions.dart';
import 'package:e_comerce_app/common/extensions/text_extensions.dart';
import 'package:e_comerce_app/common/extensions/theme_extensions.dart';
import 'package:e_comerce_app/common/extensions/widget.dart';
import 'package:e_comerce_app/data/api_models/product/product_model.dart';
import 'package:e_comerce_app/data/local_models/basket_model/basket_model.dart';
import 'package:e_comerce_app/data/local_models/favourite/favourite_model.dart';
import 'package:e_comerce_app/presentation/app_widgets/cached_image_widget.dart';
import 'package:e_comerce_app/presentation/app_widgets/common_button.dart';
import 'package:e_comerce_app/presentation/app_widgets/notification_view.dart';
import 'package:e_comerce_app/presentation/main/basket/bloc/basket_bloc.dart';
import 'package:e_comerce_app/presentation/main/basket/bloc/basket_event.dart';
import 'package:e_comerce_app/presentation/main/basket/bloc/basket_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:like_button/like_button.dart';

class FoodDetailPage extends StatefulWidget {
  const FoodDetailPage({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  State<FoodDetailPage> createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage>
    with SingleTickerProviderStateMixin {
  bool isSelected=false;

  @override
  void initState() {
    context.read<BasketBloc>().add(CheckProductInFavoritesEvent(widget.productModel.id ?? 0));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return
      BlocListener<BasketBloc, BasketState>(
        listener: (context, state) {
      if (state is ProductFavoriteStatus) {
        setState(() {
          isSelected = state.isInFavorites;
        });
      }
    },
    child:   DraggableScrollableSheet(
      initialChildSize: 0.85,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Hero(
                      tag: 'product-detail',
                      child: SingleChildScrollView(
                        controller: scrollController,
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            20.kh,
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              margin: EdgeInsets.symmetric(horizontal: 16.w),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: (widget.productModel.title ?? "")
                                  .s(20)
                                  .w(400)
                                  .a(TextAlign.center)
                                  .sfDisplay(),
                            ),
                            10.kh,
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.r),
                                child: CachedImageView(
                                  imageUrl: widget.productModel.thumbnail ?? "",
                                  width: 1.sw,
                                  height: 400.h,
                                ),
                              ),
                            ),
                            16.kh,
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child:
                                  "Вкус и яркий аромат этого прохладительного напитка знакомы каждому! Его мягкие карамельные нотки, облако воздушной пены и веселый шепот пузырьков уже более ста лет популярны. Обладает бодрящим эффектом. Рекомендуется пить охлажденным. Сильногазированный безалкогольный ароматизированный напиток"
                                      .s(15)
                                      .w(400)
                                      .c(context.colors.primary2)
                                      .sfDisplay(),
                            ),
                            30.kh, // Extra padding for button
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    child: CommonButton.elevated(
                      text: "${widget.productModel.price ?? "0"} монет",
                      icon: Icon(
                        CupertinoIcons.add,
                        color: context.colors.onPrimary,
                      ),
                      onPressed: () {
                        context
                            .read<BasketBloc>()
                            .add(AddProductToBasketEvent(BasketLocalModel(
                              id: widget.productModel.id ?? 0,
                              price: (widget.productModel.price ?? 0),
                              image: widget.productModel.thumbnail,
                              count: 1,
                          name: widget.productModel.title
                            )));
                        context.showElegantNotification(title: "Товар был успешно добавлен в корзину", type: NotificationType.success);
                        context.pop();
                      },
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 8,
                right: 8,
                child: LikeButton(
                  onTap: (isLike) async {
                    setState(() {
                      isSelected=!isSelected;
                    });
                    if(isSelected){
                      print("add producyt:::: \n :::::::: screen");
                      context.read<BasketBloc>().add(AddToFavouriteEvent(Product(
                          id: widget.productModel.id,
                          price: widget.productModel.price,
                          image: widget.productModel.thumbnail,
                          name: widget.productModel.title
                      )));
                    }else{
                      print("remove producyt:::: \n :::::::: screen");

                      context.read<BasketBloc>().add(RemoveProductFromFavEvent(widget.productModel.id ?? 0));
                    }
                    return isSelected;
                  },
                  isLiked: isSelected,
                  size: 30,
                  circleColor: CircleColor(
                      start: context.colors.warningLight,
                      end: context.colors.warningDark),
                  bubblesColor: BubblesColor(
                    dotPrimaryColor: context.colors.warningLight,
                    dotSecondaryColor: context.colors.warningDark,
                  ),
                  likeBuilder: (bool isLiked) {
                    return Icon(
                      CupertinoIcons.heart_fill,
                      color: isLiked
                          ? context.colors.warningDark
                          : context.colors.display,
                      size: 30,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    ));
  }
}
