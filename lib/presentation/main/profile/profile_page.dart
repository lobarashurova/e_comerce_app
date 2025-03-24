import 'package:auto_route/auto_route.dart';
import 'package:e_comerce_app/common/base/base_app_bar.dart';
import 'package:e_comerce_app/common/extensions/text_extensions.dart';
import 'package:e_comerce_app/common/extensions/theme_extensions.dart';
import 'package:e_comerce_app/common/extensions/widget.dart';
import 'package:e_comerce_app/common/gen/assets.gen.dart';
import 'package:e_comerce_app/presentation/main/profile/widget/edit_name_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name="User";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.primary2,
      appBar: BaseAppBar(
        title: "Профиль",
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile card
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: context.colors.primary2,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Assets.icons.profile.image(),
                  16.kw,
                  Expanded(
                    child: name.w(700).s(20).c(context.colors.onPrimary).sfDisplay(),
                  ),
                  GestureDetector(
                      onTap: (){
                        showDialog(context: context, builder: (context)=>CustomNameEditDialog(currentName: name, onNameSaved: (currName){
                          setState(() {
                            name=currName;
                          });
                        }));
                      },
                      child: Assets.icons.edit.svg()),
                ],
              ),
            ),

            16.kh,
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: context.colors.primary2,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Assets.icons.wallet.svg(),
                  32.kw,
                  Expanded(
                    child: "Баланс".w(400).s(18).c(context.colors.onPrimary).sfDisplay(),
                  ),

                  Row(
                    children: [
                      "250 000".w(500).s(15).c(context.colors.onPrimary).sfDisplay(),
                      const SizedBox(width: 4),
                      "монет".w(400).s(15).c(context.colors.display).sfDisplay(),
                    ],
                  ),
                ],
              ),
            ),
            16.kh,
            Container(
              decoration: BoxDecoration(
                color: context.colors.primary2,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  buildMenuItem(
                    context,
                    Assets.icons.history.svg(),
                    "Заказы",
                  ),
                  const Divider(height: 1, color: Color(0xFF292D3E)),
                  buildMenuItem(
                    context,
                    Assets.icons.settings02.svg(),
                    "Настройки",
                  ),
                  const Divider(height: 1, color: Color(0xFF292D3E)),
                  buildMenuItem(
                    context,
                    Assets.icons.headphone.svg(),
                    "Служба поддержки",
                  ),
                  const Divider(height: 1, color: Color(0xFF292D3E)),
                  buildMenuItem(
                    context,
                    Assets.icons.logOut01.svg(),
                    "Выйти",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(BuildContext context, Widget icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        leading: icon,
        title: title.w(500).s(16).c(context.colors.onPrimary).sfDisplay(),
        trailing:  Icon(
          CupertinoIcons.chevron_right,
          color: Colors.grey,
        ),
        onTap: () {},
      ),
    );
  }
}
