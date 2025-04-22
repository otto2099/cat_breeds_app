import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final Widget? sufixIcon;
  final double? width;
  final double? height;
  final Color borderColor;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Function(String) onChanged;
  final String? Function(String?) validator;
  final Color? color;
  final int? maxLength;
  const CustomTextField({
    required this.controller,
    required this.hint,
    this.sufixIcon,
    this.width = 320,
    this.height = 40,
    this.borderColor = Colors.white,
    this.obscureText = false,
    this.keyboardType,
    super.key,
    required this.onChanged,
    required this.validator,
    this.color,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextFormField(
        onChanged: onChanged,
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: validator,
        cursorColor: Colors.black,
        maxLength: maxLength,
        style: TextStyle(
          color: color ?? Colors.black,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
          suffixIcon: sufixIcon,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          errorStyle: const TextStyle(
            height: 0,
            fontSize: 10,
          ),
          errorMaxLines: 230,
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
