import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  const MyElevatedButton(
      {super.key,
      required this.theme,
      required this.function,
      required this.text});
  final ThemeData theme;
  final void Function() function;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shadowColor: theme.shadowColor, // ボタンの影の色
        elevation: 10, // 影の深さを設定
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // ボタンの角を丸く
        ),
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      ),
      onPressed: function,
      child: Text(text),
    );
  }
}
