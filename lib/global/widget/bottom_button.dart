import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../style/app_theme.dart';


class BottomButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final Color? color;

  const BottomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(color ?? colorScheme.primary),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  )
              )
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white
            ),
          )
      ),
    );
  }
}