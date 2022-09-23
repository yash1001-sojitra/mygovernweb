import 'package:flutter/material.dart';

class CustomDecoration {
  static InputDecoration textFormFieldDecoration(String hint) {
    return InputDecoration(
      border: InputBorder.none,
      hintText: hint,
      fillColor: Colors.grey,
      label: Text(hint),
    );
  }

  static BoxDecoration get containerCornerRadiusDecoration {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.grey.shade200,
      border: Border.all(color: Colors.white54),
    );
  }
}
