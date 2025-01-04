import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double? fontSize;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.fontSize
    
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0)
        ),
        ),
        child: Text(text,style:TextStyle(fontSize: fontSize ?? 18),
        )
        ),
    );
  }
}

class CustomOutlinedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double? fontSize;
  const CustomOutlinedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.fontSize
  });

  @override
  Widget build(BuildContext context) {
        return Container(
      width: 300,
      height: 50,
      child: OutlinedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0)
        ),
        ),
        child: Text(text,style:TextStyle(fontSize: fontSize ?? 18),
        )
        ),
    );
  }
}