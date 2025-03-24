import 'package:e_comerce_app/common/base/base_app_bar.dart';
import 'package:e_comerce_app/common/extensions/navigation_extensions.dart';
import 'package:e_comerce_app/common/extensions/text_extensions.dart';
import 'package:e_comerce_app/common/extensions/theme_extensions.dart';
import 'package:e_comerce_app/common/extensions/widget.dart';
import 'package:e_comerce_app/main.dart';
import 'package:e_comerce_app/presentation/main/basket/bloc/basket_bloc.dart';
import 'package:e_comerce_app/presentation/main/basket/bloc/basket_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClearBasketDialog extends StatelessWidget {
  const ClearBasketDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: context.colors.primary2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            "Очистить корзину".s(24).w(700).a(TextAlign.center).c(context.colors.onPrimary),
            16.kh,
            "Вы уверены, что хотите очистить корзину?".s(16).a(TextAlign.center).c(context.colors.display),
            24.kh,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: "Нет".s(16).w(500),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.colors.primary,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                16.kw,
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                     context.read<BasketBloc>().add(ClearBasketEvent());
                     context.pop();
                    },
                    child: "Да".s(16).w(500),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF28293D),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
