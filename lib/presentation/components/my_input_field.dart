import 'package:flutter/material.dart';

import '../../app/resources/styles_manger.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    Key? key,
    this.style,
    this.hintText,
    this.focusNode,
    this.onSubmitted,
    this.onChanged,
  }) : super(key: key);
  final TextStyle? style;
  final String? hintText;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: style ?? getRegularStyle(color: Colors.white),
      decoration: InputDecoration(
          hintStyle: style ?? getRegularStyle(color: Colors.white),
          hintText: hintText,
          contentPadding: const EdgeInsets.only(top: 6, left: 12),
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(12),
              gapPadding: 6),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(12),
              gapPadding: 6),
          fillColor: Colors.blue.shade100.withOpacity(.2),
          filled: true),
      focusNode: focusNode,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
    );
  }
}
