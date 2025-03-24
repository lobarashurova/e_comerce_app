import 'package:e_comerce_app/common/base/base_app_bar.dart';
import 'package:e_comerce_app/common/extensions/text_extensions.dart';
import 'package:e_comerce_app/common/extensions/theme_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomNameEditDialog extends StatefulWidget {
  final String currentName;
  final Function(String) onNameSaved;

  const CustomNameEditDialog({
    Key? key,
    required this.currentName,
    required this.onNameSaved,
  }) : super(key: key);

  @override
  _CustomNameEditDialogState createState() => _CustomNameEditDialogState();
}

class _CustomNameEditDialogState extends State<CustomNameEditDialog> {
  late TextEditingController _nameController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          'Изменитe свое имя'.s(22).w(600).sfDisplay(),
          const SizedBox(height: 20),
          Form(
            key: _formKey,
            child: TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Имя',
                hintText: 'Введите свое имя',
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
                ),
                prefixIcon:  const Icon(CupertinoIcons.person),
              ),
              textCapitalization: TextCapitalization.words,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Пожалуйста, введите имя';
                }
                return null;
              },
              autofocus: true,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child:
                  'Отмена'.s(16).w(400).sfDisplay().c(context.colors.primary),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.onNameSaved(_nameController.text.trim());
                    Navigator.of(context).pop();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colors.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child:
                  'Сохранить'.s(16).w(500).sfDisplay().c(context.colors.onPrimary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}