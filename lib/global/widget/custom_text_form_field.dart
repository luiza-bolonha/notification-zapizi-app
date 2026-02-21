
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? label;
  final String? hint;
  final TextEditingController controller;
  final Widget? prefixIcon;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;

  const CustomTextFormField({
    super.key,
    this.label,
    this.hint,
    this.prefixIcon,
    this.textInputAction,
    this.textInputType,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(15),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        cursorColor: Colors.grey,
        textInputAction: textInputAction,
        keyboardType: textInputType,
        obscureText: obscureText,
        validator: validator,
        style: const TextStyle(
            fontSize: 15,
            color: Colors.grey
        ),
        decoration: InputDecoration(
            label: label != null ? Text(
              label!,
            ): null,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            hintText: hint,
            labelStyle: const TextStyle(
                fontSize: 15,
                color: Colors.grey
            ),
            hintStyle: const TextStyle(
                fontSize: 15,
                color: Colors.grey
            ),
            fillColor: Colors.white,
            hoverColor: Colors.white,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none
            ),
        ),
      ),
    );
  }
}