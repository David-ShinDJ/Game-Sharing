
import 'dart:math';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  const CustomTextField({
    super.key,
    required this.controller, required this.keyboardType, this.hintText, this.textAlign, this.prefixText, this.suffixIcon, this.fontSize, 
    this.autoFocus,
    this.obscureText, this.onChanged, this.validator
  });

  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? hintText;
  final TextAlign? textAlign;
  final String? prefixText;
  final Widget? suffixIcon;
  final double? fontSize;
  final bool? autoFocus;
  final bool? obscureText;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textAlign: textAlign ?? TextAlign.center,
      validator: validator,
      onChanged: onChanged,
      keyboardType: keyboardType,
      style: TextStyle(fontSize: fontSize),
      autofocus: autoFocus ?? false,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200], 
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10.0)
        ),
        isDense: false,
        prefixText: prefixText,
        suffix: suffixIcon,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.brown),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color:Colors.grey[300]!),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color:Colors.grey[300]!, width: 2),
        )
        ),
      );
    }
  }

