
import 'dart:math';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  const CustomTextField({
    super.key,
    this.controller, this.hintText, this.readOnly, this.textAlign, this.keyboardType, this.prefixText, this.onPressed, this.suffixIcon, this.onChanged, this.fontSize, this.autoFocus
    
  });

  final TextEditingController? controller;
  final String? hintText;
  final bool? readOnly;
  final TextAlign? textAlign;
  final TextInputType? keyboardType;
  final String? prefixText;
  final VoidCallback? onPressed;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final double? fontSize;
  final bool? autoFocus;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onPressed,
      controller: controller,
      readOnly: readOnly ?? false,
      textAlign: textAlign ?? TextAlign.center,
      keyboardType: readOnly == null ? keyboardType : null,
      onChanged: onChanged,
      style: TextStyle(fontSize: fontSize),
      autofocus: autoFocus ?? false,
      decoration: InputDecoration(
      filled: true,
      fillColor: Colors.blueGrey, 
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)) // 둥근 모서리
      ),
        isDense: false,
        prefixText: prefixText,
        suffix: suffixIcon,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[300]),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color:Colors.blue[300]!),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color:Colors.blue[300]!, width: 2),
        )
      ),

      );
    }
  }

