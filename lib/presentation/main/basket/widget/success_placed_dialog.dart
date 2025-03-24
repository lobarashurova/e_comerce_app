import 'package:e_comerce_app/common/base/base_app_bar.dart';
import 'package:e_comerce_app/common/extensions/text_extensions.dart';
import 'package:e_comerce_app/common/extensions/theme_extensions.dart';
import 'package:e_comerce_app/main.dart';
import 'package:e_comerce_app/presentation/main/basket/bloc/basket_bloc.dart';
import 'package:e_comerce_app/presentation/main/basket/bloc/basket_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuccessPlacedDialog extends StatelessWidget {
  const SuccessPlacedDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color(0xFF1E2030),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Color(0xFF4DD0C8),
                shape: BoxShape.circle,
              ),
              child: Icon(
                CupertinoIcons.check_mark,
                color: Colors.white,
                size: 40,
              ),
            ),
            SizedBox(height: 24),
            "Успешно".s(24).w(700).a(TextAlign.center).c(context.colors.onPrimary),
            SizedBox(height: 16),
            "Ваш заказ успешно создан.\nСпасибо за покупку.".s(16).a(
                TextAlign.center).c(context.colors.display),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.read<BasketBloc>().add(ClearBasketEvent());
                  Navigator.of(context).pop();
                },
                child: "Вернуться".s(16).w(500),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4DD0C8),
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
      ),
    );
  }
}