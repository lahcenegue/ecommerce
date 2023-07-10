import 'package:flutter/material.dart';

Widget customTextFormField({
  Function(String)? onChanged,
  String? Function(String?)? validator,
  required TextInputType? keyboardType,
  required IconData? prefixIcon,
  required String? hintText,
  int? maxLine,
  Widget? suffixIcon,
  bool obscureText = false,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 20),
    child: TextFormField(
      onChanged: onChanged,
      validator: validator,
      keyboardType: keyboardType,
      minLines: maxLine ?? 1,
      maxLines: maxLine ?? 1,
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(8),
        prefixIcon: Icon(
          prefixIcon,
          color: Colors.black,
        ),
        suffixIcon: suffixIcon,
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.blue,
          ),
          borderRadius: BorderRadius.circular(08.0),
        ),
        hintText: hintText,
      ),
    ),
  );
}
